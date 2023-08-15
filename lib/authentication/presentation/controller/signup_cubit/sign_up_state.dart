part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
class SignUpChangeIcon extends SignUpState {}
class UserSignUpLoadingState extends SignUpState {}
class UserSignUpSuccessState extends SignUpState {}
class UserSignUpErrorState extends SignUpState {}
