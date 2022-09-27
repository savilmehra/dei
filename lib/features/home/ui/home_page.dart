import 'package:dei/features/home/ui/webview_page.dart';
import 'package:dei/universal/themes/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/product_card.dart';
import '../../../utilities/size_config.dart';
import '../../../utilities/string_constatnts.dart';
import '../../app_settings/language_setting_page.dart';
import '../../app_settings/theme_settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../products_showcase/bloc/product_cubit.dart';
import '../../products_showcase/model/products_response.dart';
import '../../products_showcase/ui/product_showcase_presenter.dart';
import '../../products_showcase/ui/product_showcase_widget.dart';
class HomePage extends StatefulWidget {
  static String routeName = '/home';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).home),
      ),
      body:

      CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: getProportionateScreenHeight(50)),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return getCard(context, index);
                  },
                ),
                SizedBox(height: getProportionateScreenWidth(30)),

                BlocProvider(
                  create: (_) => ProductCubit(),
                  child: ProductShowCasePresenter(
                    listType: ListType.grid,
                    title: AppLocalizations.of(context).home,
                    listItem: getListItem,
                  ),
                ),

                SizedBox(height: getProportionateScreenWidth(30)),
              ]))
        ],
      )



    );
  }

  Widget getCard(BuildContext context, int index) {
    return InkWell(
      onTap: (){
      index==0?  Navigator.pushNamed(
          context,
        ThemeSettingsPage.routeName,
        ):
      index==1?

      Navigator.pushNamed(
        context,
        WebViewPage.routeName,
      )
     :

      Navigator.pushNamed(
        context,
        LanguageSettingPage.routeName ,
      )


      ;
      },
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Center(child: Text(index == 0
            ?AppLocalizations.of(context).theme_setting
            : index == 1
            ? AppLocalizations.of(context).web_view
            :  AppLocalizations.of(context).language,textAlign: TextAlign.center,),),
      ),
    );
  }
  Widget getListItem(Items data) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(4)),
      child: ProductCard(
          product: data),
    );
  }
}
