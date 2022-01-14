import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/authenticate/login.dart';
import 'package:water_scanner_ustp/pages/home/manage_account/manage_account_tab.dart';
import 'package:water_scanner_ustp/pages/services/auth.dart';
import '../authenticate/login.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  final LogIn _loginPage = LogIn();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/denr_backgroundBlurred.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/denr_logo.png'),
                    radius: 45,
                  ),
                ),
                Align(
                    alignment:
                        Alignment.centerRight + const Alignment(-.075, -.20),
                    child: const Text(
                        'Department of\nEnvironment and\nNatural Resources',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black,
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ))),
                Align(
                    alignment:
                        Alignment.centerRight + const Alignment(-.075, .59),
                    child: const Text('Water Scanner Application',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 10,
                          //fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black,
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ))),
              ])),

          /*ListTile(
                leading: const Icon(Icons.manage_accounts),
                title: const Text('Manage Account', style: TextStyle(fontSize: 16,)),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _manage),
                  );
                },
              ),*/

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  ),
                  onTap: () async {
                    await _auth.signOut();

                  }))
        ]),
      ),
    );
  }
}
