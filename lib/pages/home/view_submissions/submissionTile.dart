import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/submission_document.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';

class SubmissionTile extends StatelessWidget {
  final UserComplaint submission;
  SubmissionTile({required this.submission});

  @override
  Widget build(BuildContext context) {
    void _showSubmittedDocument(String complaintNumber) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              child: SubmissionDocument(
                cpNumber: complaintNumber,
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(submission.address),
          subtitle: Text(submission.status),
          onTap: () => _showSubmittedDocument(submission.complaintNum),
        ),
      ),
    );
  }
}
