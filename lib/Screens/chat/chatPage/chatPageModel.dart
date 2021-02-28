class allChats {
  String timeCreatedTitle;
  String userIdCreatedTitle;
  var attachFileTitle;
  String userIdTitle;
  Result result;
  String id;
  String orderId;
  var cancustomerview;
  String text;
  var attachFile;
  var iscustomer;
  String userIdCreated;
  String timeCreated;
  var chatstatus;
  String boxdad;
  String usermention;
  var readmention;
  String changeboxstatus;
  String expertManager;
  String userId;
  String msgType;
  var duration;
  var height;
  var width;
  var size;
  var showname;
  var synced;
  String read;
  var received;
  var messageId;

  allChats(
      {this.timeCreatedTitle,
        this.userIdCreatedTitle,
        this.attachFileTitle,
        this.userIdTitle,
        this.result,
        this.id,
        this.orderId,
        this.cancustomerview,
        this.text,
        this.attachFile,
        this.iscustomer,
        this.userIdCreated,
        this.timeCreated,
        this.chatstatus,
        this.boxdad,
        this.usermention,
        this.readmention,
        this.changeboxstatus,
        this.expertManager,
        this.userId,
        this.msgType,
        this.duration,
        this.height,
        this.width,
        this.size,
        this.showname,
        this.synced,
        this.read,
        this.received,
        this.messageId});

  allChats.fromJson(Map<String, dynamic> json) {
    timeCreatedTitle = json['time_created_title'];
    userIdCreatedTitle = json['user_id_created_title'];
    attachFileTitle = json['attach_file_title'];
    userIdTitle = json['user_id_title'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    id = json['id'];
    orderId = json['order_id'];
    cancustomerview = json['cancustomerview'];
    text = json['text'];
    attachFile = json['attach_file'];
    iscustomer = json['iscustomer'];
    userIdCreated = json['user_id_created'];
    timeCreated = json['time_created'];
    chatstatus = json['chatstatus'];
    boxdad = json['boxdad'];
    usermention = json['usermention'];
    readmention = json['readmention'];
    changeboxstatus = json['changeboxstatus'];
    expertManager = json['expert_manager'];
    userId = json['user_id'];
    msgType = json['msg_type'];
    duration = json['duration'];
    height = json['height'];
    width = json['width'];
    size = json['size'];
    showname = json['showname'];
    synced = json['synced'];
    read = json['read'];
    received = json['received'];
    messageId = json['message_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_created_title'] = this.timeCreatedTitle;
    data['user_id_created_title'] = this.userIdCreatedTitle;
    data['attach_file_title'] = this.attachFileTitle;
    data['user_id_title'] = this.userIdTitle;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['cancustomerview'] = this.cancustomerview;
    data['text'] = this.text;
    data['attach_file'] = this.attachFile;
    data['iscustomer'] = this.iscustomer;
    data['user_id_created'] = this.userIdCreated;
    data['time_created'] = this.timeCreated;
    data['chatstatus'] = this.chatstatus;
    data['boxdad'] = this.boxdad;
    data['usermention'] = this.usermention;
    data['readmention'] = this.readmention;
    data['changeboxstatus'] = this.changeboxstatus;
    data['expert_manager'] = this.expertManager;
    data['user_id'] = this.userId;
    data['msg_type'] = this.msgType;
    data['duration'] = this.duration;
    data['height'] = this.height;
    data['width'] = this.width;
    data['size'] = this.size;
    data['showname'] = this.showname;
    data['synced'] = this.synced;
    data['read'] = this.read;
    data['received'] = this.received;
    data['message_id'] = this.messageId;
    return data;
  }
}

class Result {
  User user;
  Message message;

  Result({this.user, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String name;
  String photo;

  User({this.id, this.name, this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}

class Message {
  String id;
  String userId;
  String text;
  String time;
  Image image;
  Document document;

  Message(
      {this.id, this.userId, this.text, this.time, this.image, this.document});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    text = json['text'];
    time = json['time'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['time'] = this.time;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.document != null) {
      data['document'] = this.document.toJson();
    }
    return data;
  }
}

class Image {
  String thumb;
  String src;
  String name;
  String height;
  String width;
  String size;

  Image({this.thumb, this.src, this.name, this.height, this.width, this.size});

  Image.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    src = json['src'];
    name = json['name'];
    height = json['height'];
    width = json['width'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['src'] = this.src;
    data['name'] = this.name;
    data['height'] = this.height;
    data['width'] = this.width;
    data['size'] = this.size;
    return data;
  }
}

class Document {
  String name;
  String showName;
  String src;
  String size;

  Document({this.name, this.showName, this.src, this.size});

  Document.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    showName = json['showName'];
    src = json['src'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['showName'] = this.showName;
    data['src'] = this.src;
    data['size'] = this.size;
    return data;
  }
}