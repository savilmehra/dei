import 'package:dei/features/dashboard/presentation/widget_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../components/color_constant.dart';
import '../../../utilities/size_config.dart';
import '../../login/ui/default_button.dart';
import '../domain/dashboard_consumablesList.dart';
import '../domain/dashboard_performanceList.dart';
import '../domain/dashboard_productList.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  String startDate = "";
  String endDate = "";

  @override
  void initState() {
    startDate = DateFormat('yMMMd').format(DateTime.now());
    endDate = DateFormat('yMMMd').format(DateTime.now());
    print('${'startDate - ' + startDate}');
    print('${'endDate - ' + endDate}');
    setState(() {});
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value! is PickerDateRange) {
      setState(() {
        startDate = DateFormat('yMMMd').format(args.value.startDate);
        endDate = DateFormat('yMMMd').format(args.value.endDate);
      });
    }

    print('${'startDate - ' + startDate}');
    print('${'endDate - ' + endDate}');
  }

  @override
  Widget build(BuildContext context) {
    print("24 - 0.0185");
    print(SizeConfig.screenWidth! * 0.0185);
    print("15 - 0.0115");
    print(SizeConfig.screenWidth! * 0.0115);
    print("16 - 0.123");
    print(SizeConfig.screenWidth! * 0.0123);
    print("18 - 0.139");
    print(SizeConfig.screenWidth! * 0.0139);
    print("12 - 0.0091");
    print(SizeConfig.screenWidth! * 0.0091);
    print("14 - 0.0108");
    print(SizeConfig.screenWidth! * 0.0108);
    return Expanded(
      child: Column(
        children: [
          dashboardHeading(context,"Guest Associate!"),
          headingMenu(),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: StaggeredGrid.count(
                crossAxisCount: 8,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 4,
                    child: targetContainer(context),
                  ),
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 4,
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
                                        getDateRangePicker(context);
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
                                  'Stock Details',
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
                                  columnWidths: {0: FlexColumnWidth(1.4)},
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
                                                    ? Colors.red
                                                    : Colors.green,
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
                  StaggeredGridTile.fit(
                    crossAxisCellCount: 5,
                    child: Container(
                      height: SizeConfig.screenHeight! / 3.1,
                      padding: EdgeInsets.only(bottom: 18.0),
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
                            decoration: BoxDecoration(
                              border: Border.all(color: kBoxBorderColor),
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth! * 0.0185, vertical: SizeConfig.screenWidth! * 0.012),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            'assets/images/dashboard/add_chart.png')),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Text(
                                      'Performance Report',
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenHeight! * 0.0194,
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
                            padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
                            color: kLightSecondaryColor7,
                            child: Table(
                              columnWidths: {0: FlexColumnWidth(1),1:FlexColumnWidth(1.3),3:FlexColumnWidth(1.5)},
                              //border: TableBorder.all(color: Colors.black),
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth! * 0.0091,
                                          color: kListTextColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Shot\nCaptured',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Shot\nPreviewed',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Number Of\nTransactions',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Image\nSold',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Print\nSold',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Video\nSold',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Revenue',
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenWidth! * 0.0091,
                                            color: kListTextColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: performance_list.length,
                            itemBuilder: (context, index) {
                              final performanceList = performance_list[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth! * 0.0185,vertical: 5.0),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 10.0 : 5.0, bottom: 5.0),
                                child: Table(
                                  columnWidths: {0: FlexColumnWidth(1),1:FlexColumnWidth(1.3),3:FlexColumnWidth(1.5)},
                                  //border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(
                                          performanceList.date,
                                          style: TextStyle(
                                              fontSize: SizeConfig.screenWidth! * 0.0091,
                                              color: kListTextColor,),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            performanceList.shotsCaptured.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            performanceList.shotsPreviewed.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor,),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            performanceList.noOfTransaction.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            performanceList.imageSold.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            performanceList.printSold.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            performanceList.videoSold.toString(),
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor,),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '\$${performanceList.revenue.toString()}',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: performanceList.revenue <= 100 ? Colors.red : Colors.green),
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
                    crossAxisCellCount: 3,
                    child: Container(
                      height: SizeConfig.screenHeight! / 3.1,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Consumables Details',
                                  style: TextStyle(
                                      fontSize:
                                      SizeConfig.screenHeight! * 0.0194,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
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
                          Container(
                            color: kLightSecondaryColor7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 20.0),
                            child: Table(
                          columnWidths: {0: FlexColumnWidth(2)},
                            //border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: SizeConfig.screenWidth! * 0.0091,
                                        color: kListTextColor),
                                  ),
                                  Center(
                                    child: Text(
                                      'Count',
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth! * 0.0091,
                                          color: kListTextColor),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Last Updated',
                                      style: TextStyle(
                                          fontSize: SizeConfig.screenWidth! * 0.0091,
                                          color: kListTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: consumables_list.length,
                            itemBuilder: (context, index) {
                              final ConsumablesList = consumables_list[index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth! * 0.0185,),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 10.0 : 5.0, bottom: 5.0),
                                child: Table(
                                  columnWidths: {0: FlexColumnWidth(2)},
                                  //border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(
                                          ConsumablesList.name,
                                          style: TextStyle(
                                              fontSize: SizeConfig.screenWidth! * 0.0091,
                                              color: kListTextColor),
                                        ),
                                        Center(
                                          child: Text(
                                            ConsumablesList.count.toString() + ' Nos',
                                            style: TextStyle(
                                                fontSize: SizeConfig.screenWidth! * 0.0091,
                                                color: kListTextColor),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            ConsumablesList.lastupdated,
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

  getDateRangePicker(BuildContext context) {
    return showDialog(
        barrierColor: Colors.white60,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0.5),
            content: Card(
              elevation: 10.0,
              child: Container(
                  height: 450, width: 550, child: Center(
                child: Container(
                  height: 450, width: 550,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Start Date',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(startDate),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                height: 1.0,
                                width: 160.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Text(
                            'to',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'End Date',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(endDate),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                height: 1.0,
                                width: 160.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: SfDateRangePicker(
                          enableMultiView: true,
                          selectionMode: DateRangePickerSelectionMode.range,
                          headerStyle:
                          DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                          headerHeight: 50.0,
                          onSelectionChanged: _onSelectionChanged,
                          monthViewSettings:
                          DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultButton(
                              text: 'Cancel',

                              press: (){
                                  Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 30.0,),
                            DefaultButton(
                              text: 'Confirm',

                              press: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }
}

Widget targetContainer(BuildContext context) {
  print(SizeConfig.screenWidth! * 0.0185);
  return Container(
    height: MediaQuery.of(context).size.height / 3.5,
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
              'GA - Sales Target',
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
                  text: '\$150 ',
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
                  text: '\$200',
                  style: TextStyle(
                    color: kLightSecondaryColor6,
                    fontSize: SizeConfig.screenHeight! * 0.0194,
                  ),
                ),
              ]),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(14.0),
        ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 8.0,
          animationDuration: 2500,
          percent: 150 / 200,
          barRadius: Radius.circular(8.0),
          progressColor: Colors.green,
        ),
        Container(
          margin: EdgeInsets.only(top: 39.0, right: 90.0),
          child: Text(
            'MSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium. MSed ut perspiciatis unde omnis iste natus error sit voluptatem.',
            maxLines: 2,
            style: TextStyle(fontSize: SizeConfig.screenHeight! *  0.0119, color: Colors.white, height: 1.5),
          ),
        ),
      ],
    ),
  );
}
