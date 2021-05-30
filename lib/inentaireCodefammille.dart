import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axia_inventory/classartinv.dart';
import 'package:axia_inventory/constants.dart';
import 'package:axia_inventory/inventaire0.dart';
import 'package:axia_inventory/menu.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'dart:math' as Math;

class inventairecafa extends StatefulWidget {
  @override
  _inventairecafaState createState() => _inventairecafaState();
      final String aname;
  final String email;
  final String url;
  final  bool fa;
  final String nominv;
   final String depot;
  final String ref;
  final String comment;
  final String decode;
  final String familleCode;
  
inventairecafa({Key key, this.aname, this.email,this.url,this.fa,this.nominv,this.depot,this.ref,this.comment,this.decode,this.familleCode}) : super(key: key);
 
}

class _inventairecafaState extends State<inventairecafa> {
  bool _validate = false;
      final _pentropot = TextEditingController();
      final _pref= TextEditingController();
      final _pcomment = TextEditingController();
      final _pfamillecd = TextEditingController();
       String msg = "0";
      
  String _scanBarcode = 'Unknown';
  String selectedName;
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  TextEditingController qteController = TextEditingController();
   TextEditingController qteController1 = TextEditingController();
    TextEditingController prixController = TextEditingController();
        TextEditingController prixController1 = TextEditingController();
  String vl='e';
  List data = List();
  List artdata=List();
  bool iscolored=false;
  bool go=false;
  bool isloading=false;
  int  done;
  File imags;
  double prixa;
  
 double qtes;
  final List<Channelb> channelListb=<Channelb>[];

