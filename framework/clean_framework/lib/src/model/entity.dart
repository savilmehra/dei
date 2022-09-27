import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Entity extends Equatable {
  final List<EntityFailure> errors;

  @override
  bool get stringify => true;

  Entity({this.errors = const []});
  bool hasErrors() => errors.isNotEmpty;
  bool hasError(EntityFailure error) => errors.indexOf(error) > 0;

  Entity merge({List<EntityFailure>? errors}) {
    return Entity(errors: errors ?? this.errors);
  }

  @override
  List<Object?> get props => [errors];
}

class EntityFailure extends Equatable {
  final String errorMessage;
  const EntityFailure({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class GeneralEntityFailure extends EntityFailure {

  final String errorMsg;
  const GeneralEntityFailure({required this.errorMsg}):super(errorMessage:errorMsg);
}

class NoConnectivityEntityFailure extends EntityFailure {
  final String errorMsg;
  const NoConnectivityEntityFailure({required this.errorMsg}) : super(errorMessage:errorMsg);
}
