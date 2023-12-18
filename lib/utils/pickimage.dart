import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    return await image.readAsBytes();
  }

  //print("No image selected ");
}
