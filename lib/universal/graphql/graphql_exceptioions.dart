import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GraphQLServiceException {}

class GraphQLOperationException implements GraphQLServiceException {
  GraphQLOperationException({required this.errors});

  final Iterable<GraphQLOperationError> errors;

  GraphQLOperationError? get error => errors.isEmpty ? null : errors.first;
}
class GraphQLOperationError {
  GraphQLOperationError._({
    required this.message,
    required this.locations,
    required this.path,
    required this.extensions,
  });

  factory GraphQLOperationError.from(GraphQLError error) {
    return GraphQLOperationError._(
      message: error.message,
      locations: error.locations,
      path: error.path,
      extensions: error.extensions,
    );
  }

  /// Error message
  final String message;

  /// Locations of the nodes in document which caused the error
  final List<ErrorLocation>? locations;

  /// Path of the error node in the query
  final List<dynamic /* String | int */ >? path;

  /// Implementation-specific extensions to this error
  final Map<String, dynamic>? extensions;
}

class GraphQLNetworkException implements GraphQLServiceException {
  GraphQLNetworkException({
    required this.message,
    required this.uri,
  });

  final String? message;
  final Uri? uri;

  @override
  String toString() {
    return 'GraphQlNetworkException: $message; uri = $uri';
  }
}

class GraphQLServerException implements GraphQLServiceException {
  GraphQLServerException({
    required this.originalException,
    required this.errorData,
  });

  final Object? originalException;
  final Map<String, dynamic>? errorData;

  @override
  String toString() {
    return 'GraphQLServerException{originalException: $originalException, errorData: $errorData}';
  }
}

class GraphQLTimeoutException implements GraphQLServiceException {}