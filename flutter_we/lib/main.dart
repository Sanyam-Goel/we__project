import 'dart:convert';
import 'package:flutter_we/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_we/create_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  // Store token
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
  Future<void> handleLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      // Show an error message if the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username and password are required')),
      );
      return;
    }

    const url = 'http://192.168.1.7:3000/login'; // Replace with your login API endpoint
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userName': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final userData = json.decode(response.body);
        final token = userData['token']; // Replace 'key' with the actual key in the JSON response.
        // Store token
        saveToken(token);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // Handle login failure, display an error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please check your credentials.')),
        );
      }
    } catch (error) {
      // Handle network errors
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  
  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
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
                "Login",
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
                "Heyy, you're back!",
                style: TextStyle(fontSize: 15),
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        
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
                      handleLogin();
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
              // Separator line
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 1.0,
                      color: Colors.blueAccent,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(' Or ',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueAccent)),
                    ),
                    Container(
                      width: 150,
                      height: 1.0,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),

              // "Don't have an account?" text
              const Text("Don't have an account?"),
              // Create Now text
              TextButton(
                onPressed: () {
                  // Navigate to the registration screen when clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const CreateAccount(); // Replace CreateAccountScreen with the actual name of your screen.
                    }),
                  );
                },
                child: const Text('Create Now',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const CircularCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24.0, // Adjust the size as needed
        height: 24.0, // Adjust the size as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: activeColor,
          ),
          color: value ? activeColor : Colors.transparent,
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 18.0,
                color: Colors.white, // Adjust the checkmark color
              )
            : null,
      ),
    );
  }
}