class AssociateHeadingMenu {
  String img;
  String heading;

  AssociateHeadingMenu({required this.img, required this.heading});
}

List<AssociateHeadingMenu> associateHeadingList = [
  AssociateHeadingMenu(img: 'assets/images/dashboard/view_brief.png', heading: 'View Brief'),
  AssociateHeadingMenu(img: 'assets/images/dashboard/petty_cash.png', heading: 'Petty Cash'),
  AssociateHeadingMenu(img: 'assets/images/dashboard/day_open_form.png', heading: 'Consumables List'),
  AssociateHeadingMenu(img: 'assets/images/dashboard/raise_ticket.png', heading: 'Raise Ticket'),
];
