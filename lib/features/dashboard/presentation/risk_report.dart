class RiskReport{
  String detail;
  bool status;

  RiskReport({required this.detail, required this.status});
}

List<RiskReport> riskReport_list =[
  RiskReport(detail: 'Pending list of Digital Accessories', status: true),
  RiskReport(detail: 'Vendor change for Paper stock for 8x10 ', status: true),
  RiskReport(detail: 'Fujifilm Paper stock for Instant Category', status: false),
  RiskReport(detail: 'Fujifilm Paper stock for Instant Category', status: false),
  RiskReport(detail: 'Fujifilm Paper stock for Instant Category', status: false),
];