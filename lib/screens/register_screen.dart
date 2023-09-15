import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword = true;
  bool hidePassword2 = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNameController = TextEditingController();
  bool isValid = false;
  validating() async {
    if (usernameController.text.length > 2 &&
        phoneController.text.length == 9 &&
        passwordController.text.length >= 8 &&
        passwordController.text == confirmPasswordController.text &&
        phoneNameController.text.isNotEmpty) {
      isValid = true;
    } else {
      isValid = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          onChanged: () {
            validating();
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/marvel_logo.png',
                  width: size.width * .5,
                  height: size.height * .2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'User name',
                      hintStyle: TextStyle(fontFamily: 'poppins', fontSize: 14),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field is Required!';
                      }
                      if (value.length <= 2) {
                        return 'Are You Sure thats your name ?';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(fontFamily: 'poppins', fontSize: 14),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field is Required!';
                      }
                      if (value.length != 9) {
                        return 'this Field Must Contain only 9 Characters';
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Phone Name',
                      hintStyle: TextStyle(fontFamily: 'poppins', fontSize: 14),
                    ),
                    controller: phoneNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field Cannot Be Empty!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: hidePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            fontFamily: 'poppins', fontSize: 14),
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field Is Required!';
                      }
                      if (value.length <= 8) {
                        return 'Weak Password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: hidePassword2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                            fontFamily: 'poppins', fontSize: 14),
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                          child: Icon(hidePassword2
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field Is Required!';
                      }

                      if (value != passwordController.text) {
                        return 'please enter the same password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      if (isValid) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .register({
                          "name": "Ali",
                          "phone": phoneController.text.toString(),
                          "password": passwordController.text.toString(),
                          "password_confirmation":
                              confirmPasswordController.text.toString(),
                          "device_name": phoneNameController.text.toString()
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'poppins'),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
