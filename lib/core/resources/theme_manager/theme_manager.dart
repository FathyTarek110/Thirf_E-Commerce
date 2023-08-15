
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_manger/color_manager.dart';
import '../font_manger/font_manager.dart';
import '../style_manger/style_manager.dart';
import '../values_manager/values_manger.dart';

ThemeData appTheme(){
  return ThemeData(
    //colors
    primaryColor: ColorManager.primary,
    disabledColor: ColorManager.gray,
    splashColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.smokeWhite,

    //appbar theme

    appBarTheme: AppBarTheme(
      color: ColorManager.smokeWhite,
      centerTitle: true,
      titleTextStyle: getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.smokeWhite,
        statusBarIconBrightness: Brightness.dark
      ),
      elevation: 0,

    ),


    //card theme
    cardTheme: CardTheme(
      elevation: AppSize.s1_5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      color: ColorManager.white

    ),
    // text theme
    
    textTheme: TextTheme(
      bodySmall: getRegularStyle(color: ColorManager.gray, fontSize: FontSize.s12),
      bodyMedium: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      bodyLarge: getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s26)
    ),

    //button theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        disabledBackgroundColor: ColorManager.gray,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s6)
        )
      )
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),buttonColor: ColorManager.primary,
      disabledColor: ColorManager.gray
    ),



    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.mediumGray, fontSize: FontSize.s14),
      labelStyle: getRegularStyle(color: ColorManager.gray,fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.red,fontSize: FontSize.s14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGray,
            width: AppSize.s1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGray,
            width: AppSize.s1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.red,
            width: AppSize.s1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.red,
            width: AppSize.s1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),

        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(color: ColorManager.primary),
      selectedIconTheme:IconThemeData(
        color: ColorManager.primary
      ),
      backgroundColor: ColorManager.white,
      elevation: AppSize.s4
    )

  );
}