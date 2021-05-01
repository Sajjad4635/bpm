class dataModel {
  var key;
  var value;

  dataModel(
      {
        this.key,
        this.value,
      });

  factory dataModel.fromJson(Map<String, dynamic> json) {
    return dataModel(
        key: json['key'],
        value: json['value']);
  }
}