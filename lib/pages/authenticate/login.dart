import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/authenticate/register.dart';
import 'package:water_scanner_ustp/pages/services/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LogInForms();
  }
}

class LogInForms extends State<LogIn>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  Register reg = const Register();

  String? _email;
  String? _password;
  bool? _passVisible = true;

  Widget _emailAddField() {
    return Theme(
      data: ThemeData().copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: Color(0xFF836953))),
      child: TextFormField(
        style: const TextStyle(
            fontFamily: 'Raleway'),
        decoration: const InputDecoration(labelText: 'Email Address',
            prefixIcon: Icon(Icons.email),
            labelStyle: TextStyle(color: Color(0x80000000),
                fontFamily: 'Montserrat'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFF2eb86c),
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        validator: (value){
          if(value!.isEmpty || !value.contains('@')){
            return "Enter a valid email address";
          }else{
            return null;
          }
        },
        onChanged: (value){
          setState(() => _email=value.trim());
        },
      ),
    );
  }

  Widget _passAddField() {
    return Theme(
      data: ThemeData().copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: Color(0xFF836953))),
      child: TextFormField(
        style: const TextStyle(fontFamily: 'Raleway'),
        decoration: InputDecoration(labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(icon: Icon(_passVisible! ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passVisible = !_passVisible!;
                });
              },
            ),
            labelStyle: const TextStyle(color: Color(0x80000000),
                fontFamily: 'Montserrat'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFF2eb86c),
                  width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        obscureText: _passVisible!,
        validator: (value){
          if(value!.isEmpty){
            return "Password is required";
          }else{
            return null;
          }
        },
        onChanged: (value){
          setState(() => _password=value.trim());
        },
      ),
    );
  }

  Widget _logInButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        primary: const Color(0xFF2eb86c),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Align(alignment: Alignment.center,
        child: Text(
          'Log In',
          style:
          TextStyle(color: Colors.white),
        ),
      ),
      onPressed: (){
        if(_formKey.currentState!.validate()){
          _auth.signInWithCredentials(_email!, _password!);
        }
      },
    );
  }

  //No func yet ---
  Widget _forgotPassword(){
    return ElevatedButton(
      style:  ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Text("Forgot your password?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xFF2BAE66),
            fontSize: 10,
            decorationColor: Color(0xFF2BAE66),
          )
      ),
      onPressed: () async {
        return;
      },
    );
  }

  Widget _createAccount(){
    return ElevatedButton(
      style:  ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Text("Don't have an account?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xFF2BAE66),
            fontSize: 12,
            //decoration: TextDecoration.underline,
            decorationColor: Color(0xFF2BAE66),
          )
      ),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => reg),
        );
      },
    );
  }

  //use for debugging
  Widget _signInAnon(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        primary: Colors.greenAccent[700],
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Align(alignment: Alignment.center,
        child: Text(
          'Log In Anon',
          style:
          TextStyle(color: Colors.white),
        ),
      ),
      onPressed: (){
        _auth.signInAnon();
      },
    );
  }

  Widget sboxMargin(){
    return const SizedBox(
      height: 15,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F5),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(35),
              child: Form(key: _formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    _emailAddField(),
                    sboxMargin(),
                    _passAddField(),
                    //_forgotPassword(),
                    sboxMargin(),
                    _logInButton(),
                    //const SizedBox(height: 10),
                    //_signInAnon(),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:_createAccount(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}