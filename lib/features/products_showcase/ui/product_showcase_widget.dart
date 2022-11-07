import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/horizontal_product_loader.dart';

import '../bloc/states.dart';
import '../models/fielSpinResponse.dart';

enum ListType { grid, vertical, horizontal }

typedef ListItem = Widget Function(FileSpinFiles itemData);

class ProductShowCaseWidget extends StatelessWidget {
  final MainState state;
  late BuildContext ctx;
  final double? height;
  final ListType listType;
  final ListItem listItem;
  final String? title;
  final Function(FileSpinFiles) callBack;
  final Function(FileSpinFiles) longpress;

  ProductShowCaseWidget(
      {required this.state,
      required this.height,
      required this.longpress,
      this.title,
      required this.callBack,
      required this.listItem,
      required this.listType});

  @override
  Widget build(BuildContext context) {
    this.ctx = context;
    return state is EmptyState || state is ErrorState
        ? getWidgetWithHeight(Center(
            child: Text((state is ErrorState
                ? (state as ErrorState).errorMessage
                : (state as EmptyState).errorMessage)),
          ))
        : state is LoadingState
            ? HorizontalProductLoader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(title ?? "",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Flexible(
                      child: height != null
                          ? getWidgetWithHeight(getDesiredListType(state))
                          : getDesiredListType(state)),
                ],
              );
  }

  Widget getDesiredListType(MainState state) {
    switch (listType) {
      case ListType.grid:
        return gridViewList(state);
      case ListType.horizontal:
      case ListType.vertical:
        return getVerticalList(listType, state);
    }
  }

  Widget getVerticalList(ListType listType, MainState state) {
    List<FileSpinFiles> list = (state as LoadedState).products;
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: listType == ListType.vertical
            ? NeverScrollableScrollPhysics()
            : ClampingScrollPhysics(),
        scrollDirection:
            listType == ListType.vertical ? Axis.vertical : Axis.horizontal,
        itemBuilder: (_, index) {
          final item = list[index];
          return listItem(item);
        });
  }

  Widget gridViewList(MainState state) {
    List<FileSpinFiles> list = (state as LoadedState).products;
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            childAspectRatio: 0.75,
            //physics:BouncingScrollPhysics(),
            padding: EdgeInsets.all(10.0),
            children: list
                .map(
                  (data) => InkWell(
                      onTap: () async {
                        callBack(data);
                      },
                      child: listItem(data)),
                )
                .toList(),
          );
        })

        /*   GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              childAspectRatio: 0.75,
              crossAxisCount:2),
          itemBuilder: (_, index) {
            final item = list[index];
            return InkWell(
                onTap: () async {
                  callBack(item);
                },
                child: listItem(item));
          }),*/
        );
  }

  Widget getWidgetWithHeight(Widget child) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
