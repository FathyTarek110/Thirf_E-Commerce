part of 'category_info_cubit.dart';

@immutable
abstract class CategoryInfoState {}

class CategoryInfoInitial extends CategoryInfoState {}
class UserGetCategoryInfoInitial extends CategoryInfoState {}
class UserGetCategoryInfoSuccess extends CategoryInfoState {}
class UserCategoryInfoError extends CategoryInfoState {}
class UserPostFavouriteInitial extends CategoryInfoState {}
class UserPostFavouriteSuccess extends CategoryInfoState {}
class UserPostFavouriteFailed extends CategoryInfoState {}
class UserGotCartSuccess extends CategoryInfoState {}
class UserGotCartInitial extends CategoryInfoState {}
class UserGotCartFailed extends CategoryInfoState {}
class UserScrollControllerInit extends CategoryInfoState {}
class UserScrollControllerMid extends CategoryInfoState {}
class UserScrollControllerMax extends CategoryInfoState {}
class UserScrollControllerMin extends CategoryInfoState {}