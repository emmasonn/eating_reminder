import 'package:flutter/cupertino.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/Auth/pages/page_auth.dart';
import 'package:informat/feature/what_to_eat/pages/page_add_food.dart';
import 'package:informat/feature/meal_schedule/pages/page_schedule_groups.dart';
import 'package:informat/feature/profile/pages/page_edit_profile.dart';
import 'package:informat/feature/what_to_eat/pages/page_foods.dart';
import 'package:informat/feature/what_to_eat/pages/page_schedule.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class AppRoutes {
  static final home = GoRoute(
    path: '/what-to-eat',
    name: 'what-to-eat',
    redirect: (_) => '/what-to-eat',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomPage(
        key: state.pageKey,
        animationStyle: PageAnimationStyle.fade,
        child: const PageFoods(),
      );
    },
    routes: [
      login,
      details,
      editProfile,
    ],
  );

  static final scheduleGroups = GoRoute(
      path: '/schedule-groups',
      name: 'schedule-groups',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return PageScheduleGroups.page(key: state.pageKey);
      },
      routes: [
        schedule,
      ]);

  static final schedule = GoRoute(
      path: 'schedule/:id',
      name: 'schedule',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final String id = state.params['id'] ?? '';
        return PageMealSchedule.page(
          key: state.pageKey,
          scheduleId: id,
        );
      },
      routes: [
        addFood,
      ]);

  static final login = GoRoute(
    path: 'login',
    name: 'login',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return PageAuth.page(key: state.pageKey);
    },
  );

  static final addFood = GoRoute(
    path: 'add-food',
    name: 'add-food',
    pageBuilder: (BuildContext context, GoRouterState state) {
      final parameter = state.queryParams['day'] ?? '';
      final scheduleId = state.queryParams['id'] ?? '';

      return PageAddFood.page(
          key: state.pageKey, id: scheduleId, day: parameter);
    },
  );

  static final collection = GoRoute(
    path: '/collection',
    name: 'collection',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return PageFoods.page(key: state.pageKey);
    },
  );

  static final editProfile = GoRoute(
    path: 'edit-profile/:title',
    name: 'edit-profile',
    pageBuilder: (BuildContext context, GoRouterState state) {
      log(state.params);
      final parameter = state.params['title'];
      return PageEditProfie.page(key: state.pageKey, title: parameter);
    },
  );

  static final details = GoRoute(
    path: ':id',
    name: 'details',
    pageBuilder: (BuildContext context, GoRouterState state) {
      //here we retry our id from
      return PageFoods.page(key: state.pageKey);
    },
  );
}
