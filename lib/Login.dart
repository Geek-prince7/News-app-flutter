import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController companyCodeController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool rememberMe;
  late bool isLoading;


  @override
  void initState() {
    companyCodeController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rememberMe = false;
    isLoading = false;



    super.initState();
  }

  @override
  void dispose() {
    companyCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }





  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    final email = emailController.text;
    final password = passwordController.text;
    final companyCode = companyCodeController.text;

      final response = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {


        Navigator.popAndPushNamed(context, 'home');
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                response.body,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        );
        throw Exception('Failed to get user');
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Text(
                'NEWSX',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontFamily: 'Futura',
                  letterSpacing: 2,
                  // shadows: [
                  //   Shadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     offset: Offset(2, 2),
                  //     blurRadius: 4,
                  //   ),
                  // ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TextField(
                      //   // inputFormatters: [
                      //   //   FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      //   // ],
                      //   // textCapitalization: TextCapitalization.characters,
                      //   controller: companyCodeController,
                      //   style: TextStyle(color: Colors.blue[900]),
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Colors.blue[100],
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     hintText: 'Company Code',
                      //     hintStyle: TextStyle(
                      //       color: Colors.blue[700],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      TextField(
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        // ],
                        // controller: emailController,
                        style: TextStyle(color: Colors.blue[900]),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[20],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        // ],
                        controller: passwordController,
                        style: TextStyle(color: Colors.blue[900]),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[20],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.blue[700],
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                                fillColor:
                                MaterialStateColor.resolveWith(
                                        (states) => Colors.blue),
                              ),
                              Text(
                                'Remember Me',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle forgot password action
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      isLoading
                          ? SizedBox(
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          // child: const RiveAnimation.asset(
                          //   'graphics/box_loader_orange.riv',
                          //   fit: BoxFit.fitHeight,
                          // ),
                        ),
                      )
                          : SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
