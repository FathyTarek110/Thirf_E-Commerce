import 'package:dartz/dartz.dart';
import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/signup_data_source/signup_data_source.dart';
import 'package:ecommerce_clean_arch/authentication/domain/entities/signup.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_sign_up_repository.dart';
import 'package:ecommerce_clean_arch/error/exception.dart';
import 'package:ecommerce_clean_arch/error/failure.dart';

class SignUpRepository extends BaseSignupRepository{
  final BaseSignUpDataSource baseSignUpDataSource;

  SignUpRepository(this.baseSignUpDataSource);
  @override
  Future<Either<Failure,SignUp>> postSignUpInfo({required String name, required String email, required String password, required String phone}) async {
            final result = await baseSignUpDataSource.postSignUpInfo(name, email, password,phone);
            try{
              return right(result);
              
            } on ServerException catch(e){
              return left(ServerFailure(e.errorMessageModel.message));
            }

  }

}