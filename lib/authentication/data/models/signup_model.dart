import 'package:ecommerce_clean_arch/authentication/domain/entities/signup.dart';

class SignUpModel extends SignUp {
  SignUpModel({required super.message, required super.status});

  factory SignUpModel.fromJson(Map<String,dynamic>json){
    return SignUpModel(message: json['message'], status: json['status']);
  }

}