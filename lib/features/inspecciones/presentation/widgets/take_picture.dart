import 'package:camera/camera.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/shared/shared.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({
    required this.camera,
    super.key,
  });

  final CameraDescription camera;

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomar Fotografía'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: LoadingIndicator());
          }
        },
      ),
    );
  }
}
