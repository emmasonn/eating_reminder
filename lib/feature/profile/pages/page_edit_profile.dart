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
import 'package:informat/core/widgets/custom_progress_widget.dart';
import 'package:informat/core/widgets/custom_text_field.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';

class PageEditProfie extends ConsumerStatefulWidget {
  const PageEditProfie({super.key});

  static Page page({LocalKey? key}) {
    return CustomPage<void>(
      key: key,
      animationStyle: PageAnimationStyle.slideLeft,
      child: const PageEditProfie(),
    );
  }

  @override
  ConsumerState<PageEditProfie> createState() => _PageEditProfieState();
}

class _PageEditProfieState extends ConsumerState<PageEditProfie> {
  String name = '';
  String telephone = '';
  String countryCode = '';
  String phoneNumber = '';
  String profileImage = '';
  ProfileManager? profileManager;
  ProfileModel? profileData;

  @override
  void initState() {
    super.initState();
    profileManager = ref.read(profileProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(profileProvider);
    if (state is ProfileLoaded) {
      setState(() {
        profileData = state.profileModel;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Edit Profile',
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
              showCustomDialog(
                context,
                CustomProgressDialog.cupertinoLoading(color: Colors.white),
              );
              profileManager?.saveProfile(
                profileData!.copyWith(
                  lastUpdated: DateTime.now(),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.floppyDisk),
          ),
        ],
      ),
      body: Container(
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
            InkWell(
                onTap: () {
                  
                  selectImage(ImageSource.gallery, (path) {
                    setState(() {
                      profileImage = path;
                    });
                  });

                  selectImageBottomSheet(
                    context,
                    fromGallery: () {
                      selectImage(ImageSource.gallery, (path) {
                        setState(() {
                          profileImage = path;
                        });
                      });
                    },
                    fromCamera: () {
                      selectImage(ImageSource.camera, (path) {
                        setState(() {
                          profileImage = path;
                        });
                      });
                    },
                  );
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    child: Image(
                      image: getImage(profileImage),
                      height: size.width,
                      fit: BoxFit.cover,
                    ),
                    //            const Icon(
                    //   FontAwesomeIcons.cameraRetro,
                    //   color: Colors.white,
                    //   size: 50,
                    // )
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'Name',
              displayHint: DisplayHint.inside,
              onChanged: (value) {
                name = value!;
              },
            ),
            CustomCountryCodesDropDown(
              onSelected: (value) {},
            ),
            CustomTextField(
              hintText: 'Phone Number',
              initialValue: '+234070454345',
              displayHint: DisplayHint.inside,
              onChanged: (value) {
                telephone = value!;
              },
            ),
            CustomTextField(
              hintText: 'Email Address',
              initialValue: 'Words.cs1@gmail.com',
              displayHint: DisplayHint.inside,
              onChanged: (value) {
                telephone = value!;
              },
            ),
          ],
        )),
      ),
    );
  }
}
