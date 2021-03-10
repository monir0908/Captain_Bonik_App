class PostRequestResponse {
  String status;
  String messages;
  dynamic result;

  PostRequestResponse({this.status, this.messages, this.result});

  PostRequestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    data['result'] = this.result;
    return data;
  }
}