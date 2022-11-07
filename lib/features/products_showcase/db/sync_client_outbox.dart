import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../objectbox.g.dart';

import 'package:objectbox/objectbox.dart';

import '../models/fielSpinResponse.dart';

class ObjectBoxSyncClient {
  Box<FileSpinFiles>? productBox;
  final syncServerIp = '35.154.207.75';
  late Stream<List<FileSpinFiles>?> stream;

  ObjectBoxSyncClient() {
    getApplicationDocumentsDirectory().then((dir) {

      openStore(
        directory: join(dir.path, 'objectbox'),
      ).then((Store store) {

        Sync.client(
          store,
          'ws://$syncServerIp:9999',
          SyncCredentials.none(),
        ).start();
        productBox = store.box<FileSpinFiles>();
        stream = productBox!
            .query()
            .watch(triggerImmediately: true)
            .map((event) => event.find());
      });
    });
  }

  Future<int> update(FileSpinFiles item) async {
    return productBox!.put(item);
  }

  Future<List<int>> insert(List<FileSpinFiles> products) async {
    return productBox!.putMany(products);
  }

  Future<bool> delete(int sku) async {
    return productBox!.remove(sku);
  }

  Future<List<FileSpinFiles>?> queryAll() async {
    return productBox!.getAll();
  }


}
