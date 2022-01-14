import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/submissionTile.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';

class SubmissionList extends StatelessWidget {
  const SubmissionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final submissionsList = Provider.of<List<UserComplaint>>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/view_background.png'),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
                  child: Row(children: const <Widget>[
                    Text(
                      'View\nSubmissions',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF36454f) ),
                    ),
                  ]),
                ),

                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: submissionsList.length,
                  itemBuilder: (context, index) {
                  return SubmissionTile(submission: submissionsList[index]);
                  }),
              ]
            ),
        ),
      ),
    );
  }
}
