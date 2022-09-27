
import 'package:clean_framework/src/model/entity.dart';

import 'graph_ql_service_adapter.dart';
typedef RepositorySubscription<T> = void Function(T);
class RepositoryScope<E extends Entity> {
  RepositorySubscription<E> subscription;

  RepositoryScope(this.subscription);
}

class RepositoryGraphql {
  final Map<RepositoryScope, Entity> _scopes = {};

  RepositoryScope create<E extends Entity>(
      E entity,
      RepositorySubscription<E> subscription, {
        bool deleteIfExists = false,
      }) {
    for (final scope in _scopes.keys) {
      if (_scopes[scope] is E) {
        if (deleteIfExists) {
          _scopes.remove(scope);
        } else {
          return scope..subscription = subscription as RepositorySubscription;
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
      ServiceAdapterGraphQl adapter,
      ) async {
    final entity = _scopes[scope];
    if (entity == null) throw _entityNotFound;
    _scopes[scope] = await adapter.query(entity);
    scope.subscription(entity);
  }

  RepositoryScope? containsScope<E extends Entity>() {
    for (final scope in _scopes.entries) {
      if (scope.value is E) return scope.key;
    }
  }

  Never get _entityNotFound =>
      throw StateError('Entity not found for that scope.');
}
