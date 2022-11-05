import 'package:dei/features/home/ui/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../universal/graphql/graph_ql_service.dart';
import '../../home/fielSpinResponse.dart';
import '../../home/ui/home_page.dart';
import '../api/product_quries.dart';
import '../bloc/product_cubit.dart';
import '../bloc/states.dart';

import 'product_showcase_widget.dart';

class ProductShowCasePresenter extends StatefulWidget {
  final double? height;
  final ListType listType;
  final ListItem listItem;
  final String? title;

  ProductShowCasePresenter(
      {this.height,
      required this.listType,
      required this.listItem,
      this.title});

  @override
  ProductShowCasteState createState() => ProductShowCasteState();
}

class ProductShowCasteState extends State<ProductShowCasePresenter> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, MainState>(builder: (context, state) {
      return ProductShowCaseWidget(
        longpress: (FileSpinFiles item) {
        /*  item.name =
              ' ${DateTime.now().hour} :  ${DateTime.now().minute} :  ${DateTime.now().second}';
          BlocProvider.of<ProductCubit>(context).update(item);*/
        },
        callBack: (FileSpinFiles item) {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  WebViewPage(updateCallBack: (url){
              item.thumbnail=url;
              BlocProvider.of<ProductCubit>(context).update(item);


            }, url: item.thumbnail??"",)),
          );

        //  showAlertDialog(context,item);
        //  BlocProvider.of<ProductCubit>(context).deleteItem(item);
        },
        height: widget.height,
        listType: widget.listType,
        listItem: widget.listItem,
        title: widget.title,
        state: state,
      );
    });
  }


  showAlertDialog(BuildContext context ,item) {
    // Create button
    Widget okButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        BlocProvider.of<ProductCubit>(context).deleteItem(item);
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Image"),
      content: Text("Are you sure you want to delete this image ?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
