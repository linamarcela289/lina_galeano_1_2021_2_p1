


import 'message.dart';

class Breeds {
  Message message = Message(
    affenpinscher:  [""], 
    australian:  [""]);
    String status = '';

  Breeds({ required this.message, required this.status});

   Breeds.fromJson(Map<String, dynamic> json) {
    message = Message.fromJson(json ['message']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message.toJson();
    data['status'] = this.status;
    return data;
  }
}