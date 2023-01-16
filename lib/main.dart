import 'package:flutter/material.dart';
import 'package:myanimelist/layout/seasonalAnime.dart';
import 'package:myanimelist/layout/topAnime.dart';

void main() {
  runApp(const MaterialApp(
    title: "Elanime",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Elanime"),
          bottom: TabBar(
            controller: controller,
            tabs: const <Widget>[
              Tab(
                text: "Top Anime",
              ),
              Tab(
                text: "Seasonal Anime",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: const <Widget>[
            TopAnime(),
            SeasonalAnime(),
          ],
        ));
  }
}
