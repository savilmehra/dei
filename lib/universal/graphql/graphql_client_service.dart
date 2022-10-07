import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'graphql_exceptioions.dart';

enum MemoryType { hive, inMemory }

class GraphQLClientService {
  late GraphQLClient _client;
  FetchPolicy? fetchPolicy;
  MemoryType memoryType;
  late bool enableCache;

  GraphQLClientService(
      {required String baseUrl,
      bool? enableCache,
      String? token,
      this.memoryType = MemoryType.inMemory,
      Map<String, String>? headers,
      FetchPolicy? fcPolicy}) {
    var link;

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );
    final HttpLink _httpLink = HttpLink(baseUrl,
        useGETForQueries: enableCache ?? false,
        defaultHeaders: headers ?? {});

    link = token == null ? _httpLink : authLink.concat(_httpLink);
    fetchPolicy = fcPolicy;
    enableCache = enableCache ?? false;
    _client = GraphQLClient(
      cache: memoryType==MemoryType.inMemory
          ? GraphQLCache(store: InMemoryStore())
          : GraphQLCache(store: HiveStore()),
      link: link,
    );
  }

  Future<QueryResult> performQuery(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    final options = QueryOptions(
      document: gql(query),
      fetchPolicy: fetchPolicy,
    );

   //  print("------------------------------$query");
    QueryResult? result = await _client.query(options);
   //  log(jsonEncode(result.data));
    return result;
  }

  Future<QueryResult> performMutation(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
   // log(query);
    final options = MutationOptions(
      document: gql(query),
      fetchPolicy: fetchPolicy,
    );
    QueryResult? result = await _client.mutate(options);
     // log(result .toString());
    return result;
  }


  static QueryResult _handleExceptions(QueryResult result) {
    if (result.hasException) {
      final operationException = result.exception!;
      final linkException = operationException.linkException;

      if (linkException is NetworkException) {
        throw GraphQLNetworkException(
          message: linkException.message,
          uri: linkException.uri,
        );
      } else if (linkException is ServerException) {
        throw GraphQLServerException(
          originalException: linkException.originalException,
          errorData: linkException.parsedResponse?.data,
        );
      }

      /*  throw GraphQLOperationException(
        errors: operationException.graphqlErrors.map(
              (e) => GraphQLOperationError.from(e),
        ),
      );*/
    }

    return result;
  }

}
