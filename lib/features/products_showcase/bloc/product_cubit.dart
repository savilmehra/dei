import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:dei/features/products_showcase/bloc/product_adapter.dart';
import 'package:dei/features/products_showcase/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../locator.dart';
import '../../../universal/graphql/graph_ql_service.dart';
import '../../../universal/graphql/repository_graphql.dart';

import '../db/out_box_helper.dart';
import '../db/sync_client_outbox.dart';
import '../model/product_entity.dart';
import '../model/products_response.dart';

class ProductCubit extends Cubit<MainState> implements UseCase {
  late RepositoryScope scope;
  var outBoxHelper = GetIt.instance<ObjectBoxSyncClient>();

  ProductCubit() : super(LoadingState()) {
    scope = ApplicationLocator()
        .repositoryGql
        .create<ProductEntity>(ProductEntity(), _notifySubscribers);
    listenStream();
  }

  listenStream() {

    if( outBoxHelper.stream!=null) {
      outBoxHelper.stream.listen((entity) async {

      print("sync called");
      if (entity == null || entity.isEmpty) {
        emit(EmptyState("No data Found"));
      } else {
        emit(LoadedState(products: entity));
      }
    });
    }
  }

  insert(
      {String? token,
      Map<String, String>? header,
      required RequestType requestType,
      required String queryString,
      required Function() getData}) async {
    await ApplicationLocator().repositoryGql.runServiceAdapter(
        scope,
        ProductAdapter(token, header,
            requestType: RequestType.query, queryString: queryString));
  }

  Future<void> getLocalData() async {
    var entity = await outBoxHelper.queryAll();
    if (entity != null && entity.isNotEmpty) {
      emit(LoadedState(products: entity));
    }
  }

  void _notifySubscribers(entity) {
    ProductEntity entity = ApplicationLocator().repositoryGql.get(scope);

    if (entity.data.products != null) {
      outBoxHelper.insert(entity.data.products!.items!);
    }
  }

  deleteItem(Items item) async {
    /* item.name="Savils watch";
    await  outBoxHelper.update(item);
*/

    print('${item.id} item id to delete');
    await outBoxHelper.delete(item.sku??"");
  }
}


/*

{
"dbDirectory": "objectbox",
"dbMaxSize": "10G",
"modelFile": "objectbox-model.json",
"bind": "ws://0.0.0.0:9999",
"browserBind": "http://35.154.207.75:9980",
"browserThreads": 4
}*/
