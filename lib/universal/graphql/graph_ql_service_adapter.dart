import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/src/defaults/either_service.dart';
import 'package:clean_framework/src/defaults/json_service.dart';

import 'graph_ql_service.dart';



abstract class ServiceAdapterGraphQl<E extends Entity,
M extends JsonResponseModel, S extends GraphQlService< M>> {
  final S _service;

  ServiceAdapterGraphQl(S service) : _service = service;

  Future<Entity> query(E initialEntity) async {
    final eitherResponse =
    await _service.request();
    return eitherResponse
        .fold((error) => createEntityWithError(initialEntity, error),
            (responseModel) {
          final errorClearedEntity = initialEntity.merge(errors: <EntityFailure>[]);
          return createEntity(errorClearedEntity as E, responseModel);
        });
  }

  E createEntity(E initialEntity, M responseModel);
  E createEntityWithError(E initialEntity, ServiceFailure error) {
    if (error is NoConnectivityServiceFailure) {
      return initialEntity.merge(errors: [NoConnectivityEntityFailure(errorMsg:error.errorMessage)]) as E;
    }
    return initialEntity.merge(errors: [GeneralEntityFailure(errorMsg: error.errorMessage)]) as E;
  }


}
