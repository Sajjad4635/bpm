class GetAllOrderServices {
  var key;
  var value;

  GetAllOrderServices(
      {
        this.key,
        this.value,
      });

  factory GetAllOrderServices.fromJson(Map<String, dynamic> json) {
    return GetAllOrderServices(
        key: json['key'],
        value: json['value'],);
  }
}
