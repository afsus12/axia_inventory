import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'listedesdepotes.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'ajouterUtilisateur.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  final String aname;

  final String email;
  final String url;

  HomeScreen({Key key, this.aname, this.email, this.url}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
//Step 3
  _HomeScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

//Step 1
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Gestion des utilisateurs');

  //step 2.1
  void _getNames() async {
    final response =
        await dio.get('https://192.168.1.36:8000/api/users/getusers');
    print(response.data);
    List tempList = new List();
    for (int i = 0; i < response.data.length; i++) {
      tempList.add(response.data[i]);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }

//Step 2.2
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Gestion des utilisateurs');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  //Step 4
  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['protmUser']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['protmUser']),
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DepotScreen(
                        aname: "${widget.aname}",
                        email: "${widget.email}",
                        url: "${widget.url}")),
              );
            });
          },
        );
      },
    );
  }

  //STep6
  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ajouterUtilisateur(
                        aname: "${widget.aname}",
                        email: "${widget.email}",
                        url: "${widget.url}")),
              );
            });
          },
        )
      ],
    );
  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),

//      floatingActionButton: FloatingActionButton(
//        onPressed: _postName,
//        child: Icon(Icons.add),
//      ),
    );
  }
}
