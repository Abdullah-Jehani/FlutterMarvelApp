import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isValid = false;
  validation() async {
    if (phoneController.text.isNotEmpty &&
        phoneController.text.length == 9 &&
        passwordController.text.length >= 8) {
      isValid = true;
    } else {
      isValid = false;
    }

    setState(() {});
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            onChanged: () {
              validation();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Image.asset(
                    'assets/marvel_logo.png',
                    height: size.height * .125,
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneController,
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
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        if (isValid) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .login({
                            "phone": phoneController.text.toString(),
                            "password": passwordController.text.toString(),
                            "device_name": "iphone"
                          }, context).then(
                            (value) {
                              if (value.first) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ScreenRouter()),
                                    (route) => false);
                              } else {
                                SnackBar snakBar =
                                    SnackBar(content: Text(value.last));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakBar);
                              }
                            },
                          );
                        } else {
                          SnackBar snackBar = const SnackBar(
                              content: Text('Please Fill the Data'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 130),
                        child: Text("Login"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Text(
                        'Dont have an account ?',
                        style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                    context: context));
                          },
                          child: Text(
                            'Register Now !',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'poppins',
                                color: primaryColor),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
