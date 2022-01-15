import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/home/home.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';
import 'package:provider/provider.dart';

import '../../loader.dart';

class ManageUserForm extends StatefulWidget {
  ManageUserForm({Key? key}) : super(key: key);
  @override
  _ManageUserFormState createState() => _ManageUserFormState();
}

class _ManageUserFormState extends State<ManageUserForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email,
      _userPassword,
      _fullname,
      _customAddress,
      _imgSrc,
      _userUid;
  bool? _passVisible = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? _profileImage;
  ImagePicker? imagePicker;

  _selectProfileImg() async {
    XFile? selectImg =
    await imagePicker!.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(selectImg!.path);
      if (_profileImage == null) {
        _imgSrc = "";
      } else {
        _imgSrc = _profileImage!.path.split('/').last;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Home _homepage = new Home();
    final currentUser = Provider.of<RegisteredUser?>(context);

    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: currentUser?.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData? _userData = snapshot.data;
            return Scaffold(
              backgroundColor: Color(0xFFFFF6F6),
              appBar: AppBar(
                  backgroundColor: Color(0xFF36454f),
                  elevation: 3.0,
                  leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2eb86c),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Manage Profile text
                          Row(children: const <Widget>[
                            Text(
                              'Manage\nProfile',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Color(0xFF36454f)),
                            ),
                          ]),

                          // Profile Picture
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: Container(
                                    width: phoneWidth * .8,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/manage_header.png'),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                )
                              ]),

                          // Change Picture button
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ElevatedButton(
                                  child: Container(
                                    child: _profileImage != null
                                        ? Image.file(
                                      _profileImage!,
                                      height: 150.0, //360
                                      width: 150.0, //400
                                      fit: BoxFit.cover,
                                    )
                                        : Container(
                                      width: 90,
                                      height: 30,
                                      child: const Center(
                                        child: Text(
                                          'Change picture',
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: _selectProfileImg,
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(15))),
                                    primary: Color(0xFF2eb86c),
                                  ),
                                ),
                              ),
                            ],
                          ),*/

                          // name text form field
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                            child: TextFormField(
                              initialValue: _userData!.name,
                              style: const TextStyle(
                                fontFamily: 'Raleway',
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.face),
                                  labelStyle: TextStyle(color: Color(0x80000000)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF2eb86c),
                                        width: 2,
                                      ))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name is required";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(
                                        () => _fullname = value.trim().toString());
                              },
                            ),
                          ),

                          // address text form field
                          /*
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextFormField(
                            //initialValue: _userData.address,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                            ),
                            decoration: InputDecoration(
                                labelText: 'Address',
                                prefixIcon: Icon(Icons.home),
                                labelStyle: TextStyle(color: Color(0x80000000)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF2eb86c),
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
                              setState(() => _customAddress = value.trim());
                            },
                          ),
                        ),
                        */

                          // email text field
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: _userData.email,
                              style: const TextStyle(
                                fontFamily: 'Raleway',
                              ),
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  labelStyle: TextStyle(color: Color(0x80000000)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF2eb86c),
                                        width: 2,
                                      ))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email is required";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() => _email = value.trim());
                              },
                            ),
                          ),

                          // password text form field
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: _userData.password,
                              style: const TextStyle(
                                fontFamily: 'Raleway',
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_passVisible!
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _passVisible = !_passVisible!;
                                      });
                                    },
                                  ),
                                  labelStyle:
                                  const TextStyle(color: Color(0x80000000)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF2eb86c),
                                        width: 2,
                                      ))),
                              obscureText: _passVisible!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is required";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() => _userPassword = value.trim());
                              },
                            ),
                          ),

                          // Save changes elevated button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Color(0xFF2eb86c),
                              textStyle: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Save Changes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              String? currentUserUid = currentUser!.uid;
                              if (_formKey.currentState!.validate()) {

                                await DatabaseService(uid: currentUserUid)
                                    .updateUserData(
                                    _fullname ?? _userData.name,
                                    _customAddress ?? _userData.address,
                                    _email ?? _userData.email,
                                    _userPassword ?? _userData.password,
                                    _imgSrc ?? _userData.image,
                                    _userUid ?? _userData.uid);

                                //  _destination = '$currentUserUid/profile/$_imgSrc';
                                //  await DatabaseService(uid: currentUserUid)
                                //      .uploadImg(_destination!, _profileImage!);
                              }
                              Navigator.pop(context);
                            },
                          ),

                          ElevatedButton(
                            style:  ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("Change Password",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2BAE66),
                                  fontSize: 12,
                                  //decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF2BAE66),
                                )
                            ),

                            onPressed: () async {
                              //reset password
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: _userData.email.toString());
                              final snackbar = SnackBar(
                                content:Text("Email sent incase you want to change password"),
                              );
                              //reset password ending

                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                      ),
                                      title: const Text(
                                        'Verification Required',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      content: const Text(
                                        'A verification link has been sent to your email. Please follow the instructions to change your password.',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                    _homepage),
                                                    (route) => false);
                                          },
                                          child: const Text(
                                            'I understand',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                      ]
                                  )
                              );
                            },
                          )
                        ],
                      )),
                ),
              ),
            );
          }else{
            return Loading();
          }
        });
  }
}