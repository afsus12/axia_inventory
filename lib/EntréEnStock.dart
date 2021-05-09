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


class Entre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Entre();
  final String aname;
  final String email;
  final String url;
  Entre({Key key, this.aname, this.email,this.url}) : super(key: key);

}

class _Entre extends State<Entre> {
  
  String msg = "0";
  String _scanBarcode = 'Unknown';
  String selectedName;
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  TextEditingController qteController = TextEditingController();
  String vl='e';
  List data = List();
  List artdata=List();
  bool iscolored=false;
  bool go=false;
  bool isloading=false;
  int  done;
  File imags;
  
  final List<Channel> channelList=<Channel>[];
  Future getAllName() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/Depot/selection/${widget.aname}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
    });
    print(jsonData);





   
    return "success";
  }
  Future<http.Response> entreStockadd(String qteE,String ref,String dcode,String barc,String prot) async {
  var url = 'https://${widget.url}/api/articlebar/entré';

  Map data = {
   "mbQteentre":qteE,
  "arRef":ref,
  "deCode":dcode,

  "arCodebarre":barc,
  "protmUser": prot
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
 

  Widget setupAlertDialoadContainer(File imags, BuildContext context) {
  return
 Stack(
      children: <Widget>[ 
        Container(
    padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
        + Constants.padding, right: Constants.padding,bottom: Constants.padding
    ),
    margin: EdgeInsets.only(top: Constants.avatarRadius),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      borderRadius: BorderRadius.circular(Constants.padding),
      boxShadow: [
        BoxShadow(color: Colors.black,offset: Offset(0,10),
        blurRadius: 10
        ),
      ]
    ),
    child: Column( crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      
      children: <Widget>[SizedBox(width: 250,
        child: AutoSizeText(
  artdata[0]['arDesign'],
  style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w600),
  minFontSize: 14,
  maxLines: 3,
  overflow: TextOverflow.ellipsis,textAlign:TextAlign.center,
),
      ),
      
        SizedBox(height: 12,),
    
       Padding(
         padding: const EdgeInsets.only(left :Constants.padding+30),
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: FittedBox(
             child: Table(
                   defaultColumnWidth: FixedColumnWidth(150), defaultVerticalAlignment:TableCellVerticalAlignment.top ,
                 children: [
              TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Reference:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),
                   TableCell(
                child: SizedBox(child:  Text(artdata[0]['arRef']),),
             ),
               
              ]),
               TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Designation:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),
                   TableCell(
                child: SizedBox(child:  Text(artdata[0]['arDesign']),),
             ),
               
              ]),
                TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Barre Code:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),
                   TableCell(
                child: SizedBox(child:  Text(artdata[0]['arCodebarre'],),),
             ),
               
              ]),
               TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Code Depot:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),
                   TableCell(
                child: SizedBox(child:  Text(artdata[0]['deCode'],style:TextStyle(color: Colors.black)),),
             ),
               
              ]),
                TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Nom Depot:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),
                   TableCell(
                child: SizedBox(child:  Text(artdata[0]['deIntitule'],style:TextStyle(color: Colors.black)),),
             ),
               
              ]),
                 
                
           
                 ],
               ),
           ),
         ),
       ),  SizedBox(width: 140,
         child: Divider(color:Color(0xff2193b0))),
            SizedBox(height: 15,child:  Text('Quantité en stock:',style: TextStyle(color: Colors.black ,fontFamily: 'FiraSans')))
           
     
    
   ,SizedBox(height: 30,child:  Text(removeTrailingZero(artdata[0]['asQtesto']),style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800,fontFamily: 'FiraSans')),),

           
   
        
    
    
        Padding(
          padding: const EdgeInsets.only(left:50.0, ),
          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: FloatingActionButton(
                                  backgroundColor: const Color(0xffEC524B),
                                  foregroundColor: Colors.white,
                                  onPressed: () {
                                    double currentValue = double.parse(qteController.text);
                                                     
                                    setState(() {
                                       currentValue--;
                      qteController.text =
                          (currentValue).toString();
                                    });
                                  },
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                child: TextFormField(
                                  controller: qteController,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.singleLineFormatter
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
                                  onPressed: () {double currentValue = double.parse(qteController.text);
                                                     
                                    setState(() {
                                       currentValue++;
                      qteController.text =
                          (currentValue).toString();
                                    });
                                  },
                                  child: Icon(Icons.add),
                                ),
                              )
                            ],
                          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[500]),
            child: FlatButton(
                onPressed: (){
                  setState(() { var qte=double.parse(qteController.text) ;var qtes=double.parse(artdata[0]['asQtesto']) ;
                         channelList..add(Channel(artdata[0]['arRef'],artdata[0]['arDesign'],artdata[0]['deCode'],imags, artdata[0]['deIntitule'],qtes ,qte,artdata[0]['arCodebarre']));
                         go=true; isloading=false; }); Navigator.pop(context);},
                
                child: Text("Ajouter",style: TextStyle(fontSize: 18,color: Colors.white),)),
          ),
        ),
      ],
    ),
    
    ),Padding(
    padding: const EdgeInsets.only(top:double.minPositive+70),
    child:   Container(height: double.minPositive+48,    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(Constants.padding),topRight: Radius.circular(Constants.padding)
     ,bottomLeft: Radius.elliptical(300,80)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xff2193b0),
                  Color(0xff6dd5ed),
                ])),),
    ),
    
    Positioned(
    left: Constants.padding,
      right: Constants.padding,
      
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: Constants.avatarRadius,
        child: ClipRRect( borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
      child:imags!=null ? new Image.file(imags,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    ):Image.asset('images/net.png',
      width: 100,
      height: 100,
      fit: BoxFit.cover,)),
    ),)
       
      ],
    );}
    


  Future getArticlebarre(value1, value2) async {

    String dep = value1;
    String bar = value2;
    var response = await http.get(
        Uri.parse("https://${widget.url}/api/articlebar/$dep/$bar"),
        headers: {"Accept": "application/json"});

  var jsonBody = response.body;

     if(response.statusCode==404){ 
       return errorDialog(context, "Scanner a nouveau ou essayer de changer le depot" ,title:" Article n'existe pas"
       ,neutralAction: (){setState(() {
         isloading=false;
       }); });
    

     }else{
       var jsonData = json.decode(jsonBody);
    setState(() {
      artdata=jsonData;
    });
                      
    print(jsonData); 
    
    if (jsonData.length==2 ){
    var blob = jsonData[1]['arPhoto'];
    
   
    String slag=artdata[0]['arRef']; var b= await writeImageTemp(blob,slag);    setState(() {
    imags=b;
    });}else{ setState(() {
      imags=null;
    });
  }
  var contain = channelList.where((element) => element.arRef == artdata[0]['arRef'] && element.deCode == artdata[0]['deCode']);
     switch (contain.isNotEmpty) {
    case true:        
            
        // return object of type Dialog
        return warningDialog(context, "Cette Article a déjà été ajouté" ,neutralAction:() {setState(() {
          isloading=false;
        });}); 
  
      break;
    case false:  
    
    return showDialog(
    context: context,
    builder: (BuildContext context) {
      return  Center(
        child: SingleChildScrollView( scrollDirection: Axis.vertical,
          child: Dialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          
          child: setupAlertDialoadContainer(imags,context),
           
          ),
        ),
      );
    });
    
       
      break;
  
  }
   }
   return response;
  }

  @override
  initState() {
    super.initState();
    getAllName();
    qteController.text = "0";
  }

   Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);



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
                    MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                  );
                });
              },
            )
          ],
        ),
        drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
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
                    side: iscolored==false?BorderSide(width: 0.6, style: BorderStyle.solid):BorderSide(width: 0.6, style: BorderStyle.solid,color: Colors.red),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: iscolored==false?Text('Sélectionner un entrepôt'):Text('Sélectionner un entrepôt',style: TextStyle(color: Colors.red),),
                      icon: iscolored==false?Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_down,color: Colors.red,),
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
                          iscolored=false;
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
                    onPressed: () async {if(selectedName==null){
                     
                    setState(() {iscolored=true;
                      
                    });}else{ setState(() {isloading=true;
                      
                        
                            
                              
                            
                      });await scanBarcodeNormal()  ;
                         if (_scanBarcode.isNotEmpty){
                         var mm= await getArticlebarre(selectedName,_scanBarcode);
                 
                       }         }}
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
               child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text("Produit Ajoutées:",style: TextStyle(fontSize: 18,color: Colors.white)),
              Container( height: 40,width: 120,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.amber[400]),
                child: Row(
                  children: [
                    FlatButton(
                          child: Text('Valider' ,style: TextStyle(color: Colors.black,)),
                          
                       
                         
                          onPressed: () async{
                         return  await confirmationDialog(
    context, 
    "Le mouvement va être enregistré et validé, voulez-vous continuer", 
    positiveText: "Valider", 
    positiveAction: () async {

                      var n=channelList.length;
                           for( var i=0;i<n;i++){

                          
                         var f= entreStockadd(channelList[i].qte.toString(),channelList[i].arRef ,channelList[i].deCode,channelList[i].barcode, '${widget.aname}');

                              print(await f);
                            setState(() {
                              done=i;
                            });}



                    return  successDialog( 
    context,  
    "Opération terminé avec succès",  

    neutralText: 'Okay',
    neutralAction: (){Navigator.pop(context);
       Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Entre(aname: "${widget.aname}",email:"${widget.email}",url:"${widget.url}" ,)),
  );},

)         ;



    }

);


                   },

                   
                           

                         

 
                        ),
                Icon(Icons.done)  ],
                ),
              )  ],
               )),
         ),
           Expanded(
             child: SizedBox(height: 200.0,
               child: ListView.builder(itemCount: channelList.length, scrollDirection: Axis.vertical,
                 itemBuilder: (context,index){ var a=channelList[index].qte.toString(); var b=channelList[index].qtesto.toString();
                  final item =channelList[index].toString() ;
                 return  Dismissible(key: UniqueKey(),
                   
                  onDismissed: (direction) async {
              ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Article "+channelList[index].arRef+" a été supprimé")));
                setState(() {
                  channelList.removeAt(index);
                 if(channelList.length==0){
                    go=false;
                  }
                });
              }, background: Container(color: Colors.white,child: Icon(Icons.delete,color: Colors.grey,size: 40,)),

                   child: Container(
                     child: Card(
                       child: ListTile(onTap: () async{setState(() {
                         qteController.text=channelList[index].qte.toString();
                       });
                         await showDialog(context: context, builder: (BuildContext context){
                         return  Center(
                           child: SingleChildScrollView(
                             child: Dialog(
                                backgroundColor: Colors.transparent,
                             insetPadding: EdgeInsets.all(2),
                             child: Stack(
                               overflow: Overflow.visible,
                               alignment: Alignment.center,
                               children: <Widget>[
                                 Container(
                                  width: 380,
                  
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15),
                                     color: Colors.white
                                   ),
                                   padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                                 child: Column( mainAxisAlignment: MainAxisAlignment.center,
                                   children: [Text("Modifer Quantité",style:TextStyle(fontSize: 24,fontWeight: FontWeight.w600)),  
                                   Padding(
                                     padding: const EdgeInsets.only(left:30.0,top:20),
                                     child: Table(
                                                defaultColumnWidth: FixedColumnWidth(150), defaultVerticalAlignment:TableCellVerticalAlignment.top ,
                                              children: [ 
                                           TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Reference:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelList[index].arRef),),
                                          ),
                                            
                                           ]),
                                            TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Designation:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  AutoSizeText(
  channelList[index].arDesign,
  
  minFontSize: 15,
  maxLines: 3,
  
),),),
                                         
                                            
                                           ]),
                                             TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Barre Code:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelList[index].barcode,),),
                                          ),
                                            
                                           ]),
                                            TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Quantité en Stock:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelList[index].qtesto.toString(),style:TextStyle(color: Colors.black)),),
                                          ),
                                            
                                           ]),
                                             TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Nom Depot:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelList[index].deDepot,style:TextStyle(color: Colors.black)),),
                                          ),
                                            
                                           ]),
                                              
                                             
                                        
                                              ],
                                            ),
                                   ),
                                 Padding(
                                   padding: const EdgeInsets.only(left:60.0),
                                   child: Row( 
                                    children: [
                                    SizedBox(
                                      width: 30,
                                      child: FloatingActionButton(
                                    backgroundColor: const Color(0xffEC524B),
                                    foregroundColor: Colors.white,
                                    onPressed: () { 
                                      double currentValue = double.parse(qteController.text);
                                
                                      setState(() {
                                         currentValue--;
                                               qteController.text =
                                (currentValue).toString();
                                      });
                                    },
                                    child: Icon(Icons.remove),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 40,
                                      child: TextFormField(
                                    controller: qteController,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.singleLineFormatter
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
                                      labelText: 'Qte a Ajouter',
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
                                    onPressed: () {double currentValue = double.parse(qteController.text);
                                
                                      setState(() {
                                         currentValue++;
                                               qteController.text =
                                (currentValue).toString();
                                      });
                                    },
                                    child: Icon(Icons.add),
                                      ),
                                    )
                                    ],
                                ),
                                 ), Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[500]), 
                                 child: FlatButton(onPressed: (){ var a= new Channel(channelList[index].arRef, channelList[index].arDesign, channelList[index].deCode, channelList[index].arImage, channelList[index].deDepot, channelList[index].qtesto, double.parse(qteController.text), channelList[index].barcode);
                                  setState(() {
                                 channelList.removeAt(index);
                                 channelList.insert(index, a);
                                 qteController.text='0'; 

                                 });
                                
                                 Navigator.pop(context);
                                 }
                                 ,
                                 child: Text("Enregistrer",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                 ),],),
                                   ),
                                 
                                 
                               
                                
                                 Positioned(
                                   top: -70,
                                   child: CircleAvatar(
                                   backgroundColor: Colors.transparent,
                                   radius: Constants.avatarRadius,
                                   child: ClipRRect( borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                                 child: channelList[index].arImage !=null ? new Image.file(channelList[index].arImage,
                                 width: 100,
                                 height: 100,
                                 fit: BoxFit.cover,
                               ):Image.asset('images/net.png',width: 100,
                                 height: 100,
                                 fit: BoxFit.cover,)),
                               ), )
                               ],
                             )
                                                  ),
                           ),
                         ); },); 
                        
                       ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Article "+channelList[index].arRef+" a été modifié"))); 
                         
                                                       },title:AutoSizeText(
  channelList[index].arDesign,
  
  minFontSize: 14,
  maxLines: 3,
  
),leading: Wrap(children: [Icon(Icons.fiber_manual_record,color: Colors.green,size: 13,),
  ClipOval(
                  child:channelList[index].arImage !=null ? new Image.file(channelList[index].arImage,
                       width: 60,
                       height: 60,
                       fit: BoxFit.cover,
                     ):Image.asset('images/net.png',width: 60,
                                 height: 60,
                                 fit: BoxFit.cover,),
                     ) ,],), 
                               trailing: 
                  
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

Future<File> writeImageTemp(String base64Image, String imageName) async {
   Uint8List bytes = base64.decode(base64Image);

final appDir = await syspaths.getTemporaryDirectory();
  imageName=imageName+'.jpg';
File file = File('${appDir.path}/'+imageName);

await file.writeAsBytes(bytes);


  return file;
}
