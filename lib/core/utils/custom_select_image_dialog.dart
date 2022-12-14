import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informat/core/resources/colors.dart';
import 'package:informat/core/utils/select_media.dart';

class ImageButtomSheetWidget extends StatelessWidget {
  const ImageButtomSheetWidget({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);
  final Function(String) onImageSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  child: Text('Select Image', style: theme.textTheme.subtitle1),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      splashColor: lightPink.withOpacity(0.2),
                      onTap: () {
                        selectImage(ImageSource.gallery, (path) {
                          onImageSelected(path);
                        });
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text('Camera', style: theme.textTheme.subtitle2),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {
                        selectImage(ImageSource.gallery, (path) {
                          onImageSelected(path);
                        });
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.photo_rounded,
                              size: 50, color: Colors.blue),
                          Text('Gallery ', style: theme.textTheme.subtitle2),
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
  required Function(String) onSelected,
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
          onImageSelected: onSelected,
        );
      });
}
