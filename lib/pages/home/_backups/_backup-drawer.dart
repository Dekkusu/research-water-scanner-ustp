import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/home/manage_account/manage_account_tab.dart';
import 'package:water_scanner_ustp/pages/services/auth.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);
  final AuthService _auth= AuthService();

  final ManageUserForm _manage = ManageUserForm();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
            children: <Widget>[
              Container(
                  color: const Color.fromRGBO(153, 198, 142, 1),
                  child: Center(
                      child: Column(
                          children:<Widget>[
                            Container(
                                width:100,
                                height:100,
                                margin: const EdgeInsets.only(
                                  top: 30,
                                  bottom: 30,
                                ),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'), fit: BoxFit.fill)
                                )
                            )
                          ]
                      )
                  )
              ),

              ListTile(
                leading: const Icon(Icons.manage_accounts),
                title: const Text('Manage Account', style: TextStyle(fontSize: 16,)),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _manage),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout', style: TextStyle(fontSize: 16,)),
                onTap: () async {
                  await _auth.signOut();
                },
              )
            ]
        ),
      ),
    );
  }
}
