import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'consultation1.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'classart.dart';
import 'package:commons/commons.dart';
import 'sidemenu.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';





class PrefGlob extends StatefulWidget {
     final String aname;
  final String email;
  final String url;
   final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;
PrefGlob({Key key, this.aname, this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);


  @override
  _PrefGlobState createState() => _PrefGlobState();

}

class _PrefGlobState extends State<PrefGlob> {
  bool imagevalid=false;
 DateTime datetimefin;
   List data = List();
 DateTime  configvalid1;
   TextEditingController dateController = TextEditingController();



   
  Future<http.Response> prefgolbales(date,boos) async {
  var url = 'https://${widget.url}/api/preferences/edit/${widget.aname}/$date';

  Map data = {
  "pmImages": boos
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}


Future getconfig() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/getpref/${widget.aname}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);



  setState(() {
      dateController.text=jsonData["pm_date"];
    });
    if(jsonData["pm_images"]==true){
      setState(() {
        imagevalid=true;
      });
    }else{
      setState(() {        imagevalid=false;
      });
    }

    print(jsonData);





   
    return "success";
  }
 @override
  initState() {
    super.initState();
    getconfig();
  

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Preferences Globales'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                );
              });
            },
          )
        ],
      ),
       drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
       body: Column(children: [

           Padding(
             padding: const EdgeInsets.all(12.0),
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [ Text("Afficher les Images des articles",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), 
                  Switch(value: imagevalid, onChanged:(value){
                    setState(() {
                  imagevalid= value;
                  print(imagevalid);
                });
                  } ),imagevalid==false?Icon(Icons.image_not_supported_rounded,size: 30,color: Colors.grey,):Icon(Icons.image_rounded,size: 30,color: Colors.grey),
                 
               ],),
           ),Divider(),Text("Generation des données\n"+"a partir:",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        
TextField(enabled: false,controller:dateController,textAlign: TextAlign.center,),
      TextButton(
    onPressed: () {
        DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2020, 1, 1),
                              maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                           
                          }, onConfirm: (date) {
                            print('confirm $date');
                             setState(() {
                              dateController.text=date.toString();
                            datetimefin=date;
                              
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.fr);
    },
    child: Text(
        'changer la date de list ',
        style: TextStyle(color: Colors.blue),
    ))
,
  FlatButton(
                    child: Text('Enregistrer'),
                    color: Color(0xffec524b),
                    textColor: Colors.white,
                    minWidth: 350,
                    height: 50,onPressed:() async {
                   var ss = DateFormat('yyyy-MM-dd hh:mm:ss').format(datetimefin); 
                      await prefgolbales(ss,imagevalid);
                    
                    
                    } ),     ],),
      
    );
  }
}