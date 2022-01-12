import 'package:flutter/material.dart';
import 'package:water_scanner_ustp/pages/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterForm();
  }
}

class RegisterForm extends State<Register> {

  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email,  user_password;

  String? _error;
  bool? _passVisible = true;

  Widget _emailAdd(){
    return Theme(
      data: ThemeData().copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: Color(0xFF836953))),
      child: TextFormField(
        style: const TextStyle(
          fontFamily: 'Raleway',
        ),
        decoration: const InputDecoration(labelText: 'Email Address',
            prefixIcon: Icon(Icons.email),
            labelStyle: TextStyle(color: Color(0x80000000)),
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
          if(value!.isEmpty){
            return "Email is required";
          }else{
            return null;
          }
        },
        onChanged: (value){
          setState(() => email=value.trim());
        },
      ),
    );
  }
  Widget _password(){
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
            labelStyle: const TextStyle(color: Color(0x80000000)),
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
          setState(() => user_password=value.trim());
        },
      ),
    );
  }

  Widget _registerButton(){
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
              'Register Now',
              style:
              TextStyle(color: Colors.white),
            ),
      ),
      onPressed: () async {
        if(_formKey.currentState!.validate()){
          dynamic result = await _auth.registerUser(email!, user_password!);
          Navigator.pop(context);
          if(result == null){
            setState(() => _error = "All fields are required");
          }
        }
      },
    );
  }
  Widget _returnLogIn(){
    return ElevatedButton(
      style:  ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Text("Already have an account?",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xFF2BAE66),
            fontSize: 12,
            //decoration: TextDecoration.underline,
            decorationColor: Color(0xFF2BAE66),
          )
      ),
      onPressed: () => Navigator.pop(context),
      //child: Text('Log In'),
    );
  }

  Widget sboxMargin(){
      return const SizedBox(
        height: 15,
      );
  }

  //unused widgets
  Widget _confirmPass(){
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'Raleway',
      ),
      decoration: const InputDecoration(labelText: 'Confirm password',
          labelStyle: TextStyle(color: Color(0x80000000)),
          border: OutlineInputBorder(
              borderSide:
              BorderSide(
                  color: Colors.black,
                  width: 1
              )
          )
      ),
      validator: (value){
        if(value != user_password){
          return "Password must match";
        }else{
          return value;
        }
      },
      onChanged: (value){
        setState(() => user_password=value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF6F5),
        body: Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Container(
            margin: const EdgeInsets.all(35),
            child: Form(key: _formKey,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _emailAdd(),
                    sboxMargin(),
                    _password(),
                    sboxMargin(),
                    _registerButton(),
                    sboxMargin(),
                    _returnLogIn(),
                  ],
                )
            ),
           ),
          ),
        ),
    );
  }
}
