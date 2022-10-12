import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

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

///flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

class OutBoxHelper {
  Store? _store;
  Box<Items>? productBoxCLoud;
  late Stream<List<Items>?> stream;

  OutBoxHelper() {
 /*   getApplicationDocumentsDirectory().then((dir) {
      openStore(
        directory: join(dir.path, 'objectbox_cloud'),
      ).then((Store store) {
        _store = store;
        Sync.client(
          store,
          'ws://35.154.207.75:9999',
          SyncCredentials.none(),
        ).start();

        productBoxCLoud = store.box<Items>();
        productBoxCLoud!.removeAll();
         stream = productBoxCLoud!
            .query()
            .watch(triggerImmediately: true)
            .map((event) => event.find());
      });
    });*/
  }

  Future<int> update(Items item) async {

return    productBoxCLoud!.put(item);

  }

  Future<List<int>> insert(List<Items> products) async {

    return productBoxCLoud!.putMany(products);
  }

  Future<bool> delete(int id) async {
    return  productBoxCLoud!.remove(id);

  }

  Future<List<Items>?> queryAll() async {
    return productBoxCLoud!.getAll();
  }


}
