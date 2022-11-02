import 'package:dei/features/home/ui/webview_new.dart';
import 'package:dei/features/home/ui/webview_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../products_showcase/model/products_response.dart';
import '../../products_showcase/ui/product_showcase_presenter.dart';
import '../../products_showcase/ui/product_showcase_widget.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';

  @override
  ThemeSettingsPageState createState() => ThemeSettingsPageState();
}

class ThemeSettingsPageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  late ProductCubit cubit;

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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.trans("home")),
          actions: [
            IconButton(
                onPressed: () {
                  cubit.insert(
                      requestType: RequestType.query,
                      header: {'Store': 'english'},
                      queryString: searchQuery("watch", 4),
                      token: '4vuve1vw4gcf1b09u7gmzetz8vdkevua',
                      getData: () {});
                },
                icon: Icon(Icons.upload))
          ],
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: getProportionateScreenHeight(50)),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return getCard(context, index);
                },
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              BlocProvider(
                create: (_) => cubit,
                child: ProductShowCasePresenter(
                  listType: ListType.grid,
                  title:AppLocalizations.of(context)!.trans("home"),
                  listItem: getListItem,
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
            ]))
          ],
        ));
  }

  Widget getCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        index == 0
            ? Navigator.pushNamed(
                context,
                ThemeSettingsPage.routeName,
              )
            : index == 1
                ? Navigator.pushNamed(
                    context,
          ExampleBrowser.routeName,
                  )
                : Navigator.pushNamed(
                    context,
                    LanguageSettingPage.routeName,
                  );
      },
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Text(
            index == 0
                ? AppLocalizations.of(context)!.trans("theme_setting")
                : index == 1
                    ? AppLocalizations.of(context)!.trans("web_view")
                    : index == 3
                        ? "Authentication"
                        : AppLocalizations.of(context)!.trans("language"),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget getListItem(Items data) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(4)),
      child: ProductCard(product: data),
    );
  }
}
