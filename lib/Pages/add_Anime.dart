import 'package:examenflutter/Pages/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../MyDrawer.dart';

class AddAnime extends StatefulWidget {
  const AddAnime({Key? key}) : super(key: key);

  @override
  State<AddAnime> createState() => _AddAnimeState();
}

class _AddAnimeState extends State<AddAnime> {
  TextEditingController nameController= TextEditingController();
  TextEditingController seasonController= TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _notZero=false;

  void _resetFields(){
    nameController.text="";
    seasonController.text="";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:MyDrawer(),
        appBar: AppBar(
          title: Text("Add Anime"),
        ),
        body:
        Form(
          key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter Anime name',
              labelText: '  Anime name',
            ),
              controller:nameController,
            validator: (value){
              if(value!.isEmpty){
                return("Enter a name!");
              }
            },
          ),
          TextFormField(
            decoration: const  InputDecoration(
              icon: const Icon(Icons.movie_creation_outlined),
              hintText: 'Enter a season',
              labelText: 'season',
            ),
            controller:seasonController,
            validator: (value){
              if(value!.isEmpty){
                return("Enter a season!");
              }
            },
          ),
    Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  test();
                  _resetFields();
                  Fluttertoast.showToast(msg: "New Anime added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                }

              }
              ,
              child: const Padding(padding: EdgeInsets.all(10.0),
                child: Text("Add",style: TextStyle(fontSize: 20),),),
              style: ElevatedButton.styleFrom(primary: Colors.pink),
            ),
          ),

    // new Container(
           //   padding: const EdgeInsets.only(left: 150.0, top: 40.0),
             //   child: const Text('Submit'),
               // onPressed: null,
              //)),
        ],
      ),
    ),
   );

  }
  Future<void> test() async{
     await SqlHelper.createConatct(nameController.text, seasonController.text);
    //await SqlHelper.updateContact(2,nameController.text, seasonController.text);
    //await SqlHelper.deletecontact(2);
    List<Map<String,dynamic>> journals=await SqlHelper.getConatcts();
    print("************");
    for(int i=0;i<journals.length;i++){
      print(journals[i]['id'].toString()+":"+journals[i]['nom']);
    }
    print("*********");
  }
}

