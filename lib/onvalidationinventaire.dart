import 'package:auto_size_text/auto_size_text.dart';
import 'package:axia_inventory/classart.dart';
import 'package:axia_inventory/classartinv.dart';
import 'package:axia_inventory/constants.dart';
import 'package:axia_inventory/inventaire0.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'menu.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'dart:math' as Math;

class onvalidationInv extends StatefulWidget {
  @override
  _onvalidationInvState createState() => _onvalidationInvState();
   final String aname;
  final String email;
  final String url;
  final String pintitu;
    final String comment;
    final String decode;
    final String collab;
    final String iscode;
  onvalidationInv({Key key, this.aname, this.email,this.url,this.pintitu,this.comment,this.decode,this.collab,this.iscode}) : super(key: key);
}



class _onvalidationInvState extends State<onvalidationInv> {
  bool _validate = false;
      final _pentropot = TextEditingController();
      final _pref= TextEditingController();
      final _pcomment = TextEditingController();
List data= new List();

 File imags;
 double qtes;
         TextEditingController qteController1 = TextEditingController();
        TextEditingController prixController1 = TextEditingController();

String selectedName;
  
  final List<Channelb> channelListb=<Channelb>[];
   Future getAllName() async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/inventaire/getstockligne/${widget.pintitu}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
   for(var i=0;i<jsonData.length;i++){ var dep=jsonData[i]['de_code']; var ref=jsonData[i]['ar_ref'];
    var response1 = await http.get(
        Uri.parse("https://${widget.url}/api/articleref/$dep/$ref"),
        headers: {"Accept": "application/json"});
 var jsonBody1 = response1.body;

  var jsonData1 = json.decode(jsonBody1); var a=jsonData[i]['is_qtea'];

  var qtes1=jsonData[i]['is_qte']; 

 
   if (jsonData1.length==2 ){
    var blob = jsonData1[1]['arPhoto'];
    
   
    String slag=jsonData1[0]['arRef']; var b= await writeImageTemp(blob,slag);    setState(() {
    imags=b;
    });}else{ setState(() {
      imags=null;
    });
  }var cump=jsonData[i]['is_cmup'];
channelListb..add(Channelb(jsonData1[0]['arRef'],jsonData1[0]['arDesign'],jsonData1[0]['deCode'],imags, jsonData1[0]['deIntitule'],qtes1 ,a,jsonData1[0]['arCodebarre'],jsonData[i]['is_prixa'],cump));

 }
    setState(() { data=jsonData;
      
    });
   

    print(jsonData);
    return "success";
  }

   Future delete(ref) async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/inventaire/deleterow/${widget.pintitu}/$ref'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
   print(response.statusCode);

    return "success";
  }


