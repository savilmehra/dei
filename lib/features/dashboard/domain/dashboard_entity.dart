class DrawerMenu{
  String img;
  String header;

  DrawerMenu({required this.img, required this.header});
}

List<DrawerMenu> drawer_list =[
  DrawerMenu(img: "assets/images/dashboard/backup_table.png", header: "DashBoard"),
  DrawerMenu(img: "assets/images/dashboard/dashboard.png", header: "Media"),
  DrawerMenu(img: "assets/images/dashboard/devices.png", header: "Device Status"),
  DrawerMenu(img: "assets/images/dashboard/assignment.png", header: "Reports"),
  DrawerMenu(img: "assets/images/dashboard/inventory_2.png", header: "Catalogue"),
  DrawerMenu(img: "assets/images/dashboard/order.png", header: "Orders"),
  DrawerMenu(img: "assets/images/dashboard/manage_accounts.png", header: "Configuration"),
  DrawerMenu(img: "assets/images/dashboard/settings.png", header: "Settings"),
  DrawerMenu(img: "assets/images/dashboard/help.png", header: "Help"),

];