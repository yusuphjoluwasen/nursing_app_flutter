class Report {
  final String groupId;
  final String reportDescription;
  final String personName;
  final String reportId;
  final DateTime reportDate;

  Report({
    required this.groupId,
    required this.reportDescription,
    required this.personName,
    required this.reportId,
    required this.reportDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'reportDescription': reportDescription,
      'personName': personName,
      'reportId': reportId,
      'reportDate': reportDate.toIso8601String(),
    };
  }
}
