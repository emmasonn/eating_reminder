import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:informat/core/navigation/app_routes.dart';
import 'package:informat/feature/what_to_eat/pages/page_foods.dart';
import 'package:informat/main.dart';


final goRouter = GoRouter(
    // initialLocation: ContactRoutes.home.path,
    initialLocation: '/',
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: foodManager,
    routes: [
     AppRoutes.home,
     AppRoutes.collection
    ],
    redirect: (GoRouterState state) {
      return null;
    },
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      print(state.error);
      // final pageFoods =
      //     pr.Provider.of<FoodManager>(context, listen: false);
      return PageFoods.page(key: state.pageKey,);
    });
