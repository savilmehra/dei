import 'dart:convert';
import 'dart:io';

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
class ObjectBoxSyncClient {
  Store? _store;
  Box<Items>? productBox;
  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  late Stream<List<Items>?> stream;

  ObjectBoxSyncClient() {
    openStore().then((Store store) {
      _store = store;
      Sync.client(
        store,
        'ws://$syncServerIp:9999',

        /// replace with server URI when server is available
        SyncCredentials.none(),
      ).start();
      productBox = store.box<Items>();
      stream = productBox!
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
    });
  }

  Future<int> update(Items item) async {
    return productBox!.put(item);
  }

  Future<List<int>> insert(List<Items> products) async {
    return productBox!.putMany(products);
  }

  Future<bool> delete(int id) async {
    return productBox!.remove(id);
  }

  Future<List<Items>?> queryAll() async {
    return productBox!.getAll();
  }
}
