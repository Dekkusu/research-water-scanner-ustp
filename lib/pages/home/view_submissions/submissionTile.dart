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
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)
              )
          ),
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: .65,
              child: ListView(
                physics: BouncingScrollPhysics(),
                  children: [
                    SubmissionDocument(
                        cpNumber: complaintNumber),
                  ]
              ),
            );
          }
      );
    }

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              tileColor: Color(0xFFFAFAFA),
              title: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(submission.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'Raleway',
                        fontSize: 17),
                  ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(submission.status,
                  style: TextStyle(fontFamily: 'Montserrat',
                    fontSize: 13),
                ),
              ),

              onTap: () => _showSubmittedDocument(submission.complaintNum),
            ),
          ),
      ),
    );
  }
}
