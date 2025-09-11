import 'package:flutter/material.dart';
import 'package:sio_ecommerce_mobile/dashboard.dart';
import 'package:sio_ecommerce_mobile/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/logo.png")),

          SizedBox(height: 22),

          Center(
            child: SizedBox(
              width: 280,
              height: 46,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),

          SizedBox(height: 27),

          Center(
            child: SizedBox(
              width: 280,
              height: 46,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),

          SizedBox(height: 11),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not have an account ?  "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 22),

          Center(
            child: SizedBox(
              height: 45,
              width: 187,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(39, 39, 39, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
                onPressed: () {
                  String mail = emailController.text.trim();
                  String pass = passwordController.text.trim();

                  if (mail.isEmpty || pass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Incorrect Credentials")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromRGBO(39, 39, 39, 1),
                        content: Text("Welcome 510 Squad",
                      textAlign: TextAlign.center,
                      )),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const DashboardPage(),
                      ),
                    );
                  }
                },
                child: Text("LOGIN"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
