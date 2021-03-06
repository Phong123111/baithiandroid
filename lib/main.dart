import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'ContactDetail.dart';
import 'contact.dart';
import 'listContact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppPageState createState() => new _MyAppPageState();
}

class _MyAppPageState extends State<MyApp> {
  Future<List<Contact>> list;


  var items = [];

  @override
  void initState()
  {
    super.initState();

    list = fetchData();
  }




  @override
  Widget build(BuildContext context) {

    final title =  'Danh bạ';
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xff007E33),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.verified_user,color: Colors.white), onPressed: (){})
          ],
          title: Text(title/**,style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,  fontSize: 20, fontWeight:FontWeight.w600
            )
          ),**/),
        ),
        body: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(2.0),
              margin: EdgeInsets.all(5.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  prefix: Icon(Icons.search),
                  labelText: 'Search'
                ),
                onChanged: (value){
                },
              ),
            ),
            new Expanded(
              child: new FutureBuilder(
                  future: list,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {{
                    if(snapshot.hasData){
                      var contact = snapshot.data;
                      return ListView.builder(
                          itemCount: contact.length,
                          itemBuilder: (BuildContext context, int index){
                            var item = contact[index];
                            return new Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white70,width: 1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: GestureDetector(
                                child: new Container(
                                  margin: EdgeInsets.all(9.0),
                                  padding: EdgeInsets.all(6.0),
                                  child: ListTile(
                                    leading:     AvatarLetter(
                                      size: 45,
                                      backgroundColor: Colors.amber,
                                      textColor: Colors.black,
                                      fontSize: 20,
                                      upperCase: true,
                                      numberLetters: 2,
                                      letterType: LetterType.Circular,
                                      text: item.ten,
                                    ),
                                    title: Text(item.ten),
                                    subtitle: Text(item.sdt),
                                    trailing: new Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children:[

                                        IconButton(onPressed: (){
                                          if(item.yeuthich==true) {
                                            setState(() {
                                              item.yeuthich = false;
                                            });
                                          }
                                          else {
                                            setState(() {
                                              item.yeuthich = true;
                                            });
                                          }
                                        }, icon: item.yeuthich==true?
                                          Icon(Icons.favorite_outline):Icon(Icons.favorite,color: Colors.red,)
                                        ),
                                        IconButton(onPressed: (){
                                          var dialog = AlertDialog(
                                            title: const Text('Xóa'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text('Bạn có muốn số điện thoại này không?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Không', style: TextStyle(color: Colors.blueAccent),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Xóa', style: TextStyle(color: Colors.redAccent)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                          showDialog(context: context, builder: (context){
                                            return dialog;
                                          });
                                        }, icon: Icon(Icons.delete, color: Colors.green,))
                                      ]
                                    ),
                                  )
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetail(contact: item)));
                                },
                              ),
                            );
                          }
                      );
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  }

                  },
              )
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(onPressed: null,
          child: new Icon(Icons.add),
          backgroundColor: Color(0xff007e33),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

}

