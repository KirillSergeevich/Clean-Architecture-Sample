import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/domain/client_interfaces/picture_picker_client.dart';

class PicturePickerClientImpl extends PicturePickerClient {
  @override
  Future<List<String>> pickPictures() async {
    final rawImage = await ImagePicker().pickMultiImage();
    var images = <String>[];
    if (rawImage != null) {
      for (var picture in rawImage) {
        final tempPath = (await getTemporaryDirectory()).path;
        final compressedImage = await (FlutterImageCompress.compressAndGetFile(
          picture.path,
          '$tempPath/${picture.name}.jpg',
          quality: 20,
        ));
        images.add(compressedImage!.path);
      }
    }
    return images;
  }
}
