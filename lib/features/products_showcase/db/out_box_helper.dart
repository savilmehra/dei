import 'dart:convert';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../objectbox.g.dart';

import '../model/products_response.dart';
import 'package:objectbox/objectbox.dart';

/// return all entities matching the query
/// query.find();

/// return only the first result or null if none
///query.findFirst();

/// return the only result or null if none, throw if more than one result
///query.findUnique();

///To remove all objects matching a query, call query.remove() .

/// offset by 10, limit to at most 5 results
///   ..offset = 10
///   ..limit = 5;
///   List<String> emails = query.property(User_.email).find(); just to find list of particular variable
class OutBoxHelper {
  late Store _store;

  late Stream<List<Items>?> stream;

  OutBoxHelper() {
    getApplicationDocumentsDirectory().then((value) {
      _store = Store(getObjectBoxModel(),
          directory: join(value.path, "PRODUCT_TABLE"));

      stream = _store
          .box<Items>()
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }
  Future<int> update(Items item) async {
    return _store.box<Items>().put(item);
  }


  Query<Items?> checkIfObjectAlreadyStored(int id) {
    return _store.box<Items>().query(Items_.id.equals(id)).build();
  }

  Future<List<int>> insert(List<Items> products) async {

    return _store.box<Items>().putMany(products);
  }

  Future<bool> delete(int id) async {
    return _store.box<Items>().remove(id);
  }

  Future<List<Items>?> queryAll() async {
    return _store.box<Items>().getAll();
  }
}
