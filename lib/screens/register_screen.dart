import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword = true;
  bool hidePassword2 = true;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNameController = TextEditingController();
  bool isValid = false;
  validating() async {
    if (phoneController.text.length == 9 &&
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
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
                TextFormField(
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
                TextFormField(
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
                TextFormField(
                  obscureText: hidePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          const TextStyle(fontFamily: 'poppins', fontSize: 14),
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
                TextFormField(
                  obscureText: hidePassword2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle:
                          const TextStyle(fontFamily: 'poppins', fontSize: 14),
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
                TextButton(
                    onPressed: () {
                      if (isValid) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .register({
                          "phone": phoneController.text.toString(),
                          "password": passwordController.text.toString(),
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
                    child: const Text('Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
