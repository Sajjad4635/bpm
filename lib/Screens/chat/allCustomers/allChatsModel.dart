class getAllCustomers {
  var time_created_title;
  var user_id_created_title;
  var time_updated_title;
  var user_id_updated_title;
  var user_id_title;
  var expert_user_id_title;
  var order_tn_title;
  var last_message_date_title;
  var id;
  var order_id;
  var expert_user_id;
  var user_id;
  var last_message;
  var last_message_date;
  var time_created;
  var user_id_created;
  var time_updated;
  var user_id_updated;
  var unread_user;
  var unread_expert;

  getAllCustomers(
      {
      this.time_created_title,
      this.user_id_created_title,
      this.time_updated_title,
      this.user_id_updated_title,
      this.user_id_title,
      this.expert_user_id_title,
      this.order_tn_title,
      this.last_message_date_title,
      this.id,
      this.order_id,
      this.expert_user_id,
      this.user_id,
      this.last_message,
      this.last_message_date,
      this.time_created,
      this.user_id_created,
      this.time_updated,
      this.user_id_updated,
      this.unread_user,
      this.unread_expert,
      });

  factory getAllCustomers.fromJson(Map<String, dynamic> json) {
    return getAllCustomers(
        time_created_title: json['time_created_title'],
        user_id_created_title: json['user_id_created_title'],
        time_updated_title: json['time_updated_title'],
        user_id_updated_title: json['user_id_updated_title'],
        user_id_title: json['user_id_title'],
        expert_user_id_title: json['expert_user_id_title'],
        order_tn_title: json['order_tn_title'],
        last_message_date_title: json['last_message_date_title'],
        id: json['id'],
        order_id: json['order_id'],
        expert_user_id: json['expert_user_id'],
        user_id: json['user_id'],
        last_message: json['last_message'],
        last_message_date: json['last_message_date'],
        time_created: json['time_created'],
        user_id_created: json['user_id_created'],
        time_updated: json['time_updated'],
        user_id_updated: json['user_id_updated'],
        unread_user: json['unread_user'],
        unread_expert: json['unread_expert']);
  }
}
