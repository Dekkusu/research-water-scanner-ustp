import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/loader.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';

class SubmissionDocument extends StatefulWidget {
  final String cpNumber;

  const SubmissionDocument({Key? key, required this.cpNumber})
      : super(key: key);

  @override
  _SubmissionDocumentState createState() => _SubmissionDocumentState();
}

class _SubmissionDocumentState extends State<SubmissionDocument> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RegisteredUser?>(context);
    return StreamBuilder<UserComplaint>(
        stream: DatabaseService(uid: currentUser?.uid)
            .submittedComplaintsDocument(widget.cpNumber),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserComplaint? complaintDetail = snapshot.data;
            return SafeArea(
                child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            /*
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                               */
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
                                    labelText: complaintDetail!.address,
                                    labelStyle: const TextStyle(
                                        color: Color(0x80000000)),
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
                                    labelText: complaintDetail.description,
                                    hintText: "Input brief complaint details",
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 14,
                                        color: Colors.grey),
                                    labelStyle: const TextStyle(
                                        color: Color(0x80000000)),
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
                              ),
                            ),
                          ],
                        )),
                  )),
            ));
          } else {
            return Loading();
          }
        });
  }
}
