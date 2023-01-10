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
        final user = foodManager.profileModel;
        if (user != null && user.country != null) {
          return '/schedule-groups';
        } else {
          return '/what-to-eat/edit-profile/${'Complete Profile'}';
        }
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
