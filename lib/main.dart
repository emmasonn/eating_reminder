import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/resources/app_theme.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart' as pr;
import 'core/navigation/app_router.dart';

void main() async {
  //call boostrap function here
  await bootStrap();

  runApp(const ProviderScope(
    child: FoodBlog(),
  ));
}

class FoodBlog extends ConsumerStatefulWidget {
  const FoodBlog({Key? key}) : super(key: key);

  @override
  ConsumerState<FoodBlog> createState() => _FoodBlogState();
}

class _FoodBlogState extends ConsumerState<FoodBlog> {
  ThemeMode appTheme = ThemeMode.light;
  ProfileManager? profileManager;

  @override
  void initState() {
    super.initState();
    profileManager = ref.read(profileProvider.notifier);
    if(profileManager!=null) {
    appTheme = profileManager!.currentTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return pr.MultiProvider(
      providers: [
        pr.ChangeNotifierProvider.value(
          value: foodManager,
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'FoodBlog',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: appTheme,
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter
            .routerDelegate, //helps to construct the stack of pages that represents your app state.
      ),
    );
  }
}
