import 'dart:convert';

import 'package:dei/features/home/fielSpinResponse.dart';
import 'package:dei/features/home/ui/webview_new.dart';
import 'package:dei/features/home/ui/webview_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/product_card.dart';
import '../../../universal/authentication/local_authentication.dart';
import '../../../universal/graphql/graph_ql_service.dart';
import '../../../universal/localization.dart';
import '../../../utilities/size_config.dart';
import '../../app_settings/language_setting_page.dart';
import '../../app_settings/theme_settings_page.dart';


import '../../products_showcase/api/product_quries.dart';
import '../../products_showcase/bloc/product_cubit.dart';

import '../../products_showcase/db/sync_client_outbox.dart';
import '../../products_showcase/ui/product_showcase_presenter.dart';
import '../../products_showcase/ui/product_showcase_widget.dart';

class GalleryImages extends StatefulWidget {
  static String routeName = '/GalleryImages';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<GalleryImages> {
  final ImagePicker _picker = ImagePicker();
  late ProductCubit cubit;
  var outBoxHelper = GetIt.instance<ObjectBoxSyncClient>();
  late AuthenticationService authenticationService;
  late BuildContext ctx;
  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductCubit>();
    authenticationService = AuthenticationService(isAuthenticated: (isAuth) {
      if (!isAuth) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(

              actions: [
                TextButton(
                  onPressed: () {

                    SystemNavigator.pop();
                  },
                  child: const Text("Cancel"),)
                ,
                TextButton(
                  onPressed: () {
                    authenticationService.checkSupport();
                    Navigator.pop(context);
                  }, child: Text("Unlock"),
                )
              ],
              title: const Text(
                'Authentication Failed',
                style: TextStyle(color: Colors.blue,fontSize: 18),
              ),
              content: const Text(
                  'Please Authenticate Yourself or Connect to internet '),
            ));
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) =>   addData());
  }


  addData()
  async {

    String data = await DefaultAssetBundle.of(context).loadString("lib/assets/data.json");
    final jsonResult = FileSpinResponse.fromJson(jsonDecode(data));
    outBoxHelper.insert(jsonResult.files??[]);
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text( "Images Gallery"),

        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: getProportionateScreenHeight(50)),

                  BlocProvider(
                    create: (_) => cubit,
                    child: ProductShowCasePresenter(
                      listType: ListType.grid,
                      title:"Click To Edit on any image",
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
