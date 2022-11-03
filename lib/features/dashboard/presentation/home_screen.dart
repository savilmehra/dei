import 'package:dei/features/dashboard/presentation/site_manager_dashboard.dart';
import 'package:dei/features/dashboard/presentation/widget_helper.dart';

import 'package:flutter/material.dart';

import 'dashboard_widget.dart';
import 'navigation_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,required this.screen}) : super(key: key);
  final screen;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/dash_back.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
             header(isLogin: true,context: context),
              Expanded(
                child: Row(
                  children: [
                    NavigationDrawerWidget(widget.screen),
                   widget.screen == 'guest' ? DashBoardWidget() :SiteManagerDashboard(),
                    //DailyBriefing(screen: widget.screen,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
