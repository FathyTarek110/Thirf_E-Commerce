import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

const  ServerException(this.errorMessageModel);

}

class LocalException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const  LocalException(this.errorMessageModel);

}
