import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "email",
                    hintStyle: TextStyle(color: Colors.grey)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a username';
                  }
                  if (value.length < 8) {
                    return "user email must be 8 characters";
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: hidePass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                decoration: InputDecoration(
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        child: Icon(hidePass
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    hintText: "password",
                    hintStyle: const TextStyle(color: Colors.grey)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter password";
                  }
                  if (value.length < 8) {
                    return "password must be 8 chars";
                  }

                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false).login({
                        "email": emailController.text.toString(),
                        "password": passwordController.text.toString(),
                      }).then((value) => {
                            if (value)
                              {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ScreenRouter()),
                                    (route) => false)
                              }
                          });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 130),
                      child: Text("Login"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
