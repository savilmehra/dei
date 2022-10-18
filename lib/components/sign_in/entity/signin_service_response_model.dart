import 'package:clean_framework/clean_framework_defaults.dart';

class SignInServiceResponseModel extends JsonResponseModel {
  String? sTypename;
  GenerateCustomerToken? generateCustomerToken;
    bool hasError=false;
  SignInServiceResponseModel({this.sTypename, this.generateCustomerToken,this.hasError=false});

  SignInServiceResponseModel.fromJson(Map<String, dynamic> json,bool ?error) {
    sTypename = json['__typename'];
    hasError=error??false;
    generateCustomerToken = json['generateCustomerToken'] != null
        ? new GenerateCustomerToken.fromJson(json['generateCustomerToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.generateCustomerToken != null) {
      data['generateCustomerToken'] = this.generateCustomerToken!.toJson();
    }
    return data;
  }

  @override
  List<Object> get props => [generateCustomerToken ?? GenerateCustomerToken()];
}

class GenerateCustomerToken {
  String? sTypename;
  String? token;

  GenerateCustomerToken({this.sTypename, this.token});

  GenerateCustomerToken.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['token'] = this.token;
    return data;
  }
}
