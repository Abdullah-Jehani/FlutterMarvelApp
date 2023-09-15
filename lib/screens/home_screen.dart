import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/providers/movie_provider.dart';
import 'package:marvel_app/screens/my_profile.dart';

import 'package:marvel_app/widgets/custom_icon_button.dart';
import 'package:marvel_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchMovies();
    super.initState();
  }
  // we use provuider.of to get the instance of the provider class
  // we use listen false because we dont want to rebuild the widget

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MoviesProvider>(builder: (context, movie, child) {
      return Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MyProfile()));
                    },
                    child: const ListTile(
                      title: Text('My Profile'),
                      trailing: Icon(Icons.verified_user_outlined),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const ListTile(
                      title: Text('Settings'),
                      trailing: Icon(Icons.settings),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout()
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const ScreenRouter()),
                            (route) => false);
                      });
                    },
                    child: const ListTile(
                      title: Text('Logout'),
                      trailing: Icon(Icons.exit_to_app),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/marvel_logo.png',
              width: size.width * .25,
            ),
            actions: [
              CustomIconButton(
                  asset: "assets/icons/dm.png",
                  color: primaryColor,
                  onpressed: () {}),
              CustomIconButton(
                  asset: "assets/icons/heart_outlined.png",
                  color: primaryColor,
                  onpressed: () {})
            ],
          ),
          body: movie.isFailed
              ? RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .fetchMovies();
                    });

                    if (kDebugMode) {
                      print('done');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: ListView(
                      children: const [
                        Center(
                          child: Text(
                            'SomeThing Went Wrong!',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GridView.builder(
                      itemCount: movie.isLoading ? 20 : movie.movies.length,
                      itemBuilder: (context, index) {
                        return movie.isLoading
                            ? Container(
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.2),
                                    border: Border.all(
                                        color: primaryColor.withOpacity(0.3)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                                child: SizedBox(
                                  child: Shimmer.fromColors(
                                      baseColor: primaryColor.withOpacity(0.2),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16))),
                                      )),
                                ),
                              )
                            : MovieCard(movieCard: movie.movies[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1 / 1.5),
                    ),
                  ),
                )

          //  Center(
          //     child: CircularProgressIndicator(
          //       color: primaryColor,
          //     ),
          //   )
          );
    });
  }
}
