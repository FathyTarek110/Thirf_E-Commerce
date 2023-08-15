import 'package:bloc/bloc.dart';
import 'package:ecommerce_clean_arch/core/network_helper/dio_helper.dart.dart';
import 'package:ecommerce_clean_arch/core/resources/strings_manger/strings_manager.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_category_info_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecase/get_cart.dart';
import '../../../domain/usecase/post_favourite_by_id.dart';

part 'category_info_state.dart';


class CategoryInfoCubit extends Cubit<CategoryInfoState> {
  CategoryInfoCubit(this.getCategoryInfoResponse, this.postFavouriteProductById, this.getCart) : super(CategoryInfoInitial());
  final GetCategoryInfoResponse getCategoryInfoResponse;
  final GetCart getCart;
  bool? status;
  List<dynamic> categoryProducts=[];
  final PostFavouriteProductById postFavouriteProductById;
  List cartItems = [ ];
  dynamic cartTotal  ;
  late ScrollController scrollController;
  bool midScroll = false;




  scrollControllerInit(){
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    emit(UserScrollControllerInit());
    print(state);

  }
  scrollListener(){
    if (scrollController.offset >= scrollController.position.maxScrollExtent/3 &&
        !scrollController.position.outOfRange) {
        midScroll = true;
        emit(UserScrollControllerMid());
        print(midScroll);
    } else if(scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
        midScroll = false;
        emit(UserScrollControllerMin());
        print(midScroll);

    }
  }




  static CategoryInfoCubit get(context)=>BlocProvider.of(context);

  getCategoryInfoById(int id)async{
    emit(UserGetCategoryInfoInitial());
    final result = await getCategoryInfoResponse.execute(id);
    result.fold(
            (l) {
              emit(UserCategoryInfoError());
              print(state);
            },
            (r) {
              status = r.status;
              categoryProducts = r.data['data'];
              emit(UserGetCategoryInfoSuccess());
            });
  }


  postFavouriteById(int id,int index)async{

    categoryProducts[index]['in_favorites'] = !categoryProducts[index]['in_favorites'];
    emit(UserPostFavouriteInitial());
    final result = await postFavouriteProductById.execute(id);

    result.fold((l) {
      emit(UserPostFavouriteFailed());
    }, (r) {

      emit(UserPostFavouriteSuccess());
      print(state);

    });

  }


  getCartBottomSheet()async{
    emit(UserGotCartInitial());
      final result = await getCart.execute();
      result.fold((l) {
        emit(UserGotCartSuccess());
      }, (r) {
        cartItems = r.cartItems;
        cartTotal = r.total;
        print(r.total);
        emit(UserGotCartSuccess());
        print(state);
      });
  }
}
