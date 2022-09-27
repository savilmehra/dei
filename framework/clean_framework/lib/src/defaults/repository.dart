import 'package:clean_framework/src/bloc/service_adapter.dart';
import 'package:clean_framework/src/model/entity.dart';

class RepositoryScope<E extends Entity> {
  Function(dynamic) subscription;

  RepositoryScope(this.subscription);
}

class Repository {
  final Map<RepositoryScope, Entity> _scopes = {};

  RepositoryScope create<E extends Entity>(
    E entity,
    Function(dynamic) subscription, {
    bool deleteIfExists = false,
  }) {
    for (final scope in _scopes.keys) {
      if (_scopes[scope] is E) {
        if (deleteIfExists) {
          _scopes.remove(scope);
        } else {
          return scope..subscription = subscription;
        }
        break;
      }
    }

    final scope = RepositoryScope(subscription);
    _scopes[scope] = entity;
    return scope;
  }

  void update<E extends Entity>(RepositoryScope scope, E entity) {
    if (_scopes[scope] == null) throw _entityNotFound;
    _scopes[scope] = entity;
  }

  E get<E extends Entity>(RepositoryScope scope) {
    final entity = _scopes[scope];

    if (entity == null) throw _entityNotFound;
    return entity as E;
  }

  Future<void> runServiceAdapter(
    RepositoryScope scope,
    ServiceAdapter adapter,
  ) async {
    final entity = _scopes[scope];
    if (entity == null) throw _entityNotFound;
    _scopes[scope] = await adapter.query(entity);
    scope.subscription(_scopes[scope]);
  }

  RepositoryScope? containsScope<E extends Entity>() {
    for (final scope in _scopes.entries) {
      if (scope.value is E) return scope.key;
    }
    return null;
  }

  Never get _entityNotFound =>
      throw StateError('Entity not found for that scope.');
}
