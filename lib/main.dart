import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_fusion/constants/theme_constant.dart';
import 'package:food_fusion/states/map_state.dart';
import 'package:food_fusion/states/register_state.dart';
import 'package:food_fusion/states/user_state.dart';
import 'package:food_fusion/utills/local_storage.dart';
import 'package:food_fusion/view/auth/login_view.dart';
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
        ChangeNotifierProvider(create: (context) => UserState()),
        ChangeNotifierProvider(create: (context) => MapState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getTheme(),
      home: const LoginView(),
    );
  }
}
