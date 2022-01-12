import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/submissionTile.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';

class SubmissionList extends StatelessWidget {
  const SubmissionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final submissionsList = Provider.of<List<UserComplaint>>(context);
    return ListView.builder(
        itemCount: submissionsList.length,
        itemBuilder: (context, index) {
          return SubmissionTile(submission: submissionsList[index]);
        });
  }
}
