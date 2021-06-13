import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axia_inventory/consultationclass.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:math' as Math;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'consultation1.dart';
import 'package:intl/intl.dart';  //for date format
import 'package:intl/date_symbol_data_local.dart';  

class Consultation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Consultation();
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
  Consultation({Key key, this.aname, this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
  
}

class _Consultation extends State<Consultation> {
  String _scanBarcode = 'Unknown';
  String selectedName;
  List data = List();
   List artdata=List();
     File imags;
    bool isloading=false;
    bool isVisble=false;
      bool iscolored=false;
      String Qsa;
      final List<Channelcons> channelList=<Channelcons>[];
 Future getArticlebarre(value1, value2) async {

    String dep = value1;
    String bar = value2;
    var response = await http.get(
        Uri.parse("https://${widget.url}/api/consultation/$dep/$bar/${widget.aname}"),
        headers: {"Accept": "application/json"});
Intl.defaultLocale = "zh_HK";
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
    
    if (jsonData[jsonData.length-1].length==1 ){
    var blob = jsonData[jsonData.length-1]['arPhoto'];
     String slag=artdata[0]['arRef']; var b= await writeImageTemp(blob,slag);    setState(() {
    imags=b;
    });
    for(var i=0;i < jsonData.length;i++){
      switch(jsonData[i]['mbType'] ) {
      
      case 'entr\u00e9e':
      setState(() {
         channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
       jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], jsonData[i]['mbQteentre'], null, null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
      });
     
         break;
        case 'sortie': setState(() {
            channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'],null, jsonData[i]['mbQtesortie'],null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
        });
      
         break;
          case 'transfert':

          setState(() {
             channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], null, null, jsonData[i]['mbQtetrans'],jsonData[i]['mbDeintituorig'] ,jsonData[i]['mbDeintitudes'] ,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
          });
       
         break; 
        case 'inventaire entree':
      setState(() {
         channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
       jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], jsonData[i]['mbQteentre'], null, null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
      }); 
       break; 
        case 'inventaire sortie': setState(() {
            channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'],null, jsonData[i]['mbQtesortie'],null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
        });
      
         break;

        } 

    }
   setState(() {
  isloading=false;

   isVisble=true;
});
   }else{ setState(() {
      imags=null;
    });
     for(var i=0;i < jsonData.length;i++){
      switch(jsonData[i]['mbType'] ) {
      
      case 'entr\u00e9e': 
      setState(() {
         channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
       jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], jsonData[i]['mbQteentre'], null, null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
      });
     
         break;
        case 'sortie': setState(() {
            channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'],null, jsonData[i]['mbQtesortie'],null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
        });
      
         break;
          case 'transfert':

          setState(() {
             channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], null, null, jsonData[i]['mbQtetrans'],jsonData[i]['mbDeintituorig'] ,jsonData[i]['mbDeintitudes'] ,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
          });
       
         break; 
          case 'inventaire entree': 
      setState(() {
         channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
       jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'], jsonData[i]['mbQteentre'], null, null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
      });
     
         break;
        case 'inventaire sortie': setState(() {
            channelList..add(Channelcons(jsonData[i]['arDesign'],jsonData[i]['arRef'] ,jsonData[i]['arCodebarre'] ,
         jsonData[i]['mbCreatedat'] , jsonData[i]['mbQteancien'], jsonData[i]['asQtesto'],null, jsonData[i]['mbQtesortie'],null, null, null,jsonData[i]['mbType'] ,jsonData[i]['protmUser'] ,jsonData[i]['deIntitule'] ,imags));
        });
      
         break;
        } 

    }
