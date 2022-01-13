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
                    //margin: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // Image preview
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Container(
                                      width: 320,
                                      height: 250,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/placeholder_1.jpg'), // IDELETE LANG NI NGA PART KUNG NANAY CONDITION
                                            /*_image == null
                                                ? const AssetImage(
                                                'assets/images/placeholder_1.jpg')
                                                : FileImage(_image!)
                                            as ImageProvider, */ // MAO NING CONDITION PARA MUGAWAS ANG SA DATABASE

                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ]
                            ),

                            // Status Text
                            Center(
                              child: Container(
                                child: RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'Status: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                    TextSpan(
                                        text:
                                        //classCondition ? '$result' : 'No Input',
                                        'No Input',
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
                                alignment: const Alignment(-1, 1),
                                child: const Text(
                                  'Complaint Location',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 20,
                                maxLength: 150,
                                initialValue: complaintDetail!.address,
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF2eb86c),
                                        width: 2,
                                      )),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Container(
                                alignment: const Alignment(-1, 1),
                                child: const Text(
                                  'Description',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 20,
                                maxLength: 1000,
                                initialValue: complaintDetail.description,
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF2eb86c),
                                          width: 2,
                                        )),
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    )
                  ),
                )
            );
          } else {
            return Loading();
          }
        });
  }
}
