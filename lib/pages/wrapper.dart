import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/authenticate/authenticate.dart';
import 'package:water_scanner_ustp/pages/models/user.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RegisteredUser?>(context);
    if (currentUser == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