setState(() {
  isloading=false;
  Qsa=channelList[channelList.length-1].asQtesto.toString();
  isVisble=true;
});
  }
  
  
  
  
   }
   return response;
  }
   Widget setupAlertDialoadContainer(index,c_width,c_width1) {DateTime dateTime = DateTime.parse(channelList[index].mbCreatedat);
   String hhmm= DateFormat.Hm().format(dateTime.toLocal());

   var formater= DateFormat("EEEE\ndd/MM/yyyy", 'fr');
  String dd=formater.format(dateTime.toLocal());

switch (channelList[index].mbType){
                               case 'entr\u00e9e':
                               return  Container(
                              child: Card(
                                child: Stack(children: [
                                 
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                   
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Row(children: <Widget>[
                                            Icon(
                                              Icons.fiber_manual_record,
                                              color: Colors.green,
                                              size: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container( width:300,
                                              child: AutoSizeText(
                                               channelList[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
                                                minFontSize: 15,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(   
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:10.0),
                                                child: ClipOval(
                                                  child: channelList[index].arPhoto != null
                                                      ? new Image.file(
                                                          channelList[index].arPhoto,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'images/net.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            SizedBox(width: 12,),
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(width: c_width,
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                     
                                                           
                                                            new Text(channelList[index].arDesign,
                                                                style: TextStyle(fontSize: 13)),
                                                        SizedBox(height: 3,),
                                                     channelList[index].arCodebarre!=null? new  Text(channelList[index].arCodebarre,
                                                                style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                      SizedBox(height: 3,),
                                                      
                                                    
                                                        new    Text(channelList[index].deIntitule,
                                                                style: TextStyle(fontSize: 13)),
                                                        new Text('Valider par:  '+ channelList[index].protmUser, style: TextStyle(fontSize: 13))
                                                      , Padding(
                                                        padding: const EdgeInsets.only(top:10.0),
                                                        child: Column(
                                                          children: [ new Text('Ancienne Quantité:' ),
                                                            new Text( removeTrailingZero(double.parse(channelList[index].mbQteancien).toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), ),
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                                                 ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IntrinsicHeight(
                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                                     children: [VerticalDivider(),
                                       Container( width: c_width1, padding: const EdgeInsets.only(top:10.0,right:5,left:5,bottom:3),
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children:<Widget> [
                                                                                 Text(dd+'\n'+hhmm,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),),
                                                 Padding(
                                                   padding: const EdgeInsets.all(3.0),
                                                   child: Text(
                                                   'Quantité en Stock:',
                                                   ),
                                                 ),
                                                   Text(
                                                  removeTrailingZero(double.parse(channelList[index].asQtesto).toString()),
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 18),
                                                 textAlign: TextAlign.center,
                                                 ),   Text(channelList[index].deIntitule,style:TextStyle(color: Colors.green),),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [        Text(
                                                   
                                                    
                                                       '+'+ removeTrailingZero(double.parse(channelList[index].mbQteentre).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_up_rounded,color:Colors.green),
                                                     ],
                                                   ),
                                                 ),
                                               
                                                 SizedBox(height: 8,),
                                              
                                         
                                               
                                                
                                                 
                                                                               ],
                                                                             ),
                                                                           ),
                                     ],
                                   ),
                                 ) ]),
                              ),
                            );

     
         break;
        case 'sortie': 
                    return  Container(
                              child: Card(
                                child: Stack(children: [
                                 
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                   
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Row(children: <Widget>[
                                            Icon(
                                              Icons.fiber_manual_record,
                                              color: Colors.red,
                                              size: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container( width:300,
                                              child: AutoSizeText(
                                               channelList[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
                                                minFontSize: 15,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(   
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:10.0),
                                                child: ClipOval(
                                                  child: channelList[index].arPhoto != null
                                                      ? new Image.file(
                                                          channelList[index].arPhoto,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'images/net.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            SizedBox(width: 12,),
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(width: c_width,
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                     
                                                           
                                                            new Text(channelList[index].arDesign,
                                                                style: TextStyle(fontSize: 13)),
                                                        SizedBox(height: 3,),
                                                     channelList[index].arCodebarre!=null? new  Text(channelList[index].arCodebarre,
                                                                style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                      SizedBox(height: 3,),
                                                      
                                                    
                                                        new    Text(channelList[index].deIntitule,
                                                                style: TextStyle(fontSize: 13)),
                                                        new Text('Valider par:  '+ channelList[index].protmUser, style: TextStyle(fontSize: 13))
                                                      , Padding(
                                                        padding: const EdgeInsets.only(top:10.0),
                                                        child: Column(
                                                          children: [ new Text('Ancienne Quantité:' ),
                                                            new Text( removeTrailingZero(double.parse(channelList[index].mbQteancien).toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), ),
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                                                 ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IntrinsicHeight(
                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                                     children: [VerticalDivider(),
                                       Container( width: c_width1, padding: const EdgeInsets.only(top:10.0,right:5,left:5,bottom:3),
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children:<Widget> [
                                                                                 Text(dd+'\n'+hhmm,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),),
                                                 Padding(
                                                   padding: const EdgeInsets.all(3.0),
                                                   child: Text(
                                                   'Quantité en Stock:',
                                                   ),
                                                 ),
                                                   Text(
                                             removeTrailingZero(double.parse(channelList[index].asQtesto).toString()) ,
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 18),
                                                 textAlign: TextAlign.center,
                                                 ),
                                                 Text(channelList[index].deIntitule,style:TextStyle(color: Colors.red),),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [        Text(
                                                   
                                                    
                                                     '-' +removeTrailingZero(double.parse(channelList[index].mbQtesortie).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_down_rounded,color:Colors.red),

                                                     ],
                                                   ),
                                                 ),
                                               
                                                 SizedBox(height: 8,),
                                              
                                         
                                               
                                                
                                                 
                                                                               ],
                                                                             ),
                                                                           ),
                                     ],
                                   ),
                                 ) ]),
                              ),
                            );
         break;
          case 'transfert':
              return  Container(
                              child: Card(
                                child: Stack(children: [
                                 
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                   
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Row(children: <Widget>[
                                            Icon(
                                              Icons.fiber_manual_record,
                                              color: Colors.orange,
                                              size: 13,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container( width:300,
                                              child: AutoSizeText(
                                               channelList[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
                                                minFontSize: 15,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(   
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:10.0,top:20),
                                                child: ClipOval(
                                                  child: channelList[index].arPhoto != null
                                                      ? new Image.file(
                                                          channelList[index].arPhoto,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'images/net.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            SizedBox(width: 12,),
                                            IntrinsicHeight(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top:12.0),
                                                child: Row(
                                                  children: [
                                                    Container(width: c_width,
                                                      child: new Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                       
                                                             
                                                              new Text(channelList[index].arDesign,
                                                                  style: TextStyle(fontSize: 13)),
                                                          SizedBox(height: 3,),
                                                       channelList[index].arCodebarre!=null? new  Text(channelList[index].arCodebarre,
                                                                  style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                        SizedBox(height: 3,),
                                                        
                                                      
                                                          new    Text(channelList[index].deIntitule,
                                                                  style: TextStyle(fontSize: 13)),
                                                          new Text('Valider par:  '+ channelList[index].protmUser, style: TextStyle(fontSize: 13))
                                                        , Padding(
                                                          padding: const EdgeInsets.only(top:10.0),
                                                          child: Column(
                                                            children: [ new Text('Ancienne Quantité:' ),
                                                              new Text( removeTrailingZero(double.parse(channelList[index].mbQteancien).toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), ),
                                                            ],
                                                          ),
                                                        ),
                                                      
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                                                 ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IntrinsicHeight(
                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                                     children: [VerticalDivider(),
                                       Container( width: c_width1, padding: const EdgeInsets.only(top:10.0,right:5,left:5,bottom:3),
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children:<Widget> [
                                                                                 Text(dd+'\n'+hhmm,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),),
                                                 Padding(
                                                   padding: const EdgeInsets.all(3.0),
                                                   child: Text(
                                                   'Quantité en Stock:',
                                                   ),
                                                 ),
                                                   Text(
                                                 removeTrailingZero(double.parse(channelList[index].asQtesto).toString()),
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 18),
                                                 textAlign: TextAlign.center,
                                                 ),
                                                 Text(channelList[index].mbDeintituorig,style:TextStyle(color: Colors.red)),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [      
                                                       
                                                         Text(
                                                   
                                                    
                                                    '-' +removeTrailingZero(double.parse(channelList[index].mbQtetrans).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_down_rounded,color:Colors.red),

                                                     ],
                                                   ),
                                                 ),Icon(Icons.compare_arrows_rounded)
                                               ,Text(channelList[index].mbDeintitudes,style:TextStyle(color:Colors.green)),
                                              
                                                Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [      
                                                       
                                                         Text(
                                                   
                                                    
                                                       '+' +removeTrailingZero(double.parse(channelList[index].mbQtetrans).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_up_rounded,color:Colors.green),

                                                     ],
                                                   ),),
                                                 SizedBox(height: 3,),
                                              
                                         
                                               
                                                
                                                 
                                                                               ],
                                                                             ),
                                                                           ),
                                     ],
                                   ),
                                 ) ]),
                              ),
                            );
      
       
         break; 
          case 'inventaire entree':
                               return  Container(
                              child: Card(
                                child: Stack(children: [
                                 
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                   
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Row(children: <Widget>[
                                             Icon(
                                              Icons.info,
                                              color: Colors.blue,
                                              size: 15,
                                            ),
                                         
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container( width:300,
                                              child: AutoSizeText(
                                               channelList[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
                                                minFontSize: 15,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(   
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:10.0),
                                                child: ClipOval(
                                                  child: channelList[index].arPhoto != null
                                                      ? new Image.file(
                                                          channelList[index].arPhoto,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'images/net.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            SizedBox(width: 12,),
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(width: c_width,
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                     
                                                           
                                                            new Text(channelList[index].arDesign,
                                                                style: TextStyle(fontSize: 13)),
                                                        SizedBox(height: 3,),
                                                     channelList[index].arCodebarre!=null? new  Text(channelList[index].arCodebarre,
                                                                style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                      SizedBox(height: 3,),
                                                      
                                                    
                                                        new    Text(channelList[index].deIntitule,
                                                                style: TextStyle(fontSize: 13)),
                                                        new Text('Valider par:  '+ channelList[index].protmUser, style: TextStyle(fontSize: 13))
                                                      , Padding(
                                                        padding: const EdgeInsets.only(top:10.0),
                                                        child: Column(
                                                          children: [ new Text('Ancienne Quantité:' ),
                                                            new Text( removeTrailingZero(double.parse(channelList[index].mbQteancien).toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), ),
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                                                 ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IntrinsicHeight(
                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                                     children: [VerticalDivider(),
                                       Container( width: c_width1, padding: const EdgeInsets.only(top:10.0,right:5,left:5,bottom:3),
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children:<Widget> [
                                                                                 Text(dd+'\n'+hhmm,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),),
                                                 Padding(
                                                   padding: const EdgeInsets.all(3.0),
                                                   child: Text(
                                                   'Quantité en Stock:',
                                                   ),
                                                 ),
                                                   Text(
                                                  removeTrailingZero(double.parse(channelList[index].asQtesto).toString()),
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 18),
                                                 textAlign: TextAlign.center,
                                                 ),   Text(channelList[index].deIntitule,style:TextStyle(color: Colors.green),),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [        Text(
                                                   
                                                    
                                                       '+'+ removeTrailingZero(double.parse(channelList[index].mbQteentre).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_up_rounded,color:Colors.green),
                                                     ],
                                                   ),
                                                 ),
                                               
                                                 SizedBox(height: 8,),
                                              
                                         
                                               
                                                
                                                 
                                                                               ],
                                                                             ),
                                                                           ),
                                     ],
                                   ),
                                 ) ]),
                              ),
                            );

     
         break;
         case 'inventaire sortie': 
                    return  Container(
                              child: Card(
                                child: Stack(children: [
                                 
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                   
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: Row(children: <Widget>[     Icon(
                                              Icons.info,
                                              color: Colors.blue,
                                              size: 15,
                                            ),
                                        
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Container( width:300,
                                              child: AutoSizeText(
                                               channelList[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
                                                minFontSize: 15,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Row(   
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:10.0),
                                                child: ClipOval(
                                                  child: channelList[index].arPhoto != null
                                                      ? new Image.file(
                                                          channelList[index].arPhoto,
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'images/net.png',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            SizedBox(width: 12,),
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Container(width: c_width,
                                                    child: new Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                     
                                                           
                                                            new Text(channelList[index].arDesign,
                                                                style: TextStyle(fontSize: 13)),
                                                        SizedBox(height: 3,),
                                                     channelList[index].arCodebarre!=null? new  Text(channelList[index].arCodebarre,
                                                                style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                      SizedBox(height: 3,),
                                                      
                                                    
                                                        new    Text(channelList[index].deIntitule,
                                                                style: TextStyle(fontSize: 13)),
                                                        new Text('Valider par:  '+ channelList[index].protmUser, style: TextStyle(fontSize: 13))
                                                      , Padding(
                                                        padding: const EdgeInsets.only(top:10.0),
                                                        child: Column(
                                                          children: [ new Text('Ancienne Quantité:' ),
                                                            new Text( removeTrailingZero(double.parse(channelList[index].mbQteancien).toString()),textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold), ),
                                                          ],
                                                        ),
                                                      ),
                                                    
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                                                 ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 IntrinsicHeight(
                                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                                     children: [VerticalDivider(),
                                       Container( width: c_width1, padding: const EdgeInsets.only(top:10.0,right:5,left:5,bottom:3),
                                                                             child: Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children:<Widget> [
                                                                                 Text(dd+'\n'+hhmm,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),),
                                                 Padding(
                                                   padding: const EdgeInsets.all(3.0),
                                                   child: Text(
                                                   'Quantité en Stock:',
                                                   ),
                                                 ),
                                                   Text(
                                             removeTrailingZero(double.parse(channelList[index].asQtesto).toString()) ,
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 18),
                                                 textAlign: TextAlign.center,
                                                 ),
                                                 Text(channelList[index].deIntitule,style:TextStyle(color: Colors.red),),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left:12.0),
                                                   
                                                   child: Row( mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [        Text(
                                                   
                                                    
                                                     '-' +removeTrailingZero(double.parse(channelList[index].mbQtesortie).toString()) ,
                                                    
                                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 15),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                       Icon(Icons.trending_down_rounded,color:Colors.red),

                                                     ],
                                                   ),
                                                 ),
                                               
                                                 SizedBox(height: 8,),
                                              
                                         
                                               
                                                
                                                 
                                                                               ],
                                                                             ),
                                                                           ),
                                     ],
                                   ),
                                 ) ]),
                              ),
                            );
         break;


                           }
                         
   }
  Future getAllName() async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/Depot/selection/${widget.aname}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
    });
    print(jsonData);
    return "success";
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
       initializeDateFormatting("fr");
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Consultation'),
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
              
                          iscolored=false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15),
            child: Center(
              child: isVisble==false ?Image.asset(
                'images/scan.png',
                cacheWidth: 300,
                cacheHeight: 100,
              ):SizedBox(child: Column(
                children: [
                  Text('Quantité Actuelle:' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(removeTrailingZero(double.parse(channelList[0].asQtesto).toString()),style: TextStyle(fontSize:22,fontWeight:FontWeight.bold,))
                ],
              )),
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
                      
                        channelList.clear();
                        isVisble=false;
                            
                              
                            
                      });await scanBarcodeNormal()  ;
                         if (_scanBarcode.isNotEmpty){
                         var mm= await getArticlebarre(selectedName,_scanBarcode);
                 
                       }         }}
                  ):CircularProgressIndicator(),
                ),
              ),
            ),




                          Visibility(visible: isVisble,
                            child: new   Container(height: 50,
                                           decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                          Color(0xff2193b0),
                                          Color(0xff6dd5ed),
                                        ])),
                                         child: Center(child: Text("Consultation d'Historiques",style: TextStyle(fontSize: 18,color: Colors.white))), ),
                          ),

                Expanded(
                  child: SizedBox(
                  
                    child: ListView.builder(
                        itemCount: channelList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                            
                          double c_width = MediaQuery.of(context).size.width * 0.37;
                           double c_width1 = MediaQuery.of(context).size.width * 0.371;

                   return    setupAlertDialoadContainer(index,c_width,c_width1);    
                       
                       ; }),
                  ),
                ),
        ],
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
