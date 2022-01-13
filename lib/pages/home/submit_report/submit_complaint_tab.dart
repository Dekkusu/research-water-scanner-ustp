import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/home/home_body.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';
import '../home.dart';

class SubmitReport extends StatefulWidget {
  SubmitReport({Key? key}) : super(key: key);
  @override
  _SubmitReport createState() => _SubmitReport();
  HomeBody _homepage = new HomeBody();
}

//   https://www.youtube.com/watch?v=s_giODpCY9U

class _SubmitReport extends State<SubmitReport> {
  final _formKey = GlobalKey<FormState>();
  final Home _homepage = Home();
  bool isLoading = false;

  String? _address, _description;

  Future<File>? pickedImage; //
  File? _image; //
  String result = ' ';
  String? _destination, _imgName, _downloadImageUrl;
  String _status = 'uncleaned';
  ImagePicker? imagePicker; //
  var classCondition = false;

  getImageFromGallery() async {
    XFile? tempStore = await imagePicker!.pickImage(
        source: ImageSource
            .gallery); // getImage                   //await ImagePicker().pickImage(source:ImageSource.gallery);

    setState(() {
      _image = File(tempStore!.path);
      _imgName = _image!.path.split('/').last;
      doImageClassification();
    });
  }

  capturePhotoFromCamera() async {
    XFile? tempStore = await imagePicker!.pickImage(
        source: ImageSource
            .camera); // getImage                   //await ImagePicker().pickImage(source:ImageSource.gallery);

    _image = File(tempStore!.path); //!

    setState(() {
      _image = File(tempStore.path);
      _imgName = _image!.path.split('/').last;
      doImageClassification();
    });
  }

  loadMyModel() async {
    String? resultant = await Tflite.loadModel(
      labels: 'assets/labels.txt',
      model: 'assets/model_unquant.tflite',
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    print(result);
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadMyModel();
  }

  doImageClassification() async {
    var recognitions = await Tflite.runModelOnImage(
      path: _image!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2, //number of results possible predict
      threshold: 0.1,
      asynch: true,
    );
    print(recognitions!.length.toString());
    setState(() {
      result = '';
    });
    recognitions.forEach((element) {
      setState(() {
        print(element.toString());
        result += element['label'] + '\n\n';
      });
    });
    classCondition = true;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RegisteredUser?>(
        context); //important para ni ma detect kinsay user
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3.0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF2eb86c),
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Submit Complaint Title
                        Row(children: const <Widget>[
                          Text(
                            'Submit Complaint',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ]),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Container(
                                  width: 320,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: _image == null
                                            ? const AssetImage(
                                                'assets/images/placeholder_1.jpg')
                                            : FileImage(_image!)
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ]),

                        // Upload Image button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: ElevatedButton(
                            onPressed: getImageFromGallery,
                            onLongPress: capturePhotoFromCamera,
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.upload,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Upload Image',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 12,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              primary: const Color(0xFF2eb86c),
                            ),
                          ),
                        ),

                        // Classification
                        Center(
                          child: Container(
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Classification: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                    text:
                                        classCondition ? '$result' : 'No Input',
                                    style: const TextStyle(
                                      color: Colors.green,
                                    )),
                              ]),
                              maxLines: 1,
                            ),
                          ),
                        ),

                        // Complaints Area
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                          child: Container(
                            alignment: const Alignment(-.95, 1),
                            child: const Text(
                              'Complaint Location',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 20,
                            maxLength: 150,
                            decoration: InputDecoration(
                                hintText: "Location",
                                hintStyle: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 14,
                                    color: Colors.grey),
                                //labelText: "Complaint Location",
                                labelStyle:
                                    const TextStyle(color: Color(0x80000000)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2eb86c),
                                      width: 2,
                                    ))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address is required";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() => _address = value.trim());
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Container(
                            alignment: const Alignment(-.95, 1),
                            child: const Text(
                              'Description',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 20,
                            maxLength: 1000,
                            decoration: InputDecoration(
                                //labelText: "Description",
                                hintText: "Input brief complaint details",
                                hintStyle: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 14,
                                    color: Colors.grey),
                                labelStyle:
                                    const TextStyle(color: Color(0x80000000)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2eb86c),
                                      width: 2,
                                    ))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Description is required";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() => _description = value.trim());
                            },
                          ),
                        ),

                        Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: const Color(0xFF2eb86c),
                              textStyle: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            child: isLoading ?
                            FittedBox(
                              child: CircularProgressIndicator(color: Colors.white,
                                  strokeWidth: 5),
                            )

                                : Text('Submit Complaint',
                              style: TextStyle(color: Colors.white),
                            ),

                            onPressed: () async {
                              String? currentUserUid = currentUser!.uid;
                              if (_formKey.currentState!.validate()) {
                                setState(() => isLoading = true);

                                //to upload firebase storage
                                _destination =
                                    '$currentUserUid/complaint-images/$_imgName';
                                await DatabaseService(uid: currentUserUid)
                                    .uploadImg(_destination!, _image!);

                                _downloadImageUrl = await DatabaseService(uid: currentUserUid)
                                    .uploadImg(_destination!, _image!);

                                await DatabaseService(uid: currentUserUid)
                                    .submitComplaintData(_address!, _description!,
                                    _imgName!, _status, _downloadImageUrl!);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            title: const Text(
                                              'Submission Recorded',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            content: const Text(
                                              'Your submission has been queued. It may take 3-5 business days for your submission to be reviewed.',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  //Navigator.pop(context);
                                                  /*Navigator.push(
                                                        context,
                                                          MaterialPageRoute(builder: (context) => _homepage),

                                                      );*/
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (c) =>
                                                                  _homepage),
                                                          (route) => false);
                                                },
                                                child: const Text(
                                                  'Understood',
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              )
                                            ]));
                              } else {
                                // AlertDialog
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            title: const Text(
                                              'Missing Fields!',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            content: const Text(
                                              'Please provide the necessary information to proceed.',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Okay',
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              )
                                            ]));
                              }
                              //Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )),
              )),
        )));
  }
}
