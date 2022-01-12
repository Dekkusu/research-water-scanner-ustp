import 'package:flutter/material.dart';
//import 'home_body.dart';

const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if ((timeNow >= 4) && (timeNow < 12)) {
    return 'Good\nMorning!';
  } else if ((timeNow >= 12) && (timeNow < 13)) {
    return 'Good\nNoon!';
  } else if ((timeNow >= 13) && (timeNow < 18)) {
    return 'Good\nAfternoon!';
  } else if ((timeNow >= 18) && (timeNow < 24)) {
    return 'Good\nEvening!';
  } else {
    return 'Good\nNight!';
  }
}

class HomeGreetingHeader extends StatelessWidget {
  HomeGreetingHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  String greetingMsg = greetingMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * .20,
        child: Stack(children: <Widget>[
          Container(
              padding: const EdgeInsets.only(
                left: 15 + kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              height: size.height * .20 - 27,
              decoration: const BoxDecoration(
                  color: const Color(0xFF2eb86c),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 10,
                      offset: Offset(-2, -2),
                      blurRadius: 15,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      //bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF30c272), Color(0xFF2BAE66)],
                  )),
              child: Row(children: <Widget>[
                Text(
                  greetingMsg,
                  style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ])),
        ]));
  }
}
