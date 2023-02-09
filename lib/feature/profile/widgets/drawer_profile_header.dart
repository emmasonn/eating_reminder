import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/helpers/image_processors.dart';
import 'package:informat/feature/Auth/widgets/custom_button.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:informat/feature/profile/widgets/sign_out_widget.dart';

enum ProfileMenu { edit, delete, logOut }

class ProfileDrawerHeader extends ConsumerStatefulWidget {
  const ProfileDrawerHeader({
    super.key,
    required this.onSignOut,
  });
  final Function() onSignOut;
  @override
  ConsumerState<ProfileDrawerHeader> createState() =>
      _ProfileDrawerHeaderState();
}

class _ProfileDrawerHeaderState extends ConsumerState<ProfileDrawerHeader> {
  ProfileModel? profileModel;
  late ProfileManager _profileManager;

  @override
  void initState() {
    super.initState();
    _profileManager = ref.read(profileProvider.notifier);
    _profileManager.subScribeToProfile();
  }

  @override
  void dispose() {
    _profileManager.unsubscribeProfile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(profileProvider);
    if (state is ProfileLoaded) {
      profileModel = state.profileModel;
    }
    String profileImage = profileModel?.imageUrl ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: profileModel != null
              ? ListTile(
                  horizontalTitleGap: 10,
                  leading: InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .go('/what-to-eat/edit-profile/${'Edit Profile'}');
                      widget.onSignOut.call();
                    },
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: theme.primaryColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 26,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: profileImage.isEmpty
                                ? const Icon(FontAwesomeIcons.person)
                                : getImageWidget(profileImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      if (profileModel != null &&
                          profileModel!.name.isNotEmpty) ...[
                        Text(
                          profileModel?.name ?? '',
                          maxLines: 2,
                          style: theme.textTheme.subtitle1
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ] else ...[
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).go(
                                '/what-to-eat/edit-profile/${'Complete Profile'}');
                            widget.onSignOut.call();
                          },
                          child: Text(
                            'Complete profile', //profileModel?.name ??
                            maxLines: 2,
                            style: theme.textTheme.subtitle1?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        profileModel?.email ?? '',
                        maxLines: 2,
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.primaryColorLight.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            widget.onSignOut.call();
                            showSignOutDialog(context);
                          },
                          child: Text(
                            'Sign Out',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: AuthProviderButton(
                    icon: const Image(
                      image: AssetImage('assets/images/food_icon.png'),
                      height: 20.0,
                      width: 20.0,
                    ),
                    header: 'Setup Profile',
                    onPressed: () {
                      GoRouter.of(context).go('/what-to-eat/login');
                      widget.onSignOut.call();
                    },
                    text: 'Sign In',
                  ),
                ),
        ),
        // PopupMenuButton<ProfileMenu>(
        //     padding: const EdgeInsets.all(0.0),
        //     child: const Padding(
        //       padding: EdgeInsets.only(right: 8.0),
        //       child: Icon(
        //         Icons.more_vert,
        //       ),
        //     ),
        //     onSelected: (ProfileMenu item) {
        //       if (item == ProfileMenu.edit) {
        //       } else if (item == ProfileMenu.delete) {}
        //     },
        //     itemBuilder: (BuildContext context) =>
        //         <PopupMenuEntry<ProfileMenu>>[
        //           PopupMenuItem<ProfileMenu>(
        //             value: ProfileMenu.edit,
        //             child: Text(
        //               'Edit Profile',
        //               style: GoogleFonts.montserrat(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.blue),
        //             ),
        //           ),
        //           PopupMenuItem<ProfileMenu>(
        //             value: ProfileMenu.logOut,
        //             child: Text(
        //               'Log Out',
        //               style: GoogleFonts.montserrat(
        //                   fontSize: 14,
        //                   color: Colors.blue,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           PopupMenuItem<ProfileMenu>(
        //             value: ProfileMenu.edit,
        //             child: Text(
        //               'Delete Account',
        //               style: GoogleFonts.montserrat(
        //                   fontSize: 14,
        //                   color: Colors.red,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //         ]),
      ],
    );
  }

  // void showSignOutDialog() {
  //   showCustomDialog(
  //       context,
  //       Center(
  //         child: Container(
  //           height: 200,
  //           width: 250,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             color: Colors.white,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Are you sure to Sign out?',
  //                 style: GoogleFonts.montserrat(fontSize: 14),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text(
  //                       'Cancel',
  //                       style: GoogleFonts.montserrat(fontSize: 14),
  //                     ),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       _profileManager.SignOutUser();
  //                     },
  //                     child: Text('Continue',
  //                         style: GoogleFonts.montserrat(fontSize: 14)),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }
}
