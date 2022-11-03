import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../objectbox.g.dart';
import '../../home/fielSpinResponse.dart';

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
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
001-15:33:54.9943 [INFO ] [SySvAp] Starting ObjectBox Sync Server version 2 (protocol version: 3, core: 2.9.2-2021-05-13 (Sync))
001-15:33:55.0022 [INFO ] [SySvAp] Default configuration file sync-server-config.js not found
001-15:33:55.0045 [INFO ] [SvrMsg] Registering server transport for ws
001-15:33:55.5290 [INFO ] [SySvAp] Model file ./data/objectbox-model.json loaded, it has 5184 bytes
001-15:33:55.5420 [INFO ] [SySvAp] Given model was found by hash as an existing schema version ID 1
001-15:33:55.5422 [INFO ] [SySvAp] Starting the server with schema version ID 1
001-15:33:55.5649 [INFO ] [SvrUws] UwsServer listening on all interfaces, port 9999 without SSL
001-15:33:55.5658 [WARN ] [SvSync] UNSECURED no-authentication mode enabled - every client allowed without any validation
001-15:33:55.5713 [INFO ] [SvSync] Started on port 9999
001-15:33:55.5714 [INFO ] [SySvAp] Starting object browser on 0.0.0.0:9980
001-15:33:55.5733 [INFO ] [HttpSv] Running in single-store mode with an already opened store
001-15:33:55.5736 [INFO ] [HttpSv] Listening on 0.0.0.0:9980
001-15:33:55.5737 [WARN ] [HttpSv] UNSECURED no-authentication mode enabled:
!!! Allowing access to anyone without any user validation
!!! After e.g. adjusting user logins, please restart asap to secure the server again
001-15:33:55.5737 [INFO ] [HttpSv] User management: enabled
001-15:33:55.5809 [INFO ] [HttpSv] HttpServer listening on all interfaces, port 9980
001-15:33:55.5829 [INFO ] [SySvAp] ObjectBox sync server started in 589 ms





WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
001-15:40:33.8628 [INFO ] [SvSyAp] Starting ObjectBox Sync Server version 3 (protocol version: 4, core: 3.3.1-2022-10-14 (SyncServer, admin, tree, dlog))
001-15:40:33.8721 [INFO ] [SvSyAp] Loading configuration file ./data/sync-server-config.json
001-15:40:33.8785 [INFO ] [SvrMsg] Registering server transport for ws
001-15:40:34.3985 [INFO ] [SvSyAp] Model file ./data/objectbox-model.json loaded, it has 5184 bytes
001-15:40:34.4096 [INFO ] [SvSyAp] Given model was found by hash as an existing schema version ID 1
001-15:40:34.4098 [INFO ] [SvSyAp] Starting the server with schema version ID 1
001-15:40:34.4286 [INFO ] [SvWbSo] Initializing for all interfaces, port 9999 without SSL
001-15:40:34.4307 [WARN ] [SvSync] <9C3A> UNSECURED no-authentication mode enabled - every client allowed without any validation
001-15:40:34.4357 [INFO ] [SvClst] <9C3A> Starting 9C3A923C as part of cluster "cluster-born" (fixed follower); sequence committed: 0-0-00000000, draft: same
001-15:40:34.4374 [INFO ] [SvClst] <9C3A> Starting 1 peer(s) connections...
001-15:40:34.4455 [INFO ] [ClTxAQ] <9C3A> Incoming TXs will be announced (non-quiet mode)
001-15:40:34.4495 [INFO ] [SvClCl] Peer #1 started (state sequence: 0/0/1)
001-15:40:34.4535 [INFO ] [SvSync] <9C3A> Started on port 9999 (peer ID: 9C3A923C)
001-15:40:34.4550 [INFO ] [SvSync] <9C3A> Cluster ID: cluster-born
001-15:40:34.4553 [INFO ] [SvSyAp] Starting admin server on http://0.0.0.0:9980
001-15:40:34.4615 [INFO ] [SvHttp] Running in single-store mode with an already opened store
001-15:40:34.4616 [INFO ] [SvHttp] Listening on http://0.0.0.0:9980
001-15:40:34.4617 [WARN ] [SvHttp] UNSECURED no-authentication mode enabled:
!!! Allowing access to anyone without any user validation
!!! After e.g. adjusting user logins, please restart asap to secure the server again
001-15:40:34.4617 [INFO ] [SvHttp] User management: enabled
001-15:40:34.4688 [INFO ] [SvHttp] HttpServer listening on all interfaces, port 9980
001-15:40:34.4717 [INFO ] [SvSyAp] ObjectBox sync server started in 609 ms
*/

/*
docker run --rm -it \
    --volume $(pwd):/data   \
      --publish 127.0.0.1:9999:9999  \
   --publish 127.0.0.1:9980:9980   \
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
//flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 //   ./sync-server --model=objectbox-model.json  --conf sync-server-config.json --unsecured-no-authentication --debug
//https://www.guru99.com/the-vi-editor.html
class ObjectBoxSyncClient {
  Store? _store;
  Store? _storeCLoud;
  Box<FileSpinFiles>? productBox;
  Box<FileSpinFiles>? productBoxCLoud;
  final syncServerIp = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  late Stream<List<FileSpinFiles>?> stream;

  ObjectBoxSyncClient() {
    getApplicationDocumentsDirectory().then((dir) {

      print(join(dir.path, 'objectbox'));
      openStore(
        directory: join(dir.path, 'objectbox'),
      ).then((Store store) {
        _store = store;
        Sync.client(
          store,
          'ws://35.154.207.75:9999',
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
    //  productBoxCLoud!.put(item);
    return productBox!.put(item);
  }

  Future<List<int>> insert(List<FileSpinFiles> products) async {
    // productBox!.putMany(products);
    return productBox!.putMany(products);
  }

  Future<bool> delete(int sku) async {

      return productBox!.remove(sku);

  }

  Future<List<FileSpinFiles>?> queryAll() async {
    return productBox!.getAll();
  }


}
