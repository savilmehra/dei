import 'package:dei/features/dashboard/presentation/risk_report.dart';
import 'package:dei/features/dashboard/presentation/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../components/color_constant.dart';
import '../../../utilities/size_config.dart';
import '../domain/dashboard_consumablesList.dart';
import '../domain/dashboard_performanceList.dart';
import '../domain/dashboard_productList.dart';
import 'dashboard_widget.dart';
import 'operator_report.dart';

class SiteManagerDashboard extends StatefulWidget {
  const SiteManagerDashboard({Key? key}) : super(key: key);

  @override
  State<SiteManagerDashboard> createState() => _SiteManagerDashboardState();
}

class _SiteManagerDashboardState extends State<SiteManagerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          dashboardHeading(context,"Site Manager!"),
          smHeadingList(),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: StaggeredGrid.count(
                crossAxisCount: 12,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 5,
                    child: targetContainer(context),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 7,
                    child: Container(
                      height: SizeConfig.screenHeight! / 3.5,
                      padding: EdgeInsets.only(bottom: SizeConfig.screenWidth! * 0.0115),
                      decoration: BoxDecoration(
                        border: Border.all(color: kBoxBorderColor),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.018, vertical: SizeConfig.screenWidth! * 0.0115),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/dashboard/add_chart.png'),),
                                    horizontalSpace(13.0),
                                    Text(
                                      'Operator Performance Report',
                                      style: TextStyle(
                                          fontSize:
                                          SizeConfig.screenHeight! * 0.0194,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Text(
                                  'View all',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091,
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: kLightSecondaryColor7,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.0185, vertical: SizeConfig.screenWidth!!! * 0.0126),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Operator',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Shots Previewed',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'No.of Sales',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Images Sold',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Revenue',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: operator_list.length,
                            itemBuilder: (context, index) {
                              final operator = operator_list[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth! * 0.0185),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 14.0 : 8.0, bottom: 5.0),
                                child: Table(
                                  columnWidths: {0: FlexColumnWidth(1.4)},
                                  //border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(
                                          operator.name,
                                          style: TextStyle(
                                              fontSize: SizeConfig.screenWidth! * 0.0091,
                                              color: kListTextColor),
                                        ),
                                        Center(
                                          child: Text(
                                            operator.shots.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            operator.sales.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            operator.images_sold.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '\$${operator.revenue}',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 5,
                    child: Container(
                      height: SizeConfig.screenHeight! / 2.9,
                      padding: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: kBoxBorderColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.018, vertical: SizeConfig.screenWidth! * 0.0115),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/dashboard/assignment_late.png'),),
                                    horizontalSpace(13.0),
                                    Text(
                                      'Risk Reports',
                                      style: TextStyle(
                                          fontSize:
                                          SizeConfig.screenHeight! * 0.0194,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  'View all',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: riskReport_list.length,
                            itemBuilder: (context, index) {
                              final riskReport = riskReport_list[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth! * 0.0185),
                                margin: EdgeInsets.only(
                                    top: 2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      riskReport.detail,
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth! * 0.0091,
                                          color: kListTextColor),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        color: riskReport.status ? kPrimaryColor : kBoxBorderColor,
                                        borderRadius: BorderRadius.circular(15.0)
                                      ),
                                      child: Icon(Icons.navigate_next_rounded,color: Colors.white,)
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 7,
                    child: Container(
                      height: SizeConfig.screenHeight! / 3.5,
                      padding: EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: kBoxBorderColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.018, vertical: SizeConfig.screenWidth! * 0.0115),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Product Details',
                                  style: TextStyle(
                                      fontSize:
                                      SizeConfig.screenHeight! * 0.0194,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap : (){
                                        //getDateRangePicker(context);
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/dashboard/edit_products.png'),),
                                    ),
                                    SizedBox(
                                      width: 46.0,
                                    ),
                                    Text(
                                      'View all',
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth! * 0.0091,
                                          decoration: TextDecoration.underline,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: kLightSecondaryColor7,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.0185, vertical: SizeConfig.screenWidth!!! * 0.0124),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Product Name',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Total Stock',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Stock left',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Selling Volume',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenWidth! * 0.0091, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: product_list.length,
                            itemBuilder: (context, index) {
                              final product = product_list[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth! * 0.0185),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 10.0 : 5.0, bottom: 5.0),
                                child: Table(
                                  columnWidths: {0: FlexColumnWidth(1),1: FlexColumnWidth(1.4)},
                                  //border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                              fontSize: SizeConfig.screenWidth! * 0.0091,
                                              color: kListTextColor),
                                        ),
                                        Center(
                                          child: Text(
                                            product.totStock.toString() + ' Nos',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            product.stock.toString() + ' Nos',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: getProportionateScreenHeight(20.0)),
                                              Icon(
                                                Icons.circle,
                                                size: 10.0,
                                                color: product.status == 'High'
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              SizedBox(width: 10.0),
                                              Text(
                                                product.status,
                                                style: TextStyle(
                                                    fontSize: SizeConfig.screenWidth! * 0.0091,
                                                    color: kListTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '\$${product.price}',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget targetContainer(BuildContext context) {
  print(SizeConfig.screenWidth! * 0.0185);
  return Container(
    height: MediaQuery.of(context).size.height / 4.4,
    padding: EdgeInsets.only(top: 21.0, left: 24.0, right: 24.0, bottom: 24.0),
    decoration: BoxDecoration(
      color: Colors.black,
      //border: Border.all(color: kBoxBorderColor),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(
                image: AssetImage('assets/images/dashboard/legend_toggle.png')),
            SizedBox(
              width: getProportionateScreenHeight(15.0),
            ),
            Text(
              'Site - Sales Target',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight! * 0.0194,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(12.0),
        ),
        Divider(
          thickness: 0.4,
          color: kLightSecondaryColor5,
        ),
        SizedBox(
          height: 14.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Target',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight! * 0.0194,
                  fontWeight: FontWeight.w700),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '\$23569 ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.screenWidth! * 0.0185
                  ),
                ),
                TextSpan(
                  text: '/',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.screenHeight! * 0.0194,
                  ),
                ),
                TextSpan(
                  text: '\$25000',
                  style: TextStyle(
                    color: kLightSecondaryColor6,
                    fontSize: SizeConfig.screenHeight! * 0.0194,
                  ),
                ),
              ]),
            ),
          ],
        ),
        verticalSpace(14.0),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 8.0,
          animationDuration: 2500,
          percent: 150 / 200,
          barRadius: Radius.circular(8.0),
          progressColor: Colors.green,
        ),
        Container(
          margin: EdgeInsets.only(top: 19.0, right: 40.0),
          child: Text(
            'MSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium.',
            maxLines: 2,
            style: TextStyle(fontSize: 9.0, color: Colors.white, height: 1.5),
          ),
        ),
      ],
    ),
  );
}
