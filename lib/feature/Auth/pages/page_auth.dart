import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/utils/riverpod_listener.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_ios_dialog.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_password_field.dart';
import 'package:informat/core/widgets/custom_progress_dialog.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/core/widgets/custom_top_snackbar.dart';
import 'package:informat/feature/Auth/manager/auth_manager.dart';
import 'package:informat/feature/Auth/manager/auth_state.dart';
import 'package:informat/feature/Auth/widgets/custom_button.dart';
import 'package:nb_utils/nb_utils.dart';

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
  String? email;
  String? password;

  //auth action
  AuthAction action = AuthAction.signIn;

  @override
  void initState() {
    super.initState();
    authManager = ref.read(authProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final state = ref.watch(authProvider);

    stateListener(() {
      log(state.runtimeType);

      if (state is AuthError) {
        showCustomTopSnackBar(
          context,
          msg: state.message,
          color: redColor,
        );
        Navigator.pop(context);
        //invalide authprovider
        reValidateState();
      } else if (state is AuthLoading) {
        
        showCustomDialog(
          context,
          const CustomProgressDialog(),
        );
      }
      // else if (state is AuthLoaded) {
      //   showCustomTopSnackBar(
      //     context,
      //     msg: action == AuthAction.signIn
      //         ? 'Logged in successfully'
      //         : 'Registration was successful',
      //     color: greenColor,
      //   );
      //   Navigator.pop(context);
      // }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor, size: 25),
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
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
              'Meal Scheduler',
              style: TextStyle(
                fontFamily: 'RubikBold',
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              alignment: Alignment.centerRight,
              child: action == AuthAction.signUp
                  ? TextButton(
                      child: Text(
                        'Sign In',
                        style: theme.textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: theme.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          action = AuthAction.signIn;
                        });
                      },
                    )
                  : TextButton(
                      child: Text(
                        'Sign Up',
                        style: theme.textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: theme.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          action = AuthAction.signUp;
                        });
                      },
                    ),
            ),
            CustomTextField(
              hintText: 'Email',
              displayHint: DisplayHint.inside,
              onChanged: (value) {
                email = value;
              },
            ),
            CustomPasswordField(
              hintText: 'Password',
              displayHint: DisplayHint.inside,
              onChanged: (value) {
                password = value;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text('Forgotten password'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                    height: 60,
                    child: AuthProviderButton(
                      text: action == AuthAction.signIn ? 'Sign In' : 'Sign Up',
                      onPressed: () {
                        validateFormAndSubmit();
                      },
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.primaryColorLight,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text('or'),
                    ),
                    Expanded(
                      child: Divider(
                        color: theme.primaryColorLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                      text: 'Sign In with Facebook',
                      onPressed: () {
                        GoRouter.of(context).go('/schedule/edit-profile');
                      },
                      icon: const Icon(FontAwesomeIcons.facebook),
                    )),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void validateFormAndSubmit() {
    if (email == null || email!.isEmpty) {
      log('Email should not be empty');
    } else if (password == null || email!.isEmpty) {
      log('Password should not be empty');
    } else {
      if (action == AuthAction.signIn) {
        ref.read(authProvider.notifier).loginEmail(email!, password!);
      } else {
        showCustomDialog(context, CustomIosDialog(
          onPressed: () {
            Navigator.pop(context);
            ref.read(authProvider.notifier).registerEmail(email!, password!);
          },
        ));
      }
    }
  }

  void reValidateState() {
    //invalidate the authProvider manually
    ref.invalidate(authProvider);
    //reinitialize authManager
    authManager = ref.read(authProvider.notifier);
  }
}
