import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../universal/graphql/graph_ql_service.dart';
import '../api/product_quries.dart';
import '../bloc/product_cubit.dart';
import '../bloc/states.dart';
import '../model/products_response.dart';
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
    BlocProvider.of<ProductCubit>(context).getData(
        requestType: RequestType.query,
        header: {'Store': 'english'},
        queryString: searchQuery("watch", 4),
        token: '4vuve1vw4gcf1b09u7gmzetz8vdkevua',
        getData: () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, MainState>(builder: (context, state) {
      return ProductShowCaseWidget(
        callBack: (Items item) {
          BlocProvider.of<ProductCubit>(context).deleteItem(item);
        },
        height: widget.height,
        listType: widget.listType,
        listItem: widget.listItem,
        title: widget.title,
        state: state,
      );
    });
  }
}
