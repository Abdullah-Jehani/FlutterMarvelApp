import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, child) {
      return Scaffold(
        appBar: AppBar(),
        body: authConsumer.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authConsumer.userModel!.name,
                      style:
                          const TextStyle(fontFamily: 'poppins', fontSize: 30),
                    ),
                    Text(
                      authConsumer.userModel!.id.toString(),
                      style:
                          const TextStyle(fontFamily: 'poppins', fontSize: 30),
                    ),
                    Text(authConsumer.userModel!.isActivated.toString()),
                    Text(authConsumer.userModel!.isVerified.toString()),
                    Text(authConsumer.userModel!.isActive.toString()),
                  ],
                ),
              ),
      );
    });
  }
}
