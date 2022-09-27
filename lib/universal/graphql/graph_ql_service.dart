import 'dart:convert';
import 'dart:developer';
import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_client_service.dart';
import 'graphql_exceptioions.dart';

enum RequestType { query, mutation }

abstract class GraphQlService<S extends JsonResponseModel>
    implements ServiceGQL {
  final String query;
  final RequestType requestType;
  final String baseUrl;
  final String? token;
  final bool? enableCache;
  final Map<String, String>? header;
  late GraphQLClientService service;
  final FetchPolicy? fetchPolicy;
  final MemoryType? memoryType;
  String? content;
  String? errorMessage;

  GraphQlService({
    required this.query,
    this.enableCache = false,
    required this.baseUrl,
    this.token,
    this.memoryType,
    this.fetchPolicy,
    this.header,
    required this.requestType,
  }) {
    service = GraphQLClientService(
        enableCache: enableCache,
        baseUrl: baseUrl,
        token: token,
        fcPolicy: fetchPolicy);
  }

  @override
  Future<Either<ServiceFailure, S>> request() async {
    if (await Locator().connectivity.getConnectivityStatus() ==
        ConnectivityStatus.offline) {
      Locator().logger.debug('JsonService response no connectivity error');
      return Left(NoConnectivityServiceFailure("Network Error"));
    }

    S model;

    switch (requestType) {
      case RequestType.query:
        {
          QueryResult result = await service.performQuery(query);
          await setContent(result);
        }
        break;

      case RequestType.mutation:
        {
          QueryResult result = await service.performMutation(query);
          await setContent(result);
        }
    }

    try {
      if (errorMessage != null)
        return Left(GeneralServiceFailure(errorMessage ?? ""));
      final Map<String, dynamic> jsonResponse =
          (content == null || content!.isEmpty)
              ? {}
              : json.decode(content!) ?? <String, dynamic>{};
      model = parseResponse(
          jsonResponse, errorMessage != null ? true : false, errorMessage);

      return Right(model);
    } on Exception catch (e) {
      Locator()
          .logger
          .error('JsonService response parse exception', e.toString());
    }
    return Left(GeneralServiceFailure("General Error"));
  }

  Future<void> setContent(QueryResult result) async {
    content = result.data != null ? jsonEncode(result.data) : null;
    errorMessage = result.data == null && result.hasException
        ? (result.exception!.graphqlErrors.isNotEmpty
            ? result.exception!.graphqlErrors[0].message
            : "Some error accrued")
        : null;
  }

  bool isRequestModelJsonValid(Map<String, dynamic> json) {
    try {
      if (json.isEmpty || _jsonContainsNull(json)) return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  bool _jsonContainsNull(Map<String, dynamic> json) {
    bool containsNull = false;
    List values = json.values.toList();
    for (int i = 0; i < values.length; i++) {
      if (values[i] is Map)
        containsNull = _jsonContainsNull(values[i]);
      else if (values[i] == null) containsNull = true;
      if (containsNull) break;
    }
    return containsNull;
  }

  S parseResponse(
      Map<String, dynamic> jsonResponse, bool hasError, String? errorMessage);

  ServiceFailure onError(
      RestResponseType responseType, Map<String, dynamic> jsonResponse) {
    return GeneralServiceFailure("General Error");
  }
}

abstract class ServiceGQL {
  Future<void> request();
}
