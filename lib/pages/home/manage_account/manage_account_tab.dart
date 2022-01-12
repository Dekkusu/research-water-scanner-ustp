import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';
import 'package:provider/provider.dart';

import '../../loader.dart';

class ManageUserForm extends StatefulWidget {
  const ManageUserForm({Key? key}) : super(key: key);

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
      _destination;
  bool? _passVisible = true;

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
    final currentUser = Provider.of<RegisteredUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: currentUser?.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData? _userData = snapshot.data;
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
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Manage Profile text
                          Row(children: const <Widget>[
                            Text(
                              'Manage Profile',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 25,
                                  color: Colors.black),
                            ),
                          ]),

                          // Profile Picture
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                )
                              ]),

                          // Change Picture button
                          Row(
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
                          ),

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
                                    _imgSrc ?? _userData.image);

                                //  _destination = '$currentUserUid/profile/$_imgSrc';
                                //  await DatabaseService(uid: currentUserUid)
                                //      .uploadImg(_destination!, _profileImage!);
                              }
                              Navigator.pop(context);
                            },
                          ),
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
