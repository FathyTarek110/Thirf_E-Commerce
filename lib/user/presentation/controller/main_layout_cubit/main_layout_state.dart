part of 'main_layout_cubit.dart';

@immutable
abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}
class UserGetCategoryInitial extends MainLayoutState {}
class UserGetCategorySuccess extends MainLayoutState {}
class UserGetCategoryFailed extends MainLayoutState {}
class UserGetAllProductInitial extends MainLayoutState {}
class UserGetAllProductSuccess extends MainLayoutState {}
class UserGetAllProductFailed extends MainLayoutState {}
class UserPostFavouriteInitial extends MainLayoutState {}
class UserPostFavouriteSuccess extends MainLayoutState {}
class UserPostFavouriteFailed extends MainLayoutState {}
class UserChangeFavourite extends MainLayoutState {}
class UserChangeBottomNav extends MainLayoutState {}
class GetFavouriteInitial extends MainLayoutState  {}
class GetFavouriteSuccess extends MainLayoutState  {}
class GetFavouriteError extends MainLayoutState  {}
class GetProfileInitial extends MainLayoutState  {}
class GetProfileSuccess extends MainLayoutState  {}
class GetProfileError extends MainLayoutState  {}
class GetCartInitial extends MainLayoutState  {}
class GetCartSuccess extends MainLayoutState  {}
class GetCartError extends MainLayoutState  {}
class PostToCartInitial extends MainLayoutState  {}
class PostToCartSuccess extends MainLayoutState  {}
class PostToCartError extends MainLayoutState  {}
class PostSearchInitial extends MainLayoutState  {}
class PostSearchSuccess extends MainLayoutState  {}
class PostSearchError extends MainLayoutState  {}

