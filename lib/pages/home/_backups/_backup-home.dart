import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/home/home_drawer.dart';
import 'package:water_scanner_ustp/pages/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCF6F5),
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: const Color(0xFF2BAE66),
          elevation: 0.0,
        ),
        drawer: HomeDrawer(),
        body: SafeArea(
            child:
            Container(
                padding: const EdgeInsets.all(30),
                child:
                GridView.count(
                    crossAxisCount: 2,
                    children:<Widget>
                    [
                      Card(
                          margin: const EdgeInsets.all(8),
                          child: InkWell(
                              onTap: () {},
                              splashColor: Colors.green,
                              child: Center(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Icon(Icons.list, size: 70, color: Colors.brown),
                                        Text("\nSubmissions", style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
                                      ]
                                  )
                              )
                          )
                      ),
                      Card(
                          margin: const EdgeInsets.all(8),
                          child: InkWell(
                              onTap: () {},
                              splashColor: Colors.green,
                              child: Center(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Icon(Icons.feedback, size: 60, color: Colors.blueGrey),
                                        Text("\nSubmit Complaint", style: TextStyle(fontSize: 15)),
                                      ]
                                  )
                              )
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}

