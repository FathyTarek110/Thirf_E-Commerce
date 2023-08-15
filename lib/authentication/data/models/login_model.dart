import '../../domain/entities/login.dart';

class LoginModel extends Login{
  LoginModel({required super.message, required super.data, required super.status});

  factory LoginModel.fromJson(Map<String,dynamic> json){
    return LoginModel(message: json['message'], data: json['data'], status: json['status']);
  }

}