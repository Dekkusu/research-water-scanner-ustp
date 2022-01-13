import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/home/view_submissions/view_submissions.dart';
import 'package:water_scanner_ustp/pages/home/submit_report/submit_complaint_tab.dart';
import 'manage_account/manage_account_tab.dart';
import 'home_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;

TimeOfDay now = TimeOfDay.now();

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Submissions _viewSubmissions = new Submissions();
    SubmitReport _submitNow = new SubmitReport();
    ManageUserForm _manageUser = new ManageUserForm();
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home_background.png'),
              fit: BoxFit.cover
            )
          ),
      child: Column(children: <Widget>[
        HomeGreetingHeader(size: size),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _viewSubmissions),
                  );
                },
                child: Center(
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  SvgPicture.asset("assets/icons/list.svg",
                      height: 60, width: 60),
                  //Icon(Icons.list, size: 70, color: Colors.brown),
                  const Text("\nSubmissions",
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 13)),
                ])),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(const Radius.circular(40))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _submitNow),
                  );
                },
                child: Center(
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  SvgPicture.asset("assets/icons/report.svg",
                      height: 50, width: 50),
                  //Icon(Icons.list, size: 70, color: Colors.brown),
                  const Text("\nSubmit\nComplaint",
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 13),
                      textAlign: TextAlign.center),
                ])),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _manageUser),
                  );
                },
                child: Center(
                    child:
                        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  SvgPicture.asset("assets/icons/user.svg",
                      height: 55, width: 55),
                  //Icon(Icons.list, size: 70, color: Colors.brown),
                  const Text("\nManage Profile",
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 13)),
                ])),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(const Radius.circular(40))),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
