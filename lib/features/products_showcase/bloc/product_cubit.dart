import 'package:clean_framework/clean_framework.dart';
import 'package:dei/features/products_showcase/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../universal/graphql/repository_graphql.dart';

import '../db/sync_client_outbox.dart';
import '../models/fielSpinResponse.dart';


class ProductCubit extends Cubit<MainState> implements UseCase {
  late RepositoryScope scope;
  var outBoxHelper = GetIt.instance<ObjectBoxSyncClient>();
  ProductCubit() : super(LoadingState()) {
    listenStream();
  }
  listenStream() async {

    if( outBoxHelper.stream!=null) {
      outBoxHelper.stream.listen((entity) async {
        if (entity == null || entity.isEmpty) {
        emit(EmptyState("No data Found"));
      } else {
        emit(LoadedState(products: entity));
      }
    });

    }
  }
  Future<void> getLocalData() async {
    var entity = await outBoxHelper.queryAll();
    if (entity != null && entity.isNotEmpty) {
      emit(LoadedState(products: entity));
    }
  }
  update(FileSpinFiles item) async {
    await  outBoxHelper.update(item);
  }
  deleteItem(FileSpinFiles item) async {
    await outBoxHelper.delete(item.ids??0);
  }
}

