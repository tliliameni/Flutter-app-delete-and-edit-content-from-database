import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.pinkAccent,
                  ]
                )
              ),
              child: Center(
             child: CircleAvatar(
            backgroundImage: AssetImage("images/1.jpg"),
                radius: 110,

          ))),
          ListTile(
            title: Text("Anime list",style: TextStyle(fontSize: 24,color: Colors.pinkAccent)),
            leading:Icon(Icons.home,color: Colors.blueAccent,),
            trailing:Icon(Icons.arrow_right,color: Colors.blueAccent,) ,
            onTap: (){
          Navigator.pushNamed(context, "/home");
            },
          ),
          Divider(height: 5,color: Colors.pinkAccent,),
          ListTile(
            title: Text("Add Anime",style: TextStyle(fontSize: 24,color: Colors.pinkAccent),),
            leading: Icon(Icons.animation,color: Colors.blueAccent,),
            trailing:Icon(Icons.arrow_right,color: Colors.blueAccent,) ,
            onTap: (){
              Navigator.pushNamed(context, "/animeAdd");
            },
          ),
          Divider(height: 5,color: Colors.pinkAccent,),
          ListTile(
            title: Text("Sign out",style: TextStyle(fontSize: 24,color: Colors.pinkAccent),),
            leading: Icon(Icons.close,color: Colors.blueAccent,),
            trailing:Icon(Icons.arrow_right,color: Colors.blueAccent,) ,
            onTap: (){
              Navigator.of(context).pop();

            },
          ),

        ],
      ),
    );
  }
}
