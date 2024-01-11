import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:greenmate/common/widgets/PanelWidget.dart';
import 'package:greenmate/data/services/PlantDetectionService.dart';
import 'package:greenmate/features/screens/PlantResult.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:greenmate/utils/helpers/MediaSizeClipper.dart';


late List<CameraDescription> cameras;

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  late CameraController _cameraController;

  late Future<void> cameraValue;
  bool isFlashOn = false;
  int cameraPos = 0;
  final ImagePicker _picker = ImagePicker();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async{
    // take picture, store in path
    //final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    final XFile picture = await _cameraController.takePicture();
    final path = picture.path;
    _cameraController.setFlashMode(FlashMode.off);
    // Pindah ke page lain panggilnya API disana aja
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => PlantResult(path: path,)));
    
    // try{
    //   final result = await PlantDetectionService.detectPlant(path);
    //   print("Hasil" + result);
    //   showResult(context, result);
    // }catch (e){
    //   print(e);
    // }

  }

  void dispose(){
    super.dispose();
    _cameraController.dispose();
  }

  Future<void> chooseImageFromAlbum(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final path = pickedFile.path;

      // Pindah ke page lain
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => PlantResult(path: path,)));

      // // Call API + show result
      // try {
        final result = await PlantDetectionService.detectPlant(path);
        print("ini hasil dari seblumnya");
      //   print("Hasil" + result);
      //   showResult(context, result);
      //
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  // ini UI nya
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.15,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
        ),
        body: Stack(
          children: [
            // Camera
            FutureBuilder(future: cameraValue, builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){

                final mediaSize = MediaQuery.of(context).size;
                final scale = 1 / (_cameraController.value.aspectRatio * mediaSize.aspectRatio);

                return ClipRect(
                  clipper: MediaSizeClipper(mediaSize),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: CameraPreview(_cameraController),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),

            // Custom shutter button
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width / 2 - 45.0,
              child: InkWell(
                child: const Icon(Icons.panorama_fish_eye_outlined, color: Colors.white, size: 90.0),
                onTap: () {
                  takePhoto(context);
                },
              ),
            ),

            // Custom back button
            Positioned(
              top: 30.0,
              left: 20.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Icon to open album
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.22,
              right: 30.0,
              child: IconButton(
                icon: const Icon(Icons.photo_library, color: Colors.white, size: 30.0),
                onPressed: () {
                  chooseImageFromAlbum(context);
                },
              ),
            ),

            // Flash and Flip Camera icons
            Positioned(
              top: 30.0,
              right: 20.0,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon:  Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel: 'Flash Off'),
                    onPressed: () {
                      // Flash On/Off
                      setState(() {
                        isFlashOn = !isFlashOn;
                      });
                      _cameraController.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
                    },
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                    icon: const Icon(Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel: 'Flip Camera'),
                    onPressed: () async {
                      setState(() {
                        cameraPos = cameraPos == 0 ? 1 : 0;
                      });
                      _cameraController = CameraController(cameras[cameraPos], ResolutionPreset.max);
                      cameraValue = _cameraController.initialize();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}