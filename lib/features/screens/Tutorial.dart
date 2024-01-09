import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

    // Panggil API + show result
    try{
      final result = await detectPlant(path);
      showResult(context, result);
    }catch (e){
      print(e);
    }

  }

  void dispose(){
    super.dispose();
    _cameraController.dispose();
  }

  Future<String> detectPlant(String imagePath) async{

    return "test";
  }

  void showResult(BuildContext context, String result) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Analysis Result",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(result),
            ],
          ),
        );
      },
    );
  }

  // ini UI nya
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera
          FutureBuilder(future: cameraValue, builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){

              return CameraPreview(_cameraController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),

          // Custom shutter button
          Positioned(
            bottom: 30.0,
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
    );
  }
}