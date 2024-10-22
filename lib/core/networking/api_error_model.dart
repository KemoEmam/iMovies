class ApiErrorModel {
  int? statusCode;
  String? statusMessage;
  bool? success;

  ApiErrorModel({this.statusCode, this.statusMessage, this.success});

  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['success'] = this.success;
    return data;
  }
}