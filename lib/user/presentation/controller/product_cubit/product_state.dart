part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class UserGetProductInitial extends ProductState {}
class UserGetProductSuccess extends ProductState {}
class UserGetProductError extends ProductState {}
class UserProductFavouritePostInitial extends ProductState {}
class UserProductFavouritePostSuccess extends ProductState {}
class UserProductFavouritePostError extends ProductState {}

class UserProductCartPostInitial extends ProductState {}
class UserProductCartPostSuccess extends ProductState {}
class UserProductCartPostError extends ProductState {}
