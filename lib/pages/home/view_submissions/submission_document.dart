import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? _imgLink;
    return StreamBuilder<UserComplaint>(
        stream: DatabaseService(uid: currentUser?.uid)
            .submittedComplaintsDocument(widget.cpNumber),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserComplaint? complaintDetail = snapshot.data;
            _imgLink =  complaintDetail!.imageUrl;  // DEX WALA NA NAKO GIGAMIT ANG _imgLink KAY DILI MAGAMIT SA NETWORK IMAGE
            return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
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
                                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                                    child: Container(
                                      width: 320,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        image: DecorationImage(
                                          image: NetworkImage(complaintDetail.imageUrl) as ImageProvider, // AKOA NA GIDIRETSO complaintDetail.imageUrl
                                          fit: BoxFit.cover,
                                        )
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
                                        'Subject to Inspection',
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
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 5),
                              child: TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 20,
                                maxLength: 150,
                                initialValue: complaintDetail.address,
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

                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
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
