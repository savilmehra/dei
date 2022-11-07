import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/product_card.dart';
import '../../../universal/authentication/local_authentication.dart';
import '../../../utilities/size_config.dart';

import '../bloc/product_cubit.dart';

import '../db/sync_client_outbox.dart';
import '../models/fielSpinResponse.dart';
import 'product_showcase_presenter.dart';
import 'product_showcase_widget.dart';

class GalleryImages extends StatefulWidget {
  static String routeName = '/GalleryImages';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<GalleryImages> {
  late ProductCubit cubit;
  var outBoxHelper = GetIt.instance<ObjectBoxSyncClient>();
  late BuildContext ctx;
  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductCubit>();
  }

  addData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("lib/assets/data.json");
    final jsonResult = FileSpinResponse.fromJson(jsonDecode(data));
    outBoxHelper.insert(jsonResult.files ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cloud Images"),
          actions: [
            IconButton(
                onPressed: () {
                  addData();
                },
                icon: const Icon(Icons.upload))
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: getProportionateScreenHeight(10)),
              BlocProvider(
                create: (_) => cubit,
                child: ProductShowCasePresenter(
                  listType: ListType.grid,
                  title: "",
                  listItem: getListItem,
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
            ]))
          ],
        ));
  }

  Widget getListItem(FileSpinFiles data) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(4)),
      child: ProductCard(product: data),
    );
  }
}
