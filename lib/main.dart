


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/providers.dart';
import 'data/api/api_service.dart';
import 'data/models/models.dart';
import 'pages/pages.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchRestaurantsProvider(apiService: ApiService()),
        ),
      ],
      child:GetMaterialApp(
        debugShowCheckedModeBanner: false,
     
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
      ),
    );
  }
}
