import 'package:examenflutter/MyDrawer.dart';
import 'package:flutter/material.dart';

import 'Pages/add_Anime.dart';
import 'Pages/home.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
    "/home": (context){
    return Home();
    },
    "/animeAdd": (context) => AddAnime(),

    },
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
     initialRoute: "/home",
    );
  }
}
