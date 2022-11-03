
import 'package:flutter/material.dart';

import '../../../components/color_constant.dart';
import '../domain/dashboard_entity.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget(this.screen, {Key? key}) : super(key: key);
  final screen;

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  late bool isCollapsed = false;
  var selectedItem = 0;

  updateListItem() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCollapsed ? 82.0 : 230.0,
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: SizedBox(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  _drawerList(context, isCollapsed,widget.screen),
                  _logoutContainer(context, isCollapsed),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _logoutContainer(BuildContext context, bool isCollapsed) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5.0),
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
              child: ListTile(
                leading: Image(
                  image: isCollapsed
                      ? AssetImage('assets/images/dashboard/collapse_clo.png')
                      : AssetImage('assets/images/dashboard/collapse.png'),
                  color: Colors.black,
                ),
                title: Text(
                  isCollapsed ? " " : "Collapse",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                dense: true,
                horizontalTitleGap: 0.1,
                onTap: () {
                  updateDrawer();
                },
                tileColor: Colors.blue,
              ),
            ),
            const Divider(
              height: 1.0,
              color: Colors.black12,
            ),
            _listTile(
                title: isCollapsed ? " " : "Logout",
                img: 'assets/images/dashboard/logout.png'),
          ],
        ),
      ),
    );
  }

  _drawerList(BuildContext context, bool isCollapsed, String screen) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: isCollapsed ? 30.0 : 20.0,
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image(
                image: screen == "guest" ? AssetImage('assets/images/quick_signin1.png') :AssetImage('assets/images/quick_signin2.png'),
              ),
            ),
            title: isCollapsed
                ? null
                : Text(
              screen == "guest" ? 'Guest Associate' : 'Site Manager',
                    style: TextStyle(fontSize: 16.0),
                  ),
            subtitle: isCollapsed
                ? null
                : const Text(
                    'D324511',
                    style: TextStyle(fontSize: 12.0),
                  ),
            horizontalTitleGap: 15,
          ),
          SizedBox(
            height: isCollapsed ? 25.0 : 15.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: drawer_list.length,
            itemBuilder: (context, index) {
              final drawerList = drawer_list[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color:
                      selectedItem == index ? kLightHoverColor : Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20.0),
                    right: Radius.circular(20.0),
                  ),
                ),
                child: ListTile(
                  leading: Image(
                    image: AssetImage(drawerList.img),
                    color: selectedItem == index ? kPrimaryColor : Colors.black,
                  ),
                  title: Text(
                    isCollapsed ? "" : drawerList.header,
                    style: TextStyle(
                      fontSize: 16.0,
                      color:
                          selectedItem == index ? kPrimaryColor : Colors.black,
                    ),
                  ),
                  dense: true,
                  horizontalTitleGap: 0.1,
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                    });
                    print(selectedItem);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void updateDrawer() {
    setState(() {
      isCollapsed = isCollapsed ? false : true;
    });
  }
}

Widget _listTile({required String title, required String img}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    child: ListTile(
      leading: Image(
        image: AssetImage(img),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      dense: true,
      horizontalTitleGap: 0.1,
      tileColor: Colors.red,
    ),
  );
}

/*Widget _drawerList2(BuildContext context) {
  return Expanded(
    child: ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 15.0,
        ),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image(
              image: AssetImage('assets/images/quick_signin1.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: drawer_list.length,
          itemBuilder: (context, index) {
            final drawerList = drawer_list[index];
            return Container(
              child: _listTile(
                  title: "",
                  img: drawerList.img),
            );
          },
        ),
      ],
    ),
  );
}*/
