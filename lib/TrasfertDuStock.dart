import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'menu.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
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
import 'arttrans.dart';
import 'package:commons/commons.dart';
import 'sidemenu.dart';

class Tran extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Tran();
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
  Tran({Key key, this.aname, this.email, this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
}

class _Tran extends State<Tran> {
  String _scanBarcode = 'Unknown';
  String selectedName;
  String selectedName1;
  List data = List();
  List data1 = List();
  bool no=false;

  String msg = "0";
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  TextEditingController qteController = TextEditingController();
  String vl = 'e';
  List artdata = List();
  bool iscolored = false;
  bool go = false;
  bool isloading = false;
  int done;
  File imags;
  String deporign;
  String depdes;
  String depintiu1;
  List depdeslist=List();

  final List<Channelt> channelList = <Channelt>[];

  Future getAllName() async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/Depot/selection/${widget.aname}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
      data1 = jsonData;
    });
    print(jsonData);
    return "success";
  }

  Future<http.Response> entreStockadd(String qteE, String ref, String dcode,
      String deporig, String depdes, String barc, String prot) async {
    var url = 'https://${widget.url}/api/articlebar/transfert';

    Map data = {
      "mbQtetrans": qteE,
      "arRef": ref,
      "deCode": dcode,
      "mbDecodeorig": deporig,
      "mbDecodedes": depdes,
      "arCodebarre": barc,
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
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 250,
                child: AutoSizeText(
                  artdata[0]['arDesign'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  minFontSize: 14,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: Constants.padding + 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FittedBox(
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(150),
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: SizedBox(
                                  height: 30,
                                  child: Text('Reference:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )))),
                          TableCell(
                            child: SizedBox(
                              child: Text(artdata[0]['arRef']),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: SizedBox(
                                  height: 30,
                                  child: Text('Designation:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )))),
                          TableCell(
                            child: SizedBox(
                              child: Text(artdata[0]['arDesign']),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: SizedBox(
                                  height: 30,
                                  child: Text('Barre Code:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )))),
                          TableCell(
                            child: SizedBox(
                              child: Text(
                                artdata[0]['arCodebarre'],
                              ),
                            ),
                          ),
                        ]),
                         TableRow(children: [TableCell(
                child: SizedBox(height: 30,child:  Text('Montant en Stock:',style: TextStyle(color: Colors.grey,)))
               
                
                   ),                            
                   TableCell(
                child: SizedBox(child:  Text(removeTrailingZero(double.parse(artdata[0]['asMontsto']).toString()),style:TextStyle(color: Colors.black)),),
             ),
               
              ]),
                        TableRow(children: [
                          TableCell(
                              child: SizedBox(
                                  height: 30,
                                  child: Text('Code Depot:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )))),
                          TableCell(
                            child: SizedBox(
                              child: Text(artdata[0]['deCode'],
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: SizedBox(
                                  height: 30,
                                  child: Text('Nom Depot:',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )))),
                          TableCell(
                            child: SizedBox(
                              child: Text(artdata[0]['deIntitule'],
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 140, child: Divider(color: Color(0xff2193b0))),
              SizedBox(
                  height: 15,
                  child: Text('Quantité en stock:',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'FiraSans'))),
              SizedBox(
                height: 30,
                child: Text(removeTrailingZero(double.parse(artdata[0]['asQtesto']).toString()),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'FiraSans')),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xffEC524B),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          double currentValue =
                              double.parse(qteController.text);

                          setState(() {
                            currentValue--;
                            qteController.text = (currentValue).toString();
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
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                          labelStyle:
                              TextStyle(color: Color(0xFF8B8B8B), fontSize: 12),
                          hintText: 'Qte a ajouté',
                          hintStyle:
                              TextStyle(color: Color(0xFF8B8B8B), fontSize: 12),
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
                          double currentValue =
                              double.parse(qteController.text);

                          setState(() {
                            currentValue++;
                            qteController.text = (currentValue).toString();
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ),
                no==true?   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Quantité insuffisante',style: TextStyle(color:Colors.red),),
                ):SizedBox.shrink(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue[500]),
                  child: FlatButton(
                      onPressed: () {var qte = double.parse(qteController.text);
                          var qtes = double.parse(artdata[0]['asQtesto']);
                           if(qte<=qtes){
                        setState(() {
                          
                         
                      
                          channelList
                            ..add(Channelt(
                                artdata[0]['arRef'],
                                artdata[0]['arDesign'],
                                artdata[0]['deCode'],
                                imags,
                                artdata[0]['deIntitule'],
                                deporign,
                                depdes,
                                qtes,
                                qte,
                                artdata[0]['arCodebarre']));
                          go = true;
                          isloading = false;
                          depintiu1 = selectedName1;
                          depdeslist..add(selectedName1);
                        });
                        Navigator.pop(context);}else{
                         setState(() {
                            no=true;
                         });
                        }
                      },
                      child: Text(
                        "Ajouter",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
              ),
           
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: double.minPositive + 70),
          child: Container(
            height: double.minPositive + 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constants.padding),
                    topRight: Radius.circular(Constants.padding),
                    bottomLeft: Radius.elliptical(300, 80)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff2193b0),
                      Color(0xff6dd5ed),
                    ])),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: imags != null
                    ? new Image.file(
                        imags,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/net.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
          ),
        )
      ],
    );
  }

  Future getArticlebarre(value1, value2) async {
    String dep = value1;
    String bar = value2;
    var response = await http.get(
        Uri.parse("https://${widget.url}/api/articlebar/$dep/$bar/${widget.aname}"),
        headers: {"Accept": "application/json"});

    var jsonBody = response.body;

    if (response.statusCode == 404) {
      return errorDialog(
          context, "Scanner a nouveau ou essayer de changer le depot",
          title: " Article n'existe pas", neutralAction: () {
        setState(() {
          isloading = false;
        });
      });
    } else {
      var jsonData = json.decode(jsonBody);
      setState(() {
        artdata = jsonData;
          qteController.text=removeTrailingZero(double.parse(jsonData[0]['asQtesto']).toString());
          no=false;
      });

      print(jsonData);

      if (jsonData.length == 2) {
        var blob = jsonData[1]['arPhoto'];

        String slag = artdata[0]['arRef'];
        var b = await writeImageTemp(blob, slag);
        setState(() {
          imags = b;
        });
      } else {
        setState(() {
          imags = null;
        });
      }
      var contain = channelList.where((element) =>
          element.arRef == artdata[0]['arRef'] &&
          element.deCode == artdata[0]['deCode'] &&
          element.deDepotdes == depdes);
     
     if(double.parse(artdata[0]['asQtesto'])==0){
return warningDialog(context, "l'article "+artdata[0]['arRef'] +" avec cette code a barre("+artdata[0]['arCodebarre']+") n'est pas disponible a cause de rupture de stock "  ,title: "Rupture de stock",neutralText: "ok",neutralAction: (){
  setState(() {
    isloading=false;
  });
});
}else{
      switch (contain.isNotEmpty) {
        case true:

          // return object of type Dialog
          return warningDialog(context, "Cette Article a déjà été ajouté",
              neutralAction: () {
            setState(() {
              isloading = false;
            });
          });

          break;
        case false:
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.padding),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: setupAlertDialoadContainer(imags, context),
                    ),
                  ),
                );
              }).then((value) {

          setState(() {
            isloading=false;
          });

              });

          break;
      }
    }}
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
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Transfert du Stock'),
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
                  MaterialPageRoute(
                      builder: (context) => Menu(
                          aname: "${widget.aname}",
                          email: "${widget.email}",
                          url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                );
              });
            },
          )
        ],
        centerTitle: true,
      ),
      drawer: ssd(
          aname: "${widget.aname}",
          email: "${widget.email}",
          url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15),
                child: Text("Choix d'entrepôt (origine)"),
              ),
              SizedBox(width: 90),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(
                      Icons.reply,
                      color: Colors.red,
                    )),
              )
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 350.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: iscolored == false
                      ? BorderSide(width: 0.6, style: BorderStyle.solid)
                      : BorderSide(
                          width: 0.6,
                          style: BorderStyle.solid,
                          color: Colors.red),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        hint: iscolored == false
                            ? Text('Sélectionner un entrepôt')
                            : Text(
                                'Sélectionner un entrepôt',
                                style: TextStyle(color: Colors.red),
                              ),
                        icon: iscolored == false
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
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
                            iscolored = false;
                            print(selectedName);
                          });
                          var i = 0;
                          while (data[i]['deIntitule'] != selectedName) {
                            i++;
                          }
                          setState(() {
                            deporign = data[i]['deCode'];
                          });
                          print(deporign);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15),
                child: Text("Choix d'entrepôt (destination)"),
              ),
              SizedBox(width: 58),
              Icon(
                Icons.reply,
                color: Colors.green,
              ),
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 350.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: iscolored == false
                      ? BorderSide(width: 0.6, style: BorderStyle.solid)
                      : BorderSide(
                          width: 0.6,
                          style: BorderStyle.solid,
                          color: Colors.red),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        hint: iscolored == false
                            ? Text('Sélectionner un entrepôt')
                            : Text(
                                'Sélectionner un entrepôt',
                                style: TextStyle(color: Colors.red),
                              ),
                        icon: iscolored == false
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
                        iconSize: 33,
                        value: selectedName1,
                        items: data1.map((list) {
                          return DropdownMenuItem(
                            child: Text(list['deIntitule']),
                            value: list['deIntitule'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedName1 = value;
                            iscolored = false;
                          });
                          var i = 0;
                          while (data1[i]['deIntitule'] != selectedName1) {
                            i++;
                          }
                          setState(() {
                            depdes = data[i]['deCode'];
                          });
                          print(depdes);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Image.asset(
                'images/scan.png',
                cacheWidth: 300,
                cacheHeight: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Container(
                child: !isloading
                    ? FlatButton(
                        child: Text('Scanner code a barre'),
                        color: Color(0xffec524b),
                        textColor: Colors.white,
                        minWidth: 350,
                        height: 50,
                        onPressed: () async {
                          if (selectedName == null || selectedName1 == null) {
                            setState(() {
                              iscolored = true;
                            });
                          } else if(selectedName==selectedName1){
                                 setState(() {
                              iscolored = true;
                            });
                          }
                          
                          
                          else {
                            setState(() {
                              isloading = true;
                            });
                            await scanBarcodeNormal();
                            if (_scanBarcode.isNotEmpty) {
                              var mm = await getArticlebarre(
                                  selectedName, _scanBarcode);
                            }
                          }
                        })
                    : CircularProgressIndicator(),
              ),
            ),
          ),
          new SizedBox(
            height: 10,
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: go == true,
            child: new Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff2193b0),
                          Color(0xff6dd5ed),
                        ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Produit Ajoutées:",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.amber[400]),
                      child: Row(
                        children: [
                          FlatButton(
                            child: Text('Valider',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            onPressed: () async {
                              return await confirmationDialog(context,
                                  "Le mouvement va être enregistré et validé, voulez-vous continuer",
                                  positiveText: "Valider",
                                  positiveAction: () async {
                                var n = channelList.length;
                                for (var i = 0; i < n; i++) {
                                  var f = entreStockadd(
                                      channelList[i].qte.toString(),
                                      channelList[i].arRef,
                                      channelList[i].deCode,
                                      channelList[i].deDepotorig,
                                      channelList[i].deDepotdes,
                                      channelList[i].barcode,
                                      '${widget.aname}');

                                  print(await f);
                                  setState(() {
                                    done = i;
                                  });
                                }

                                return successDialog(
                                  context,
                                  "Opération terminé avec succès",
                                  neutralText: 'Okay',
                                  neutralAction: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Tran(
                                                aname: "${widget.aname}",
                                                email: "${widget.email}",
                                                url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
                                              )),
                                    );
                                  },
                                );
                              });
                            },
                          ),
                          Icon(Icons.done)
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
            child: SizedBox(
     
              child: ListView.builder(
                  itemCount: channelList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var a = channelList[index].qte.toString();
                    var b = channelList[index].qtesto.toString();
                    final item = channelList[index].toString();
                    double c_width = MediaQuery.of(context).size.width * 0.37;
                     double c_width1 = MediaQuery.of(context).size.width * 0.371;
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Article " +
                                channelList[index].arRef +
                                " a été supprimé")));
                        setState(() {
                          channelList.removeAt(index);
                          depdeslist.removeAt(index);
                          if (channelList.length == 0) {
                            go = false;
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
                      child: GestureDetector(onTap: () async{setState(() {
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
                                      labelText: 'Qte a modifier',
                                      labelStyle: TextStyle(
                                          color: Color(0xFF8B8B8B), fontSize: 12),
                                      hintText: 'Qte a modifier',
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
                                 child: FlatButton(onPressed: (){ var a= new Channelt(channelList[index].arRef, channelList[index].arDesign, channelList[index].deCode, channelList[index].arImage, channelList[index].deDepot,channelList[index].deDepotorig ,channelList[index].deDepotdes,channelList[index].qtesto, double.parse(qteController.text), channelList[index].barcode);
                                  var b=depdeslist[index];
                                  setState(() { 
                                 channelList.removeAt(index);
                                 depdeslist.removeAt(index);
                                 channelList.insert(index, a);
                                 depdeslist.insert(index,b);
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
                                            padding: const EdgeInsets.only(left:10.0),
                                            child: ClipOval(
                                              child: channelList[index].arImage != null
                                                  ? new Image.file(
                                                      channelList[index].arImage,
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
                                                  new  Text(channelList[index].barcode,
                                                            style: TextStyle(fontSize: 13)),
                                                  SizedBox(height: 3,),
                                                  
                                                
                                                    new    Text(channelList[index].deDepot,
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
                                             Text(
                                             channelList[index].deDepot +
                                                 '(-' +
                                                 removeTrailingZero(a) +
                                                 ')',
                                             style: TextStyle(color: Colors.red,fontSize: 13),
                                             textAlign: TextAlign.center,
                                             ),
                                             Icon(Icons.compare_arrows_sharp),
                                             Text(
                                             depdeslist[index]+
                                                 '(+' +
                                                 removeTrailingZero(a) +
                                                 ')',
                                             style: TextStyle(color: Colors.green,fontSize: 13),
                                             textAlign: TextAlign.center,
                                             ),
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
          )
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
  imageName = imageName + '.jpg';
  File file = File('${appDir.path}/' + imageName);

  await file.writeAsBytes(bytes);

  return file;
}
