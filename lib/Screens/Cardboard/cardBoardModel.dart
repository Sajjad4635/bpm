class AllCardBoards {
  var orderKey;
  var value;
  var icon;
  var count;
  var modelType;

  AllCardBoards({
    this.orderKey,
    this.value,
    this.icon,
    this.count,
    this.modelType,
  });

  factory AllCardBoards.fromJson(Map<String, dynamic> json) {
    return AllCardBoards(
      orderKey: json['key'],
      value: json['value'],
      icon: json['icon'],
      count: json['count'],
      modelType: json['model_type'],
    );
  }
}
