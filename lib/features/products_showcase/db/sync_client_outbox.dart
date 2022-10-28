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
//rm -rf data.mdb lock.mdb
/*For empty directories, use rmdir [dirname] or rm -d [dirname]
For non-empty directories, use rm -r [dirname]*/
/*Run any one of the following command on Linux to see open ports:
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo ss -tulpn | grep LISTEN
sudo lsof -i:22 ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here*/
/*
docker run --rm -it \
    --volume $(pwd):/data   \
      --publish 127.0.0.1:9991:9991  \
   --publish 127.0.0.1:9981:9981   \
     --user $UID\

       objectboxio/sync:sync-server-2022-10-21 \
       --model ./data/objectbox-model.json \
         --conf ./data/sync-server-config.json \
         --unsecured-no-authentication \
--debug



docker run --rm -it \
--volume $(pwd):/data \
     --publish 127.0.0.1:9991:9991  \
   --publish 127.0.0.1:9981:9981   \
--user $UID \
  objectboxio/sync:sync-server-2022-10-21 \
--model ./data/objectbox-model.json \
  --conf ./data/sync-server-config.json \
  --debug \
--unsecured-no-authentication \
--browser-bind 0.0.0.0:9980*/
// ssh -i /Users/born/Desktop/privatekey.pem  savil@35.154.207.75
//sudo netstat -tupln

 //   ./sync-server --model=objectbox-model.json --unsecured-no-authentication --debug
//https://www.guru99.com/the-vi-editor.html
class ObjectBoxSyncClient {
  Store? _store;
  Store? _storeCLoud;
  Box<Items>? productBox;
  Box<Items>? productBoxCLoud;
  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  late Stream<List<Items>?> stream;

  ObjectBoxSyncClient() {
    getApplicationDocumentsDirectory().then((dir) {
    /*  openStore(
        directory: join(dir.path, 'objectbox'),
      ).then((Store store) {
        _storeCLoud = store;
        Sync.client(
          store,
          'ws://35.154.207.75:9999',
          SyncCredentials.none(),
        ).start();
print("open-------------------------new ");
        productBox = store.box<Items>();

       stream = productBox!
            .query()
            .watch(triggerImmediately: true)
            .map((event) => event.find());

      });
*/
      openStore(
        directory: join(dir.path, 'objectbox'),
      ).then((Store store) {
        _store = store;
        Sync.client(
          store,
          'ws://35.154.207.75:9999',
          SyncCredentials.none(),
        ).start();
        productBox = store.box<Items>();
        stream = productBox!
            .query()
            .watch(triggerImmediately: true)
            .map((event) => event.find());
      });
    });
  }

  Future<int> update(Items item) async {

  //  productBoxCLoud!.put(item);
    return productBox!.put(item);
  }

  Future<List<int>> insert(List<Items> products) async {


   // productBox!.putMany(products);

    return productBox!.putMany(products);
  }

  Future<bool> delete(String sku) async {
    Query<Items> query=productBox!.query(Items_.sku.equals(sku)).build();

    Items ?items=query.findFirst();
    if(items!=null) {
      return productBox!.remove(items.id!);
    }
    return false;
  }

  Future<List<Items>?> queryAll() async {
    return productBox!.getAll();
  }


}
