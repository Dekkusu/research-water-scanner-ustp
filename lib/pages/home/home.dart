import 'package:flutter/material.dart';
import './home_drawer.dart';
import './home_body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_scanner_ustp/pages/services/database.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  DatabaseService db = DatabaseService();

  Widget buildCallButton() => FloatingActionButton.extended(
      icon:
          SvgPicture.asset("assets/icons/phone_call.svg", color: Colors.white),
      onPressed: () {
        print('PRESSED BUTTON');
      },
      label: Text('Contact Us!',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: HomeDrawer(),
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  icon: SvgPicture.asset("assets/icons/menu.svg"),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        title: const Text(""),
        backgroundColor: const Color(0xFF30c272),
        elevation: 0.0,
      ),

      body: HomeBody(),

      floatingActionButton: buildCallButton(),
    );
  }
}
