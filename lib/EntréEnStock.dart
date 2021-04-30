import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

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

import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'classart.dart';

class Entre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Entre();
  final String aname;
  final String email;
  Entre({Key key, this.aname, this.email}) : super(key: key);

}

class _Entre extends State<Entre> {
  String msg = "0";
  String _scanBarcode = 'Unknown';
  String selectedName;
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  TextEditingController qteController = TextEditingController();
  String vl='e';
  List data = List();
 
  bool go=false;
  bool isloading=false;
  
  final List<Channel> channelList=<Channel>[];
  Future getAllName() async {
    var response = await http.get(
        Uri.parse(
            "https://192.168.1.9:8000/api/Depot/selection/${widget.aname}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
    });
    print(jsonData);
    return "success";
  }
 bb(response) async{
   if (response.statusCode==404){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Article not found"),
          content: new Text("cette article n'existe pas "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isloading=false;
                });
              },
            ),
          ],
        );
      },
    );
  }else if (response.body != null) {

  

   
       var jsonBody = response.body;
    var artdata = json.decode(jsonBody);
    
    var blob = artdata[1]['arPhoto'];
    var slag=artdata[0]['arRef'];

  var imags= await writeImageTemp(blob,slag );
    var contain = channelList.where((element) => element.arRef == slag);
if (contain.isNotEmpty)

  {
     return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Vous avez deja ajouté ce article"),
          content: new Text("Modifier le parameter de ce article!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isloading=false;
                });
              },
            ),
          ],
        );
      },
    );

  } else {

     
 
      setState(() {
        isloading=false;
      });
    
      return showDialog(
          context: context,
          builder: (BuildContext context) {
          
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE5BDF6),
                        Color(0xFFD8DEDE),
                      ],
                    )),
                height: 353,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 
                  children: [Container(
   child: imags != null // Here is important!
        ? ClipOval(
 child: new Image.file(imags,
    width: 60,
    height: 60,
    fit: BoxFit.cover,
  ),

                  ): ClipOval(
 child: new Image.asset('images/net.png',
    width: 60,
    height: 60,
    fit: BoxFit.cover,
  ),)),
            

                    Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       Column( mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                          children: [Text('Reference : '),Text('Design : '),Text('Qte : '),Text('Depot code : '),Text('Depot : ')
                           
                          ],
                        ),
                   
                    Column( mainAxisAlignment: MainAxisAlignment.start,
                               mainAxisSize: MainAxisSize.max,
                      children: [
                        new Text(artdata[0]['arRef']), new Text(artdata[0]['arDesign']), new Text(removeTrailingZero(artdata[0]['asQtesto']), style: new TextStyle(
      fontSize: 20.0,fontWeight: FontWeight.bold,
      color: Colors.yellow,
    ),),  new Text(artdata[0]['deCode']), new Text(artdata[0]['deIntitule']),
                      ],
                    ),
                   ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:55.0, top:30),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xffEC524B),
                              foregroundColor: Colors.white,
                              onPressed: () {
                                // Respond to button press
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              controller: qteController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    width: 10,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                labelText: 'Qte',
                                labelStyle: TextStyle(
                                    color: Color(0xFF8B8B8B), fontSize: 12),
                                hintText: 'Qte a ajouté',
                                hintStyle: TextStyle(
                                    color: Color(0xFF8B8B8B), fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FloatingActionButton(
                              backgroundColor: const Color(0xffEC524B),
                              foregroundColor: Colors.white,
                              onPressed: () {
                                // Respond to button press
                              },
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200.0,
                        child: RaisedButton(
                          onPressed: () { setState(() { var qte=double.parse(qteController.text) ;var qtes=double.parse(artdata[0]['asQtesto']) ;
                         channelList..add(Channel(artdata[0]['arRef'],artdata[0]['arDesign'],artdata[0]['deCode'],imags, artdata[0]['deIntitule'],qtes ,qte));
                         go=true;  }); Navigator.pop(context);},
                          child: Text(
                            "add",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF5853A1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }}
  
}
  Future<File> writeImageTemp(String base64Image, String imageName) async {
   Uint8List bytes = base64.decode(base64Image);

final appDir = await syspaths.getTemporaryDirectory();
  imageName=imageName+'.jpg';
File file = File('${appDir.path}/'+imageName);

await file.writeAsBytes(bytes);


  return file;
}
  

  Future getArticlebarre(value1, value2) async {

    String dep = value1;
    String bar = value2;
    var response = await http.get(
        Uri.parse("https://192.168.1.9:8000/api/articlebar/$dep/$bar"),
        headers: {"Accept": "application/json"});

  var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    print(jsonData);
    return response;
  }

  @override
  initState() {
    super.initState();
    getAllName();
    
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
      var mm= await getArticlebarre(selectedName,barcodeScanRes);
    return bb(mm);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
 
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Entrée en stock'),
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
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                });
              },
            )
          ],
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('yassine'),
                accountEmail: new Text('afsayassine@gmail.com'),
                decoration: BoxDecoration(
                    color: const Color(0xFF00897b),
                    image: DecorationImage(
                        image: AssetImage("images/asd.jpg"), fit: BoxFit.fill)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: new AssetImage('images/avataaars.png'),
                ),
              ),
              new ListTile(
                  leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 20,
                        maxWidth: 28,
                        maxHeight: 28,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Image.asset('images/homeicon.png',
                            fit: BoxFit.fill),
                      )),
                  title: new Text('Acceuil'),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Menu()),
                      );
                    });
                  }),
              new ListTile(
                  title: new Text('Entrée en stock'),
                  leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                        maxWidth: 29,
                        maxHeight: 29,
                      ),
                      child: Container(
                          child:
                              Image.asset('images/in1.png', fit: BoxFit.fill))),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Entre()),
                      );
                    });
                  }),
              new ListTile(
                  title: new Text('Sortie du Stock'),
                  leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 21,
                        maxWidth: 28,
                        maxHeight: 28,
                      ),
                      child: Container(
                          margin: EdgeInsets.only(left: 1),
                          child: Image.asset('images/out2.png',
                              fit: BoxFit.fill))),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sortie()),
                      );
                    });
                  }),
              new ListTile(
                  title: new Text('Transfert du Stock'),
                  leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 21,
                        minHeight: 21,
                        maxWidth: 26,
                        maxHeight: 26,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Image.asset('images/exchange2.png',
                            fit: BoxFit.fill),
                      )),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tran()),
                      );
                    });
                  }),
              new ListTile(
                  title: new Text('Inventaire'),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                      maxWidth: 28,
                      maxHeight: 26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Image.asset('images/inventory2.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => inventaire()),
                      );
                    });
                  }),
              new ListTile(
                  title: new Text("Consultation d'historique"),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                      maxWidth: 28,
                      maxHeight: 28,
                    ),
                    child: Image.asset('images/his2.png', fit: BoxFit.cover),
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Consultation()),
                      );
                    });
                  }),
              Divider(
                color: Colors.grey,
              ),
              new ListTile(
                  title: new Text('Gestion des utilisateurs'),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 27,
                      minHeight: 24,
                      maxWidth: 32,
                      maxHeight: 30,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Image.asset('images/usr.png', fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {}),
              new ListTile(
                  title: new Text('Parametre'),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                      maxWidth: 30,
                      maxHeight: 25,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Image.asset('images/parametre.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {}),
              new ListTile(
                  title: new Text('log out'),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 25,
                      minHeight: 25,
                      maxWidth: 30,
                      maxHeight: 28,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset('images/IMg4.png', fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {}),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 35, left: 35, bottom: 8),
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 45,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(width: 0.6, style: BorderStyle.solid),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: Text('Sélectionner un entrepôt'),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 33,
                      value: selectedName,
                      items: data.map((list) {
                        return DropdownMenuItem(
                          child: Text(list['deIntitule']),
                          value: list['deIntitule'],
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedName = value;
                          msg = selectedName;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 15),
              child: Center(
                child: Image.asset(
                  'images/scan.png',
                  cacheWidth: 300,
                  cacheHeight: 120,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  child:  !isloading
                    ?FlatButton(
                    child: Text('Scanner code a barre'),
                    color: Color(0xffec524b),
                    textColor: Colors.white,
                    minWidth: 350,
                    height: 50,
                    onPressed: ()  {
                      setState(() {isloading=true;
                      
                        
              
                      }); scanBarcodeNormal();
                           
                    },
                  ):CircularProgressIndicator(),
                ),
              ),
            ),
        
           new SizedBox(height: 10,),
         Visibility( maintainSize: true, 
  maintainAnimation: true,
  maintainState: true, visible:go==true,
           child: new  Container(height: 50,
                 decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xff2193b0),
                Color(0xff6dd5ed),
              ])),
               child:Center(child: Text("Produit Ajoutées",style: TextStyle(fontSize: 18,color: Colors.white)))),
         ),
           Expanded(
             child: SizedBox(height: 200.0,
               child: ListView.builder(itemCount: channelList.length, scrollDirection: Axis.vertical,
                 itemBuilder: (context,index){ var a=channelList[index].qte.toString(); var b=channelList[index].qtesto.toString();
                  final item =channelList[index].toString() ;
                 return  Dismissible(key: Key(item),
                  onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  channelList.removeAt(index);
                  if(channelList.length==0){setState(() {
                    go=false;
                  });}
                });ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              }, background: Container(color: Colors.red,child: Icon(Icons.delete,color: Colors.white,size: 18,)),

                   child: Container(
                     child: Card(
                       child: ListTile(onTap: (){},title: Text(channelList[index].arDesign),leading:  
                       ClipOval(
                  child: new Image.file(channelList[index].arImage,
                       width: 60,
                       height: 60,
                       fit: BoxFit.cover,
                     ),
                     ) ,        trailing: 
                  
                     RichText(
  text: TextSpan(
    text: 'Quantité en Stock\n',
    style: DefaultTextStyle.of(context).style,
    children: <TextSpan>[
      TextSpan(text: removeTrailingZero(b)+'\n ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
      TextSpan(text:'(+'+removeTrailingZero(a)+')',style:TextStyle(color: Colors.green)),
    ],
  ),
 textAlign: TextAlign.center,),
                     
                      subtitle: Text(channelList[index].arRef+'\n'+channelList[index].deCode+'\n'+channelList[index].deDepot),
                     ),
                       
                                   
                     ),
                   ),
                 
                 
                 
                 
                                 
                 ); }),
             ),
           )

           

          ],
        ),
      ),
    );
  }
}

String removeTrailingZero(String string) {
  if (!string.contains('.')) {
    return string;
  }
  string = string.replaceAll(RegExp(r'0*$'), '');
  if (string.endsWith('.')) {
    string = string.substring(0, string.length - 1);
  }
  return string;
}

