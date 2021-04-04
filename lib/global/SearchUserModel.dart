class UserSearch {
  var id;
  var mobile;
  var name;
  var nameEn;

  UserSearch(
      {
        this.id,
        this.mobile,
        this.name,
        this.nameEn,
      });

  factory UserSearch.fromJson(Map<String, dynamic> json) {
    return UserSearch(
        id: json['id'],
        mobile: json['mobile'],
        name: json['name'],
        nameEn: json['name_en']);
  }
}
