import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informat/bootstrap.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/helpers/image_processors.dart';
import 'package:informat/core/utils/custom_select_image_dialog.dart';
import 'package:informat/core/utils/select_media.dart';
import 'package:informat/core/widgets/confirm_dialog.dart';
import 'package:informat/core/widgets/custom_page.dart';
import 'package:informat/core/widgets/custom_country_code_dropdown.dart';
import 'package:informat/core/widgets/custom_progress_dialog.dart';
import 'package:informat/core/widgets/custom_progress_widget.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/core/widgets/custom_top_snackbar.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:nb_utils/nb_utils.dart';

class PageEditProfie extends ConsumerStatefulWidget {
  const PageEditProfie({super.key, this.title});
  final String? title;

  static Page page({LocalKey? key, String? title}) {
    return CustomPage<void>(
      key: key,
      animationStyle: PageAnimationStyle.slideLeft,
      child: PageEditProfie(
        title: title,
      ),
    );
  }

  @override
  ConsumerState<PageEditProfie> createState() => _PageEditProfieState();
}

class _PageEditProfieState extends ConsumerState<PageEditProfie> {
  String? name;
  String? telephone;
  String? country;
  String? profileImage;
  String? email;
  ProfileManager? profileManager;
  ProfileModel? profileData;
  String? title;

  @override
  void initState() {
    super.initState();
    title = widget.title ?? 'Edit Profile';
    profileManager = ref.read(profileProvider.notifier);
    profileManager?.subScribeToProfile();
  }

  @override
  void dispose() {
    profileManager?.unsubscribeProfile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final state = ref.watch(profileProvider);

    if (state is ProfileLoaded) {
      setState(() {
        profileData = state.profileModel;
      });
    }

    ref.listen<ProfileState>(profileProvider, (prev, state) {
      if (state is ProfileLoading) {
        showCustomDialog(
          context,
          const CustomProgressDialog(),
        );
      } else if (state is ProfileUpdated) {
        //pop loading dialog
        Navigator.pop(context);

        if (state.status) {
          //show success dialog
          showCustomTopSnackBar(
            context,
            msg: 'Profile was updated',
            color: greenColor,
          );
        } else {
          //show failure dialog
          showCustomTopSnackBar(
            context,
            msg: 'Profile updated failed',
            color: redColor,
          );
        }
        setState(() {
          profileData = state.profileModel;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          widget.title ?? 'Edit Profile',
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
        actions: [
          IconButton(
            onPressed: () {
              profileManager?.saveProfile(
                profileData!.copyWith(
                  name: name,
                  newImageUrl: profileImage,
                  country: country,
                  telephone: telephone,
                  lastUpdated: DateTime.now(),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.check),
          ),
        ],
      ),
      body: profileData != null
          ? Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      backgroundImage: profileImage.isEmptyOrNull
                          ? profileData!.imageUrl != null
                              ? getImage(profileData!.imageUrl!)
                              : null
                          : getImage(profileImage!),
                      child: InkWell(
                        onTap: () {
                          selectImageBottomSheet(
                            context,
                            onSelected: (image) {
                              Navigator.pop(context);
                              setState(() {
                                profileImage = image;
                              });
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.cameraRetro,
                          color: profileImage.isEmptyOrNull
                              ? profileData!.imageUrl != null
                                  ? theme.primaryColor.withOpacity(0.5)
                                  : theme.primaryColor
                              : theme.primaryColor.withOpacity(0.5),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Name',
                    initialValue: profileData?.name,
                    displayHint: DisplayHint.inside,
                    onChanged: (value) {
                      name = value!;
                    },
                  ),
                  CustomCountryCodesDropDown(
                    initialValue: profileData?.country,
                    onSelected: (value) {
                      country = value!;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Phone Number',
                    initialValue: profileData?.telephone,
                    displayHint: DisplayHint.inside,
                    onChanged: (value) {
                      telephone = value!;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Email Address',
                    initialValue: profileData?.email,
                    displayHint: DisplayHint.inside,
                    onChanged: (value) {
                      email = value!;
                    },
                  ),
                ],
              )),
            )
          : Container(),
    );
  }
}
