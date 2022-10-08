import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

enum ProfileMenu { edit, delete, logOut }

class ProfileDrawerHeader extends StatefulWidget {
  const ProfileDrawerHeader({super.key});

  @override
  State<ProfileDrawerHeader> createState() => _ProfileDrawerHeaderState();
}

class _ProfileDrawerHeaderState extends State<ProfileDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListTile(
            horizontalTitleGap: 4,
            leading: const SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                child: Icon(FontAwesomeIcons.person),
              ),
            ),
            title: Text(
              'Nnamani Chinonso',
              maxLines: 2,
              style: GoogleFonts.montserrat(fontSize: 14),
            ),
            subtitle: Text(
              'words.cs1@gmail.com',
              style: GoogleFonts.montserrat(fontSize: 14),
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
}
