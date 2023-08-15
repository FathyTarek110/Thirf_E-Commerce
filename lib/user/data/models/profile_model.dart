import 'package:ecommerce_clean_arch/user/domain/entities/profile/profile.dart';

class ProfileModel extends Profile{
  ProfileModel({required super.status, required super.id, required super.name, required super.email, required super.image});


  factory ProfileModel.fromJsom(Map<String,dynamic> json){
    return ProfileModel(status: json['status'], id: json['data']['id'], name: json['data']['name'], email: json['data']['email'], image: json['data']['image']);
  }

}