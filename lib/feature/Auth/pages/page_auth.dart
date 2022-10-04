import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/feature/Auth/managers/auth_manager.dart';
import 'package:informat/feature/Auth/managers/auth_state.dart';
import 'package:informat/feature/Auth/widgets/custom_button.dart';

class PageAuth extends ConsumerStatefulWidget {
  const PageAuth({super.key});

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
        key: key,
        animationStyle: PageAnimationStyle.fromTop,
        child: const PageAuth());
  }

  @override
  ConsumerState<PageAuth> createState() => _PageAuthState();
}

class _PageAuthState extends ConsumerState<PageAuth> {
  late AuthManager authManager;

  @override
  void initState() {
    super.initState();
    authManager = ref.read(authProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    if (state is AuthLoaded) {
      final profile = state.profileModel;
      if (profile != null) {
        Navigator.pop(context);
      } else {
        //To user to screen to complete profile
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                  backgroundImage: AssetImage(
                'assets/images/food_icon.png',
              )),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Meal Schedule',
              style: TextStyle(
                fontFamily: 'RubikBold',
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 60,
                child: AuthProviderButton(
                  text: 'Sign In with Google',
                  onPressed: () {
                    authManager?.loginWithGoogle();
                  },
                  icon: const Icon(FontAwesomeIcons.google),
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 60,
                child: AuthProviderButton(
                  text: 'Sign In with Apple',
                  onPressed: () {
                    GoRouter.of(context).go('/schedule/edit-profile');
                  },
                  icon: const Icon(FontAwesomeIcons.apple),
                )),
          ],
        ),
      ),
    );
  }
}
