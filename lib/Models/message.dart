class Message {
  List<String> affenpinscher = [""];
    List<String> australian = [""];

  Message(
      {
      required this.affenpinscher,
      required this.australian
      });

 Message.fromJson(Map<String, dynamic> json) {
    affenpinscher = (json['affenpinscher'].cast<String>() != null) ? json['affenpinscher'].cast<String>() : [""];
    australian = json['australian'].cast<String>();
    
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data.keys
    data['affenpinscher'] = this.affenpinscher;
    data['australian'] = this.australian;

    return data;
  }

}