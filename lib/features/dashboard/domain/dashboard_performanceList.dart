class PerformanceList {
  String date;
  int shotsCaptured;
  int shotsPreviewed;
  int noOfTransaction;
  int imageSold;
  int printSold;
  int videoSold;
  int revenue;

  PerformanceList(
      {required this.date,
      required this.shotsCaptured,
      required this.shotsPreviewed,
      required this.noOfTransaction,
      required this.imageSold,
      required this.printSold,
      required this.videoSold,
      required this.revenue});
}

List<PerformanceList> performance_list = [
  PerformanceList(
      date: '14/10/22',
      shotsCaptured: 2000,
      shotsPreviewed: 1780,
      noOfTransaction: 4,
      imageSold: 86,
      printSold: 20,
      videoSold: 10,
      revenue: 20),
  PerformanceList(
      date: '13/10/22',
      shotsCaptured: 2000,
      shotsPreviewed: 1780,
      noOfTransaction: 4,
      imageSold: 86,
      printSold: 20,
      videoSold: 10,
      revenue: 120),
  PerformanceList(
      date: '12/10/22',
      shotsCaptured: 2000,
      shotsPreviewed: 1780,
      noOfTransaction: 4,
      imageSold: 86,
      printSold: 20,
      videoSold: 10,
      revenue: 320),
];
