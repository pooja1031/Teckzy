import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teckzy/componenets/mytextfield.dart';
import 'package:teckzy/productscreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(authToken: response.body),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to authenticate. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: _usernameController, hintText: '', labelText: 'username',
            ),
            SizedBox(height: 20,),
            MyTextField(
              controller: _passwordController, hintText: '', labelText: 'password',
             obscureText: true, 
            ),
            SizedBox(height: 20),
           MaterialButton(
      onPressed: _login,
     color: Colors.black,
     minWidth: 200, 
    height: 50,
     child: Text(
    'Login',
    style: TextStyle(color: Colors.white,fontSize: 20), 
  ),
)

          ],
        ),
      ),
    );
  }
}

