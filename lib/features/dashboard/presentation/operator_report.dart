class OperatorReport{
  String name;
  int shots;
  int sales;
  int images_sold;
  int revenue;

  OperatorReport(
      {required this.name,
      required this.shots,
      required this.sales,
      required this.images_sold,
      required this.revenue});
}

List<OperatorReport> operator_list = [
  OperatorReport(name: 'Operator 1', shots: 320, sales: 4, images_sold: 86, revenue: 20),
  OperatorReport(name: 'Operator 2', shots: 420, sales: 2, images_sold: 56, revenue: 120),
  OperatorReport(name: 'Operator 3', shots: 445, sales: 3, images_sold: 78, revenue: 320),
];