import 'package:ecommerce_clean_arch/user/domain/entities/cart/cart_item.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/product/product.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_product_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_favourite_by_id.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_or_delete_cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.getProductResponse, required this.id,required this.postFavouriteProductById,required this.postOrDeleteCartItem, }) : super(ProductInitial());
  final GetProductResponse getProductResponse;
  final PostFavouriteProductById postFavouriteProductById;
  final PostOrDeleteCartItem postOrDeleteCartItem;
  final int id;
  Product? data;
  static ProductCubit get(context)=>BlocProvider.of(context);
  getProduct(int id)async{
    final result = await getProductResponse.execute(id);
    result.fold(
            (l) {
              emit(UserGetProductError());
            },
            (r) {
              print(r);
              data = r;
              emit(UserGetProductSuccess());
            });
  }
  
  postFavouriteById(id)async{
    emit(UserProductFavouritePostInitial());
    data?.data?['in_favorites'] =!data?.data?['in_favorites'];
    final result = await postFavouriteProductById.execute(id);
    result.fold((l) {
      emit(UserProductFavouritePostError());
    }, (r) {

      emit(UserGetProductSuccess());
      print(state);

    });
  }

  late CartItem cartItem;
  postAddProductToCart(int id)async{
    emit(UserProductCartPostInitial());
    final result = await postOrDeleteCartItem.execute(id);
    result.fold((l) {
      emit(UserProductCartPostError());
    }, (r) {
      cartItem =r ;
      data?.data?['in_cart'] =!data?.data?['in_cart'];
      emit(UserProductCartPostSuccess());
      print(state);
    });
  }
}
