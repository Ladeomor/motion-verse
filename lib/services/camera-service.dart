import 'package:camera/camera.dart';
import 'package:image/image.dart' as imageLib;
import 'package:montion_verse/services/tensorflow-service.dart';

// singleton class used as a service
class CameraService {
  // singleton boilerplate
  static final CameraService _cameraService = CameraService._internal();

  factory CameraService() {
    return _cameraService;
  }
  // singleton boilerplate
  CameraService._internal();

  TensorflowService _tensorflowService = TensorflowService();

  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  bool available = true;

  Future startService(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      // Get a specific camera from the list of available cameras.
      cameraDescription,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );

    // Next, initialize the controller. This returns a Future.
    return _cameraController?.initialize();
  }

  dispose() {
    _cameraController!.dispose();
  }

  Future<void> startStreaming() async {
    _cameraController!.startImageStream((img) async {
      try {
        if (available) {
          // Loads the model and recognizes frames
          available = false;

          await _tensorflowService.runModel(img);
          await Future.delayed(Duration(seconds: 1));
          available = true;
        }
      } catch (e) {
        print('error running model with current frame');
        print(e);
      }
    });
  }

  Future stopImageStream() async {
    await this._cameraController!.stopImageStream();
  }
  static imageLib.Image convertYUV420ToImage(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = imageLib.Image(width, height);

    for (int w = 0; w < width; w++) {
      for (int h = 0; h < height; h++) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final int index = h * width + w;

        final y = cameraImage.planes[0].bytes[index];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data[index] = CameraService.yuv2rgb(y, u, v);
      }
    }
    return image;
  }

  /// Convert a single YUV pixel to RGB
  static int yuv2rgb(int y, int u, int v) {
    // Convert yuv pixel to rgb
    int r = (y + v * 1436 / 1024 - 179).round();
    int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    int b = (y + u * 1814 / 1024 - 227).round();

    // Clipping RGB values to be inside boundaries [ 0 , 255 ]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
    ((b << 16) & 0xff0000) |
    ((g << 8) & 0xff00) |
    (r & 0xff);
  }
}
