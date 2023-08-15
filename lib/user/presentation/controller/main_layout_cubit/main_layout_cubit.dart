import 'package:ecommerce_clean_arch/user/domain/entities/product/search.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/profile/profile.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_all_products_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_cart.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_category_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_profile_data.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_favourite_by_id.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_or_delete_cart_item.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/category_info_cubit/category_info_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/favourite_view/favourites_view.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/home_view/home_view.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/get_favourites.dart';
import '../../../domain/usecase/product_search.dart';
import '../product_cubit/product_cubit.dart';

part 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit(this.getCategoryResponse, this.getAllProductsResponse, this.postFavouriteProductById, this.getFavourites, this.getProfileData, this.getCart, this.postOrDeleteCartItem, this.getProductSearch) : super(MainLayoutInitial());
  static MainLayoutCubit get(context)=>BlocProvider.of(context);
  final List titles=[
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text('MAKES LIFE'),
        Text('EASIER'),
      ],
    ),
    const Text('Favourites'),
    const Text('Profile'),
  ];
  final GetCategoryResponse getCategoryResponse;
  final GetAllProductsResponse getAllProductsResponse;
  final PostFavouriteProductById postFavouriteProductById;
  final GetProductSearch getProductSearch;
  ProductSearch? productSearch;
  bool? categoriesStatus = false;
  List<dynamic>? categories;
  List<dynamic> products = [];
  int screenIndex = 0 ;
  List<Widget> screens =[
    const ProductsAndCatView(),
    const FavouriteView(),
    const ProfileView()
  ];
  final GetCart getCart;
  List cartItems = [ ];
  final TextEditingController searchController = TextEditingController();




  //profile
  final GetProfileData getProfileData;
    late Profile profile;

  void getProfileInfo()async{
    emit(GetProfileInitial());
    final result  = await getProfileData.execute();
    result.fold((l) {
      emit(GetProfileError());
    }, (r) {
      profile = r;
      emit(GetProfileSuccess());
    });

  }





  //favourites
  final GetFavourites getFavourites;
  String? message ;
  List favourites = [];

  void changeIndex(int index){
    screenIndex = index;
    emit(UserChangeBottomNav());
  }
  void getFavourite()async{
    emit(GetFavouriteInitial());
    final result = await getFavourites.execute();
    result.fold((l) {
      message = l.message;
      emit(GetFavouriteError());
    }, (r) {
      favourites = r.data?['data'];
      print(favourites);
      emit(GetFavouriteSuccess());

    });
  }


  deleteFavouriteById(int id,int index)async{

    favourites.removeAt(index);
    final result = await postFavouriteProductById.execute(id);

    result.fold((l) {
      emit(UserPostFavouriteFailed());
    }, (r) {
      getFavourite();
      emit(UserGetAllProductSuccess());
      print(state);

    });

  }

  //home

  getCategories()async{
    emit(UserGetCategoryInitial());
    final result = await getCategoryResponse.execute();
    result.fold(
            (l) {
              emit(UserGetCategoryFailed());
            },
            (r) {
                categoriesStatus = r.status;
                categories = r.data['data'];
                emit(UserGetCategorySuccess());
            });

  }

  getAllProducts()async{
    emit(UserGetAllProductInitial());
    final reuslt = await getAllProductsResponse.execute();
    reuslt.fold(
            (l) {
              emit(UserGetAllProductFailed());
            },
            (r) {
              products = r.data?['products'];
              print(products);
              emit(UserGetAllProductSuccess());
            });
  }

  postFavouriteById(int id,int index)async{

    products[index]['in_favorites'] = !products[index]['in_favorites'];
    final result = await postFavouriteProductById.execute(id);

    result.fold((l) {
      emit(UserPostFavouriteFailed());
    }, (r) {

      emit(UserGetAllProductSuccess());
      print(state);

    });

    }




  getUserCart()async{
    emit(GetCartInitial());
    final result = await getCart.execute();
    result.fold((l) {
      emit(GetCartError());
    }, (r) {
      cartItems = r.cartItems;
      emit(GetCartSuccess());
      print(state);
    });
  }

  final PostOrDeleteCartItem postOrDeleteCartItem;
  postAddProductToCart(int id)async{
    emit(PostToCartInitial());
    final result = await postOrDeleteCartItem.execute(id);
    result.fold((l) {
      emit(PostToCartError());
    }, (r) {

      emit(PostToCartSuccess());
      getFavourite();
      print(state);
    });
  }


 void setSearchState(){
    emit(PostSearchInitial());
 }
  getSearch(String query) async {
    emit(PostSearchInitial());
    final result = await getProductSearch.execute(query);
    result.fold((l) {
      emit(PostSearchError());
    }, (r) {
      productSearch = r;
      emit(PostSearchSuccess());
      print(state);
      return r;
    });
  }

}
