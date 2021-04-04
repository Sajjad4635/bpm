class AllCardBoardsMonitoring {
  var orderKey;
  var value;
  var icon;
  var count;
  var modelType;

  AllCardBoardsMonitoring({
    this.orderKey,
    this.value,
    this.icon,
    this.count,
    this.modelType,
  });

  factory AllCardBoardsMonitoring.fromJson(Map<String, dynamic> json) {
    return AllCardBoardsMonitoring(
      orderKey: json['key'],
      value: json['value'],
      icon: json['icon'],
      count: json['count'],
      modelType: json['model_type'],
    );
  }
}
