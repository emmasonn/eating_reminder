import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/resources/app_theme.dart';
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
  @override
  Widget build(BuildContext context) {
    //listens to change in settingsModel darktheme to update the app theme
    final isDark = ref.watch(
        settingsProvider.select((settingsModel) => settingsModel.isDarkTheme));

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
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter
            .routerDelegate, //helps to construct the stack of pages that represents your app state.
      ),
    );
  }
}
