import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/main_layout_cubit/main_layout_cubit.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => MainLayoutCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl())..setSearchState(),
  child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    MainLayoutCubit cubit = MainLayoutCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: ColorManager.primary,),splashColor: Colors.transparent,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: myTextFormField(context: context, prefixIcon: const Icon(Icons.search),controller: cubit.searchController, label: 'what are you looking for', obscure: false, enableSuggestions: false, autoCorrect: false,onChanged: (query)async{

            },onEditingComplete: ()async{
               cubit.getSearch(cubit.searchController.text);
            }),
          ),
          Expanded(child: Container(
            child:ConditionalBuilder(condition: state is! PostSearchInitial,
              builder: (BuildContext context)=>cubit.productSearch!.data.isEmpty? const Center(child: Text('item you searched for is not available'),) :
              ListView.builder(
                  itemCount: cubit.productSearch!.data.length,
                  itemBuilder: (context,index)=> buildFavouriteAndCartContainer(context: context, isCart: false, name: cubit.productSearch?.data[index]['name'], price: cubit.productSearch?.data[index]['price'], image: cubit.productSearch?.data[index]['image'], id: cubit.productSearch?.data[index]['id'], crossImageFunction: (){
                    cubit.deleteFavouriteById(cubit.productSearch?.data[index]['id'], index);
                  }, shoppingBagImage: (){
                    cubit.productSearch?.data[index]['product']['in_cart'] == false? cubit.postAddProductToCart(cubit.productSearch?.data[index]['id']):myToast('Item Already in Cart', ColorManager.primary);
                  }, quantity: null, plusSignCart: null, minusSignCart: null)
              ) ,
              fallback: (BuildContext context) {
                return Center(
                  child: cubit.searchController.text.isEmpty? const Text('what are you looking for') :CircularProgressIndicator(color: ColorManager.primary,)
                );
              },
            ),
          ))
        ],
      ),
    );
  },
),
);
  }
}
