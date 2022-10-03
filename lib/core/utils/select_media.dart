import 'package:image_picker/image_picker.dart';
import 'package:informat/core/constants/enum_constants.dart';
import 'package:informat/core/helpers/image_processors.dart';

enum MediaType { image, video }

Future<void> selectImage(
    ImageSource source, Function(String) onSelected) async {
  final path = await uploadImage(source, type: CropType.Square);
  if (path != null) {
    onSelected(path);
  }
}
