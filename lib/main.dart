import 'package:flutter/material.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/resources/app_theme.dart';
import 'package:provider/provider.dart' as pr;

import 'core/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //call boostrap function here
  await bootStrap();

  runApp(const FoodBlog());
}

class FoodBlog extends StatefulWidget {
  const FoodBlog({Key? key}) : super(key: key);

  @override
  State<FoodBlog> createState() => _FoodBlogState();
}

class _FoodBlogState extends State<FoodBlog> {
  @override
  Widget build(BuildContext context) {
    // ThemeData themeData;
    //   // if (themeTemp) {
    //   //   themeData = AppTheme.dark();
    //   // } else {
    //   //   themeData = AppTheme.light();
    //   // }

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
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter
            .routerDelegate, //helps to construct the stack of pages that represents your app state.
      ),
    );
  }
}
