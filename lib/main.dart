import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pokemon.dart';
import 'dart:convert';
void main() => runApp(new PokeApp());

class PokeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Poke App',
      theme: new ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new MyHomePage(title: 'Poke App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title, textAlign: TextAlign.center,),
      ),
      body: 
      pokeHub == null ? Center(
        child: CircularProgressIndicator(),
        ):
        GridView.count(
          crossAxisCount: 2,
          children: pokeHub.pokemon.map((poke)=>Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(poke.img)
                      )
                    ),
                  ),
                  Text(poke.name,
                   style: TextStyle(
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold
                   ),)
                ],
              ),
            ),
          )).toList(),
        ),
      drawer: new Drawer(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Refresh',
        child: new Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
