import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_fusion/constants/theme_constant.dart';
import 'package:food_fusion/states/cart_state.dart';
import 'package:food_fusion/states/map_state.dart';
import 'package:food_fusion/states/register_state.dart';
import 'package:food_fusion/states/shop_state.dart';
import 'package:food_fusion/states/user_state.dart';
import 'package:food_fusion/utills/local_storage.dart';
import 'package:food_fusion/view/splash/splash_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterState()),
        ChangeNotifierProvider(create: (context) => MapState()),
        ChangeNotifierProvider(create: (context) => UserState()),
        ChangeNotifierProvider(create: (context) => ShopState()),
         ChangeNotifierProvider(create: (context) => CartState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      home: const SplashView(),
    );
  }
}

Map<String,dynamic> categories={
  "Biscuits":[
    'Biscuits',
    'Cookies',
    'Wafers',
    'Rusk',
    'Khari',
    'Toast',
    'Cream Biscuits',
  ],
  "Bread":[
    'Bread',
    'Buns',
    'Pav',
    'Pizza Base',
    'Bread Sticks',
    'Bread Crumbs',
    'Bread Rolls',
    'Bread Sticks',
    'Bread Crumbs',
    'Bread Rolls',
  
  ],
  "Cakes":[
    'Cakes',
    'Muffins',
    'Cup Cakes',
    'Rusk',
    'Khari',
    'Toast',
    'Cream Biscuits',
  
  ],
  "Chips":[
    'Chips',
    'Wafers',
    'Rusk',
    'Khari',
    'Toast',
    'Cream Biscuits',
  
  
  ],
};
