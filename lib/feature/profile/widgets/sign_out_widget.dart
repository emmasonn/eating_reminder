import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';

class SignOutWidget extends ConsumerStatefulWidget {
  const SignOutWidget({super.key});

  @override
  ConsumerState<SignOutWidget> createState() => _SignOutWidgetState();
}

class _SignOutWidgetState extends ConsumerState<SignOutWidget> {
  late ProfileManager _profileManager;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _profileManager = ref.read(profileProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(profileProvider);
    if (state is SignOutLoading) {
      isLoading = true;
    } else if (state is SignOutError) {
      isLoading = false;
    }

    return Container(
      height: 200,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.appBarTheme.backgroundColor),
      child: !isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Are you sure to Sign out?',
                    style: TextStyle(fontFamily: 'Rubik')),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _profileManager.signOutUser();
                        Navigator.pop(context);
                      },
                      child: Text('Continue',
                          style: GoogleFonts.montserrat(fontSize: 14)),
                    ),
                  ],
                )
              ],
            )
          : const Center(
              child: Text(
                'Signing out...',
                style:
                    TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500),
              ),
            ),
    );
  }
}

void showSignOutDialog(BuildContext context) {
  showCustomDialog(context, const Center(child: SignOutWidget()));
}
