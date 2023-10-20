//import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:flutter_we/home_page.dart';
import 'package:flutter_we/main.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscureText = true;
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleRegistration() async {
    final fullName = fullNameController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    if (fullName.isEmpty || username.isEmpty || password.isEmpty) {
      // Show an error message if any of the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    const url =
        'http://192.168.1.7:3000/create-user'; // Replace with your registration API endpoint

    try {
      final response = await http.post(Uri.parse(url), body: {
        'fullName': fullName,
        'email': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        //final userData = json.decode(response.body);
        // Handle successful registration and navigate to the next screen
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        // Handle registration failure, display an error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registration failed. Please try again.')),
        );
      }
    } catch (error) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Company logo
              Container(
                margin: const EdgeInsets.only(bottom: 5.0, top: 80),
                child: const Text(
                  "We",
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 22, 124, 207),
                  ),
                ),
                // Image.asset(
                //   'assets/company_logo.png', // Replace with your logo image
                //   width: 150.0,
                //   height: 150.0,
                // ),
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 22, 124, 207),
                ),
              ),
              // "Heyy, you're back!" text
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Let's make  you official!",
                style: TextStyle(fontSize: 15),
              ),
              //Full Name
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 6, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Full name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
              // Username field with label
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 6, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Username",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
              // Password field with label
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 6, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText:
                          _obscureText, // This controls password visibility
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Remember Me checkbox
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircularCheckBox(
                      value: true, // Add functionality to manage this state
                      onChanged: (value) {
                        // Handle remember me state change here
                      },
                      activeColor: Colors.blue, // Checkbox color
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('Remember Me',
                        style: TextStyle(color: Colors.blue)), // Text color
                  ],
                ),
              ),

              // Continue button
              Container(
                width: 359.0,
                height: 45,
                margin: const EdgeInsets.only(top: 35.0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius to 5
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle continue button click here
                      handleRegistration();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button background color
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 100,),
              // "Don't have an account?" text
              const Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text("By creating an account or signing you"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("agree to our"),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Terms and Conditions',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}