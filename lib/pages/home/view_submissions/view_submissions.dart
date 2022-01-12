import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/submissionList.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';

class Submissions extends StatelessWidget {
  const Submissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RegisteredUser?>(context); //important
    return StreamProvider<List<UserComplaint>>.value(
      initialData: [], //important
      value: DatabaseService(uid: currentUser?.uid)
          .submittedComplaints, //important
      builder: (context, snapshot) {
        //important
        return Scaffold(
          backgroundColor: Colors.white, //const Color(0xFFFCF6F5),
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
          //drawer: HomeDrawer(),
          body: SubmissionList(),
        );
      },
    );
  }
}