  bool verif=true;
  Future getAllName() async { 
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/inventaire/getfamillelist/${widget.decode}/${widget.familleCode}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
   for(var i=0;i<jsonData.length;i++){ var ref=jsonData[i]['arRef'];
    var response1 = await http.get(
        Uri.parse("https://${widget.url}/api/articleref/${widget.decode}/$ref"),
        headers: {"Accept": "application/json"});
 var jsonBody1 = response1.body;

  var jsonData1 = json.decode(jsonBody1); 
 
  

 
   if (jsonData.length==2 ){
    var blob = jsonData1[1]['arPhoto'];
    
   
    String slag=jsonData1[0]['arRef']; var b= await writeImageTemp(blob,slag);    setState(() {
    imags=b;
    });}else{ setState(() {
      imags=null;
    });
  }var cump=jsonData[i]['is_cmup'];
channelListb..add(Channelb(jsonData1[0]['arRef'],jsonData1[0]['arDesign'],jsonData1[0]['deCode'],imags, jsonData1[0]['deIntitule'],double.parse(jsonData1[0]['asQtesto']) ,null,jsonData1[0]['arCodebarre'],null,null));

 }
    setState(() { data=jsonData;
      
    });
   

    print(jsonData);
    return "success";
  }
  Future<http.Response> invStockligneadd(String ref,String cd,String qtean,String qteaj,String prixaj,) async {
  var url = 'https://${widget.url}/api/inventaire/inventairestockbc';

  Map data = {
  "arRef":ref,
  "faCodefamille":"${widget.familleCode}",
  "deCode":"${widget.decode}",
  "arDesign":cd,
  "isQte":qtean,
  "piIntitule":"${widget.nominv}",
   "isCode":"${widget.ref}",
   "isQtea":qteaj,
   "isPrixa":prixaj,
   "cbcreateur":"${widget.aname}"
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

Future<http.Response> inventairestockentete() async {
  var url = 'https://${widget.url}/api/inventaire/inventairestock';
   
  
  


     Map data1 = {
    "piIntitule":"${widget.nominv}",
 "faCodefamille":"${widget.familleCode}", 
 "deCode":"${widget.decode}",
 "isCode": "${widget.ref}",
 "isRemarques":"${widget.comment}",
 "cbCreateur":"${widget.aname}"
 
  } ; var body = json.encode(data1);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body); print("${response.statusCode}");
  print("${response.body}");
  return response;
  }
   @override
  initState() {
  

    super.initState();

    setState(() {
   _pentropot.text='${widget.depot}';
   _pref.text='${widget.ref}';
   _pcomment.text='${widget.comment}';
   _pfamillecd.text='${widget.familleCode}';
    });
  getAllName();
     }
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: Scaffold(resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Inventaire'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 25
              ),
               onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                  );
                });
              },
              )]), drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
              body: Column(children: [
               
               
                    Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
        
                      child: Center(
                        child: Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [ Text("${widget.nominv}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Container(
                                child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [ Column( mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [SizedBox(height: 42,child: Center(child: Text('Entrepôt:')),),
                  
                  SizedBox(height: 42,child: Center(child: Text('Réference:')),),
                SizedBox(height: 42,child:  Center(child: Text('Famille Code:')),),   
              widget.comment!='' ? SizedBox(height: 42,child:  Center(child: Text('Commentaire:')),):SizedBox.shrink(),
              ],) 
                                    ,
                                    Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [  Padding(
                                      padding: const EdgeInsets.only(left:8.0,bottom: 8,top: 8),
                                      child: Container(width: 200,
                                        child:   TextField(enabled: false,
                controller: _pentropot ,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
         
                  ),
              ),
                                      ),
                                    ),     Padding(
                                       padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                      child: Container(width: 200,
                                        child:   TextField(enabled: false,
                controller: _pref ,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
    
             
                  ),
              ),
                                      ),
                                    ),Padding(
                                       padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                      child: Container(width: 200,
                                        child:   TextField(enabled: false,
                controller: _pfamillecd,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
    
             
                  ),
              ),
                                      ),
                                    ),   widget.comment!='' ? Padding(
                                       padding: const EdgeInsets.only(left:8.0,bottom: 8),
                                      child: Container(width: 200,
                                        child:   TextField(enabled: false,
                controller: _pcomment,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
           
                  ),
              ),
                                      ),
                                    ):SizedBox.shrink(), 
                                    
                      ],)
                    
                                  ],
                                ),
                              ),
                            ),
                          
                            
              
                               ],
                        ),
                      ),
                    ),
                  ),







            Column(

              children: [new  Container(height: 50,
                 decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xff2193b0),
                Color(0xff6dd5ed),
              ])),
               child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text("Produit Ajoutées:",style: TextStyle(fontSize: 18,color: Colors.white)),
                  Container( height: 40,width: 120,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.amber[400]),
              child: Row(
                children: [
                  FlatButton(
                        child: Text('Valider' ,style: TextStyle(color: Colors.black,)),
                        
                     
                       
                        onPressed: ()async{  setState(() {
                          verif=true;
                        });
                           for(var s=0 ;s< channelListb.length;s++){
                         if(channelListb[s].qteAjust==null){
                          setState(() {
                            verif=false;
                          }); 
                         }
                       }
                   if(verif==true){
                         return  await confirmationDialog(
    context, 
    "Le mouvement va être enregistré et validé, voulez-vous continuer", 
    positiveText: "Valider", 
    positiveAction: () async {

                      var n=channelListb.length;
                     
                    var j= inventairestockentete();
                    print(await j);
                           for( var i=0;i<n;i++){

                          
                               var f=invStockligneadd(channelListb[i].arRef,channelListb[i].deCode,channelListb[i].qtesto.toString(),channelListb[i].qteAjust.toString(),channelListb[i].prixAjust.toString(),);

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
    MaterialPageRoute(builder: (context) => invacc(aname: "${widget.aname}",email:"${widget.email}",url:"${widget.url}" ,)),
  );},

)         ;



        },

);

}else{   
                      return warningDialog(context, "remplir all the fields");

      }
                   },

                 
                         

                       

 
                      ),
              Icon(Icons.done)  ],
              ),
              )  
               
               ],), ),

              SizedBox(height: 400,
          
              child: ListView.builder(
                  itemCount: channelListb.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var a = channelListb[index].qteAjust.toString();
                    var b = channelListb[index].qtesto.toString();
                    final item = channelListb[index].toString();
                    double c_width = MediaQuery.of(context).size.width * 0.37;
                     double c_width1 = MediaQuery.of(context).size.width * 0.371;
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Article " +
                                channelListb[index].arRef +
                                " a été supprimé")));
                        setState(() {
                          channelListb.removeAt(index);
                         
                          if (channelListb.length == 0) {
                                 setState(() {
                                   go=false;
                                 });
                          }
                        });
                      },
                      background: Container(
                          color: Colors.white,
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 40,
                          )),
                      child: GestureDetector(onTap: () async {setState(() {
  qteController1.text=channelListb[index].qteAjust.toString();
  prixController1.text=channelListb[index].prixAjust.toString();
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
                                             child: SizedBox(child:  Text(channelListb[index].arRef),),
                                          ),
                                            
                                           ]),
                                            TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Designation:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  AutoSizeText(
                       channelListb[index].arDesign,
                       
                       minFontSize: 15,
                       maxLines: 3,
                       
                                            ),),),
                                         
                                            
                                           ]),
                                             TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Barre Code:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelListb[index].barcode,),),
                                          ),
                                            
                                           ]),
                                            TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Quantité en Stock:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelListb[index].qtesto.toString(),style:TextStyle(color: Colors.black)),),
                                          ),
                                            
                                           ]),
                                             TableRow(children: [TableCell(
                                             child: SizedBox(height: 30,child:  Text('Nom Depot:',style: TextStyle(color: Colors.grey,)))
                                            
                                             
                                                ),
                                                TableCell(
                                             child: SizedBox(child:  Text(channelListb[index].deDepot,style:TextStyle(color: Colors.black)),),
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
                                      double currentValue = double.parse(qteController1.text);
                                
                                      setState(() {
                                         currentValue--;
                                               qteController1.text =
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
                                    controller: qteController1,
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
                                    onPressed: () {double currentValue = double.parse(qteController1.text);
                                
                                      setState(() {
                                         currentValue++;
                                               qteController1.text =
                                (currentValue).toString();
                                      });
                                    },
                                    child: Icon(Icons.add),
                                      ),
                                    )
                                    ],
                                ),
                                 ), Padding(
                                   padding: const EdgeInsets.only(left:60.0),
                                   child: Row( 
                                    children: [
                                    SizedBox(
                                      width: 30,
                                      child: FloatingActionButton(
                                    backgroundColor: const Color(0xffEC524B),
                                    foregroundColor: Colors.white,
                                    onPressed: () { 
                                      double currentValue = double.parse(prixController1.text);
                                
                                      setState(() {
                                         currentValue--;
                                               prixController1.text =
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
                                    controller: prixController1,
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
                                    onPressed: () {double currentValue = double.parse(prixController1.text);
                                
                                      setState(() {
                                         currentValue++;
                                               prixController1.text =
                                (currentValue).toString();
                                      });
                                    },
                                    child: Icon(Icons.add),
                                      ),
                                    )
                                    ],
                                ),
                                 ), Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[500]), 
                                 child: FlatButton(onPressed: (){ var a= new Channelb( channelListb[index].arRef, channelListb[index].arDesign, channelListb[index].deCode, channelListb[index].arImage, channelListb[index].deDepot, channelListb[index].qtesto, double.parse(qteController1.text), channelListb[index].barcode, double.parse(prixController1.text), channelListb[index].cump);
          
                                  setState(() { 
                                 channelListb.removeAt(index);
                                
                                 channelListb.insert(index, a);
                                
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
                                 child: channelListb[index].arImage !=null ? new Image.file(channelListb[index].arImage,
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
                                         .showSnackBar(SnackBar(content: Text("Article "+channelListb[index].arRef+" a été modifié"))); 

                      },
              
                        child: Container(
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
                                          color: Colors.blue,
                                          size: 13,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Container( width:300,
                                          child: AutoSizeText(
                                           channelListb[index].arRef,style: TextStyle(fontWeight:FontWeight.w600),
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
                                              child: channelListb[index].arImage != null
                                                  ? new Image.file(
                                                      channelListb[index].arImage,
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
                                                 
                                                       
                                                        new Text(channelListb[index].arDesign,
                                                            style: TextStyle(fontSize: 13)),
                                                    SizedBox(height: 3,),
                                                 channelListb[index].barcode!=null? new  Text(channelListb[index].barcode,
                                                            style: TextStyle(fontSize: 13)):SizedBox.shrink(),
                                                  SizedBox(height: 3,),
                                                  
                                                
                                                    new    Text(channelListb[index].deDepot,
                                                            style: TextStyle(fontSize: 13)),
                                                  
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
                                           Text(
                                             'Quantité en Stock:',
                                             ),SizedBox(height: 3,),
                                             Text(
                                             removeTrailingZero(b),
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18),
                                             textAlign: TextAlign.center,
                                             ),
                                             SizedBox(height: 3,),
                                              Transform.rotate(angle:Math.pi / 180 * 90,child: Icon(Icons.double_arrow)),
                                            Text(
                                             'Quantité Ajusté:',
                                             ),
                                            channelListb[index].qteAjust!=null? Text(
                                             
                                              
                                                 removeTrailingZero(channelListb[index].qteAjust.toString()) ,
                                              
                                             style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500),
                                             textAlign: TextAlign.center,
                                             ):Icon(Icons.help)  , channelListb[index].prixAjust!=null ?Text(
                                             'Prix Ajusté:',
                                             ):SizedBox.shrink(),
                                           channelListb[index].prixAjust!=null ? Text(
                                             
                                              
                                                 removeTrailingZero(channelListb[index].prixAjust.toString()) ,style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500), ):SizedBox.shrink(),
                                            
                                             
                                                                           ],
                                                                         ),
                                                                       ),
                                 ],
                               ),
                             ) ]),
                          ),
                        ),
                      ),
                    );
                  }),
            ),



              ],
            )     ],),
              
              
              
              
              
              ));
              
              
              
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