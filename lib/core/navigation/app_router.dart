import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/navigation/app_routes.dart';
import 'package:informat/feature/what_to_eat/pages/page_foods.dart';

final goRouter = GoRouter(
    // initialLocation: ContactRoutes.home.path,
    initialLocation: '/what-to-eat',
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: foodManager,
    routes: [
      AppRoutes.home,
      AppRoutes.scheduleGroups,
      AppRoutes.collection,
    ],
    redirect: (GoRouterState state) {
      final isUserLogggedIn = foodManager.isUserExist;
      if (state.location == '/schedule-groups' && !isUserLogggedIn) {
        return '/what-to-eat/login';
      } else if (state.subloc == '/what-to-eat/login' && isUserLogggedIn) {
        return '/schedule-groups';
      }
      return null;
    },
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      // final pageFoods =
      //     pr.Provider.of<FoodManager>(context, listen: false);
      return PageFoods.page(
        key: state.pageKey,
      );
    });
