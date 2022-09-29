import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/what_to_eat/pages/page_foods.dart';
import 'package:provider/provider.dart' as pr;
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final home = GoRoute(
      path: '/what-to-eat',
      name: 'what-to-eat',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomPage(key: state.pageKey, child: const PageFoods());
      },
      routes: [details]);

  static final collection = GoRoute(
      path: '/collection',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return PageFoods.page(key: state.pageKey);
      },
      routes: [details]);

  static final details = GoRoute(
    path: ':id',
    name: 'details',
    pageBuilder: (BuildContext context, GoRouterState state) {
      //here we retry our id from
      return PageFoods.page(key: state.pageKey);
    },
  );

  // static final addContact = GoRoute(
  //     path: 'add-contact',
  //     name: 'addContact',
  //     pageBuilder: (BuildContext context, GoRouterState state) {
  //       return PageAddContact.page(key: state.pageKey);
  //     });
}
