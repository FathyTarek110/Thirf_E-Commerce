import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/font_manger/font_manager.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../user/presentation/screens/home_view/product_view.dart';
import '../color_manger/color_manager.dart';
import '../values_manager/values_manger.dart';

TextFormField myTextFormField({required BuildContext context,required TextEditingController controller,required String label,IconData? iconData,Widget? suffixIcon, Widget? prefixIcon,required bool obscure,required bool enableSuggestions,required bool autoCorrect,TextInputType? textInputType,var validate,void Function(String)? onChanged,void Function()? onEditingComplete}){
  return TextFormField(
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      prefixIconColor: ColorManager.primary,
      contentPadding: const EdgeInsets.all(AppPadding.p16),
      label: Text(label,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
      suffixIcon: suffixIcon,
    ),
    obscureText: obscure,
    enableSuggestions: enableSuggestions,
    autocorrect: autoCorrect,
    keyboardType: textInputType,
    validator: validate,
  );
}


ElevatedButton buildMyButton(BuildContext context,String text,VoidCallback? function,) {
  return ElevatedButton(
      onPressed: function,
      child: Padding(
    padding:  const EdgeInsets.all(AppPadding.p12),
    child: Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),),
  ));
}

 myToast(String message,Color color){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: ColorManager.white,
      timeInSecForIosWeb: 3,
      fontSize: FontSize.s16
  );
}

GestureDetector buildCategoryItem(BuildContext context ,String title,void Function()? function,String img) {
  return GestureDetector(
    onTap:function,
    child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10)
      ),
      child: Column(
        children: [
           SizedBox(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height/4,
               child: Image.network(img)),
          Text(title,style: Theme.of(context).textTheme.bodyMedium,),
        ],
      ),
    ),
  );

}

GestureDetector buildProductCard(BuildContext context, List<dynamic>  image, String name ,var price ,int itemIndex, void Function()? function,String tag,Icon favourite,void Function()? favouriteFunction) {
  return GestureDetector(
    onTap: function,
    child: Card(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height/3,
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: image.length,
                  itemBuilder: (context,index,realIndex){
                    return Hero(
                      tag: UniqueKey(),
                      child: Image(
                          image: NetworkImage(image[index])),
                    );
                  },
                  options:CarouselOptions(
                    scrollDirection: itemIndex %2 ==0 ? Axis.horizontal:Axis.vertical,
                    autoPlay: true,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height/4
                  ))
          ),
          const SizedBox(height: AppSize.s12,),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(name,style: Theme.of(context).textTheme.bodySmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              children: [
                Text(
                  ' ${price.toString()} EGP',style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Spacer(),
                IconButton(onPressed: favouriteFunction, icon: favourite,splashColor: Colors.transparent ,)
              ],
            ),
          ),
        ],


      ),



    ),
  );


}

GestureDetector buildProfileSettingsCard(
    {required BuildContext context, required String title, required String description,required void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          color: ColorManager.white
      ),
      child: Padding(
        padding:  const EdgeInsets.all(AppPadding.p16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s18),),
                Text(description,style: Theme.of(context).textTheme.bodySmall,)
              ],
            ),
            const Spacer(),
            Icon(Icons.navigate_next,size: MediaQuery.of(context).size.height/16,)
          ],
        ),
      ),
    ),
  );


}
Padding buildFavouriteAndCartContainer({required BuildContext context,required bool isCart,required String name,required var price,required String image,required int id,required void Function()? crossImageFunction,required void Function()? shoppingBagImage,required int? quantity,required void Function()? plusSignCart,required void Function()? minusSignCart}) {
  return Padding(
    padding: const EdgeInsets.all(AppPadding.p12),
    child: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductView(productId:id, tag: 'tag$id', image: image,)));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height/4,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Container(
                width: MediaQuery.of(context).size.width/3,
                child: Card(
                  elevation: AppSize.s1_5,

                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s30),

                      child: Hero(
                          tag: 'tag$id',
                          child: Image(image: NetworkImage(image,),fit: BoxFit.contain,))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    SizedBox(

                      child: Text(name,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s16),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,),
                      width: MediaQuery.of(context).size.width/2.8,),
                    const SizedBox(height: AppSize.s10,),
                    Text('${price.toString()} EGP',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: FontSize.s16)),
                    Spacer(),
                    if (isCart) Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: plusSignCart, icon: const Icon(Icons.add),splashColor: Colors.transparent,),
                        const SizedBox(width: AppSize.s6,),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorManager.lightGray,
                              borderRadius: BorderRadius.circular(AppSize.s10)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(quantity.toString()),
                          ),
                        ),
                        SizedBox(width: AppSize.s6,),
                        IconButton( onPressed: minusSignCart , icon: Icon(Icons.remove),splashColor: Colors.transparent,),
                        const SizedBox(width: AppSize.s6,),

                      ],
                    ) ,

                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  IconButton(onPressed: crossImageFunction, icon: Image.asset('assets/images/icons/Shape.png'),splashColor: Colors.transparent,),
                  const Spacer(),
                  if (isCart == false) IconButton(onPressed: shoppingBagImage, icon: Image.asset('assets/images/icons/Add to cart button.png'),splashColor: Colors.transparent,),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
class CheckOutTitleAndButton extends StatelessWidget {
  const CheckOutTitleAndButton({
    super.key, required this.title, this.function, required this.iShippingAddress,
  });
  final String title;
  final  void Function()? function ;
  final bool iShippingAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
        const Spacer(),
        if(iShippingAddress)  IconButton(onPressed: function, icon: Icon(Icons.edit,color: ColorManager.primary,),splashColor: Colors.transparent,)
      ],
    );
  }
}

class MySpacer extends StatelessWidget {
  const MySpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: AppSize.s1,
        color: ColorManager.lightGray,
      ),
    );
  }
}


class OrdersCard extends StatelessWidget {
  const OrdersCard({
    super.key, required this.orderId, required this.date, required this.price, this.details, required this.status, required this.statusColor,
  });
  final String orderId;
  final String date;
  final dynamic price;
  final VoidCallback? details;
  final String status;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Row(
                children: [
                  Text('Order Id : $orderId',style: Theme.of(context).textTheme.bodyMedium,),
                  const Spacer(),
                  Text(date,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
                ],
              ),
            ),
            const MySpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('total amount:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
                const SizedBox(width: AppSize.s10,),
                Text('${price.toStringAsFixed(2)} Egp',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.primary),),

              ],
            ),
            const SizedBox(height: AppSize.s10,),

            Row(
              children: [
                buildMyButton(context, 'Details', details),
                const Spacer(),
                Text(status,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: statusColor))
              ],
            )


          ],
        ),
      ),
    );
  }
}

TextFormField mySearchTextFormField({required BuildContext context,required TextEditingController controller,required String label,IconData? iconData,Widget? suffixIcon, required bool obscure,required bool enableSuggestions,required bool autoCorrect,TextInputType? textInputType,var validate,void Function(String)? onChanged}){
  return TextFormField(
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),
    onChanged: onChanged,
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          width: 3,
          color: ColorManager.white,
        ),
      ),

      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: 2.0,
          )),
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(AppPadding.p16),
      label: Text(label,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),),
      suffixIcon: suffixIcon,
    ),
    obscureText: obscure,
    enableSuggestions: enableSuggestions,
    autocorrect: autoCorrect,
    keyboardType: textInputType,
    validator: validate,
  );
}