import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TfliteHome extends StatefulWidget{
  @override
  _TfliteHomeState createState() => _TfliteHomeState();
}

class _TfliteHomeState extends State<TfliteHome> {
  //Properties of image
  File _image;
  double _imageWidth=0;
  double _imageHeight=0;

  //Boolean to determine if model is busy
  bool _busy = false;
  //To determine when the picture is available
  bool _picture = false;

  //To determine how the image was retrieved
  bool _gallery = true;
  bool _camera = true;

  //To store the list of renderboxes
  List _recognitions;

  @override
  void initState(){
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;

      });
    });
  }
  //Load model.
  loadModel() async{
    try{
      String res;
      res = await Tflite.loadModel(
        //Input model name here
        model: "assets/tflite/saved_model.tflite",
        //Input label map here
        labels: "assets/tflite/labelmap.txt",
      );
    }
    //If model failed to load prompt error message
    on PlatformException{
      print("Failed to load the model");
    }
  }
  //Select Image from Gallery.
  selectFromImagePicker() async{

    var _picker = ImagePicker();
    var PickedFile = await _picker.getImage(source: ImageSource.gallery);
    File image = File(PickedFile.path);
    //If user does not pick an image
    if(image == null) return;
    //Set state to busy, gallery true and camera capture false.
    setState(() {
      _busy = true;
      _gallery = true;
      _camera = false;
    });

    predictImage(image);
  }
  //Select Image from Camera.
  selectFromCamera() async{
    var _picker = ImagePicker();
    var PickedFile = await _picker.getImage(source: ImageSource.camera);
    File image = File(PickedFile.path);
    //If user does not capture an image
    if(image == null) return;
    //Set state to busy, camera capture true and gallery false.
    setState(() {
      _busy = true;
      _camera = true;
      _gallery = false;
    });

    predictImage(image);
  }
  //Predict objects inside the image.
  predictImage(File image) async{
    if(image == null)return;

    await myModel(image); //Detect object
    //Using an image streamlistener to retrieve image width and height.
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info,bool _){
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));

    setState(() {
      _image = image;
      _picture = true;
      _busy = false;
    });

  }
  //Load model to detect objects inside image.
  myModel(File image) async{
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        numResultsPerClass: 1
    );

    setState(() {
      _recognitions = recognitions;
    });
  }

  //RenderBoxes to show the detected images
  List<Widget> renderBoxes(Size screen){
    if(_recognitions == null) return [];
    if(_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight/_imageHeight*_imageWidth;
    return _recognitions.map((re){
      //Position renderbox on image
      if(_gallery == true) {
        return Positioned(
          left: re["rect"]["x"] * factorX,
          top: re["rect"]["y"] * factorY,
          width: re["rect"]["w"] * factorX,
          height: re["rect"]["h"] * factorY,
          child: Container(
            decoration: BoxDecoration(border: Border.all(
              color: Colors.blue,
              width: 3,
            )),

            child: Text(
                //Display detected class name and percentage of confidence in class
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100)
                    .toStringAsFixed(0)}",
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontSize: 15,
                )),

          ),

        );
      }
      else if (_camera == true){
        //Position of renderbox on image
        return Positioned(
          left: re["rect"]["x"] * factorX,
          width: re["rect"]["w"] * factorX,
          height: re["rect"]["h"] * factorY/2,
          child: Container(
            decoration: BoxDecoration(border: Border.all(
              color: Colors.blue,
              width: 3,
            )),

            child: Text(
                //Display detected class name and percentage of confidence in class
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100)
                    .toStringAsFixed(0)}",
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontSize: 15,
                )),

          ),

        );
      }
    }).toList();

  }


  @override
  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren=[];
    //If user retrieve image from gallery
    if(_picture == true && _gallery == true){
      //Image is positioned based on the width of the screen.
      stackChildren.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        //Height of the image
        height: _imageHeight/_imageHeight*_imageWidth,
        child: _image == null ? Text("") : Image.file(_image),
      ));
      //Adding all renderboxes into the stack child for display
      stackChildren.addAll(renderBoxes(size));
    }
    //Image is retrieved from camera
    else if (_picture == true && _camera == true){
      //Only Width is specified here because height of image will always match height of screen.
      stackChildren.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        child: _image == null ? Text("") : Image.file(_image),
      ));
      //Adding all renderboxes into the stack child for display
      stackChildren.addAll(renderBoxes(size));
    }
    //Display loading icon animation of the model is still predicting.
    if(_busy){
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    //Page design of MOB
    return Scaffold(
        appBar: AppBar(
            title: Text("Music Object Detection")
        ),
        body: Stack(
              children: stackChildren,
            ),
      floatingActionButton: buildSpeedDial(),

    );
  }

  //A series of SpeedDial buttons
  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: true,
      curve: Curves.bounceIn,
      backgroundColor: Colors.black87,
      children: [
        //SpeedDial for camera button
        SpeedDialChild(
          child: Icon(Icons.camera, color: Colors.white),
          backgroundColor: Colors.black,
          onTap: () => selectFromCamera(),
          label: 'Camera',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
        //SpeedDial for gallery button
        SpeedDialChild(
          child: Icon(Icons.image, color: Colors.white),
          backgroundColor: Colors.black,
          onTap: () => selectFromImagePicker(),
          label: 'Gallery',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
      ],
    );
  }
}