Future<http.Response> inventairestockmodifier(valueqte,valueprix,ref) async {
  var url = 'https://${widget.url}/api/inventaire/inventairestockfa';
   
  
  


     Map data1 = {
         "arRef":ref,
    "piIntitule":"${widget.pintitu}",
 "isQtea":valueqte.toString(),
  "isPrixa":valueprix.toString(),
 "isCode" : "${widget.iscode}",
 "cbCreateur":"${widget.aname}"
 
  } ; var body = json.encode(data1);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body); print("${response.statusCode}");
  print("${response.body}");
  return response;
  }

  Future<http.Response> inventairestockvalidate(souche) async {
  var url = 'https://${widget.url}/api/inventaire/validation/${widget.pintitu}/${widget.aname}/$souche';
   
  

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}); print("${response.statusCode}");
  print("${response.body}");
  return response;
  }


  
    
     @override
  initState() {
    super.initState();
    getAllName();
   setState(() {
   _pentropot.text='${widget.decode}';
   _pref.text='${widget.collab}';
   _pcomment.text='${widget.comment}';
    });
  }

    
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Validation inventaire'),
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
      drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),body:Column(children: [ Expanded(
            child: Column(
              children: [Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
        
                        child: Center(
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ Text("${widget.pintitu}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              Padding(
                                padding: const EdgeInsets.only(top:10.0),
                                child: Container(
                                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [ Column( mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [SizedBox(height: 42,child: Center(child: Text('Entrepôt:')),),
                    
                    SizedBox(height: 42,child: Center(child: Text('Collab')),),
                 SizedBox(height: 42,child:  Center(child: Text('Souche:')),),   
                 SizedBox(height: 42,child:  Center(child: Text('Commentaire:')),),],) 
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
                                      ),  Padding(
               padding: const EdgeInsets.only(left:8.0,bottom: 8),
                child: Container(
                width: 200,
                height: 38,
                decoration: ShapeDecoration(
                 shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: _validate==false? BorderSide(
                width: 0.6, style: BorderStyle.solid):BorderSide(
                width: 2, style: BorderStyle.solid,color: Colors.red),
                 ),
                ),
                child: DropdownButtonHideUnderline(
                 child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  hint: Text(
                'selection de souche',
                style: _validate == false?TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12):TextStyle(
                  color: Colors.red, fontSize: 12),
                  ),
                  icon: _validate==false ? Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_down,color: Colors.red),
                  iconSize: 20,
                   value: selectedName,
                      
                   
                  items: <String>["PIECE","STOCKMAINT"].map((String value) {
                return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),
  onChanged: (String newValue) {setState(() {
    selectedName=newValue;
  });},
),
                 ),
                ),
                 ),
              ),         Padding(
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
                                      ),
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
              new  Container(height: 50,
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
                        
                     
                       
                        onPressed: ()async{ 
                
                         return  await confirmationDialog(
    context, 
    "Le mouvement va être enregistré et validé, voulez-vous continuer", 
    positiveText: "Valider", 
    positiveAction: () async {

                      var n=channelListb.length;
                     
                      

                          
                          await inventairestockvalidate(selectedName);

                       
                        



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

},

                 
                         

                       

 
                      ),
              Icon(Icons.done)  ],
              ),
              )  
               
               ],), ),

                Expanded(
                  child: SizedBox(
                  
                    child: ListView.builder(
                        itemCount: channelListb.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var a = channelListb[index].qteAjust.toString();
                          var b = channelListb[index].qtesto.toString();
                          final item = channelListb[index].toString();
                          double c_width = MediaQuery.of(context).size.width * 0.37;
                           double c_width1 = MediaQuery.of(context).size.width * 0.371;
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                            await  delete(channelListb[index].arRef);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Article " +
                                      channelListb[index].arRef +
                                      " a été supprimé")));
                              setState(() {
                                channelListb.removeAt(index);
                               
                                if (channelListb.length == 0) {
                            
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
                            child: GestureDetector(onTap: () async{


setState(() {
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
                                 child: FlatButton(onPressed: () async{ var a= new Channelb( channelListb[index].arRef, channelListb[index].arDesign, channelListb[index].deCode, channelListb[index].arImage, channelListb[index].deDepot, channelListb[index].qtesto, double.parse(qteController1.text), channelListb[index].barcode, double.parse(prixController1.text), channelListb[index].cump);
          
                                  setState(() { 
                                 channelListb.removeAt(index);
                                
                                 channelListb.insert(index, a);
                                
                                   Navigator.pop(context);
                                            
                                 });
                               await  inventairestockmodifier(channelListb[index].qteAjust, channelListb[index].prixAjust,channelListb[index].arRef); 
                               
                                 
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
                                                   Text(
                                                   
                                                    
                                                       removeTrailingZero(channelListb[index].qteAjust.toString()) ,
                                                    
                                                   style: TextStyle(color: Colors.red,fontSize: 13),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                     Text(
                                                   'Prix Ajusté:',
                                                   ),
                                                   Text(
                                                   
                                                    
                                                       removeTrailingZero(channelListb[index].prixAjust.toString()) ,
                                                    
                                                   style: TextStyle(color: Colors.red,fontSize: 13),
                                                   textAlign: TextAlign.center,
                                                   )  ,
                                                  
                                                   
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
                ),
              ],
            ),
          )],));
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
