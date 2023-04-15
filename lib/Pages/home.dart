import 'package:examenflutter/Pages/sql_helper.dart';
import 'package:flutter/material.dart';

import '../MyDrawer.dart';
import 'contact.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> images=[
    "images/avatar1.jpg",
    "images/avatar2.jpg",
    "images/avatar3.jpg",
    "images/avatar4.jpg",
    "images/avatar5.jpg",
    "images/avatar6.gif",
    "images/avatar7.jpg",
    "images/avatar8.jpg",
  ];
  Future<void> _deleteContact(id) async{
    await SqlHelper.deletecontact(id);
    _refreshJournal();
  }

  ShowAlertDialog(BuildContext context, String message) {
    Widget cancelButton = TextButton(onPressed: (){
      Navigator.pop(context, false);
    }, child: Text("Cancel"));
    Widget continueButton= TextButton(onPressed: (){
      _deleteContact(message);
    }, child: Text("Continue"));
    AlertDialog alert = AlertDialog(
      title: Text("Add to favory"),
      content: Text(message),
      actions: [cancelButton, continueButton,],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alert;
    },);
  }

  List<Map<String,dynamic>> _journals = [];
  bool _isLoading = true;

  List<Contact> lstContacts=[
    new Contact('Attack on Titan', 'season4', "images/attackontitan.jpg"),
    new Contact('Tokyo revengers', 'season2', "images/tokyorevengers.jpg"),
    new Contact('Fullmetal Alchemist', 'season 1', "images/fullmetal.jpg"),
    new Contact('Spy x Family', 'season 2', "images/spyxfamily.jpg"),
    new Contact('Demon Slayer', 'season 2', "images/demonslayer.jpg"),
    new Contact('Bleach Thounsd years of blood war', 'last season', "images/bleach.jpg"),

  ];


  Future<void> _refreshJournal() async{
    final data = await SqlHelper.getConatcts();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    _refreshJournal();
    return Scaffold(
        drawer:MyDrawer(),
        appBar: AppBar(
          title: Text("Anime List"),
        ),
        body: ListView.builder(
          itemCount: _journals.length,
          itemBuilder:(BuildContext context, index){
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(lstContacts[index].photo),backgroundColor: Colors.blue,
                ),
                title: Text(_journals[index]['nom']),
                subtitle: Text("season "+_journals[index]['tel']),
                onTap: (){
                  Widget deleteNumber = TextButton(onPressed: (){
                    _deleteContact(_journals[index]['id']);

                    Navigator.pop(context);
                  }, child: Text("Delete"));


                  AlertDialog alert = AlertDialog(
                    title: Text("Are you sure you want to delete this Anime?"),
                    actions: [deleteNumber],


                  );
                  showDialog(context: context, builder: (BuildContext context){
                    return alert;
                  });
                },
                trailing: Icon(Icons.delete),
              ),
            );
              },

          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,


        ));
  }

}
