import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informat/core/resources/colors.dart';
import 'package:informat/core/utils/select_media.dart';

class ImageButtomSheetWidget extends StatelessWidget {
  const ImageButtomSheetWidget({
    Key? key,
    required this.cameraClicked,
    required this.galleryClicked
  }) : super(key: key);
  final Function() galleryClicked;
  final Function() cameraClicked;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16.0),
                  child: Text('Select Image',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      splashColor: lightPink.withOpacity(0.2),
                      onTap: () => cameraClicked,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            'Camera',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () => galleryClicked,
                      child: Column(
                        children: [
                          const Icon(Icons.photo_rounded,
                              size: 50, color: Colors.blue),
                          Text('Gallery ',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

void selectImageBottomSheet(
  BuildContext context, {
  required Function() fromGallery,
  required Function() fromCamera,
}) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return ImageButtomSheetWidget(
          cameraClicked: fromCamera,
          galleryClicked: fromGallery,
        );
      });
}
