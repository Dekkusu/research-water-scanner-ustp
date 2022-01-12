import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/submission_document.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';

class Submissions extends StatelessWidget {
  const Submissions({Key? key}) : super(key: key);
/*
  Widget _buildTileList(BuildContext context, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(document['address']), //change to date + Submission #
          subtitle: Text(document['description']), //change to status
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        //SubmissionDocument(document: document)));
          },
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RegisteredUser?>(context);
    final submissionsList = Provider.of<List<UserComplaint>>(context);
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
              })));


  }
}
/*
     body:
StreamProvider<List<UserComplaint>>.value(
              initialData: [],
              value: DatabaseService(uid: currentUser?.uid).submittedComplaints,
    builder: (context, snapshot) {
    return
  ListView.builder(
                  itemCount: submissionsList.length,
                  itemBuilder: (context, index) =>
                      _buildTileList(context, ));
            });
 */