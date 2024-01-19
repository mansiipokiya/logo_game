import 'package:flutter/material.dart';
import 'package:logo_game/level_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: logo_qwiz(),));
}
class logo_qwiz extends StatefulWidget {
  static SharedPreferences ? prefs;

  @override
  State<logo_qwiz> createState() => _logo_qwizState();
}

class _logo_qwizState extends State<logo_qwiz> {
  bool start=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_pref();
  }
  get_pref() async {
    logo_qwiz.prefs = await SharedPreferences.getInstance();

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(children: [
        Expanded(child: Container(child: Row(children: [
          Column(children: [
            SizedBox(height: 20,),
            Text("LOGO GAME",style: TextStyle(fontSize: 25),),
            Text("          Quiz your brands knowledge"),
          ],),
          Expanded(child: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/main_background_top_logos.png")))))
        ],),)),
        Expanded(child: GestureDetector(onTapUp: (details) {
          start=true;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return level_page();
          },));
          setState(() {});
        },onTapCancel: () {
          start=false;
          setState(() {});
        },onTapDown: (details) {
          start=false;
          setState(() {});
        },child: Container(alignment: Alignment.center,child: Text("PLAY",style: TextStyle(color: Colors.white),),decoration: BoxDecoration(image: DecorationImage(image:(start)? AssetImage("my_asset/main_button_play.png"): AssetImage("my_asset/main_button_play_clicked.png")))))),
        Expanded(child: Container()),
        Expanded(child: Container(child: Row(children: [
          Expanded(child: Container(margin: EdgeInsets.all(30),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/main_button_ranking.png"))))),
          Expanded(child: Container(margin: EdgeInsets.all(30),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/main_button_stats.png"))))),
          Expanded(child: Container(margin: EdgeInsets.all(30),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/main_button_achievements.png"))))),
        ],),)),
        Expanded(child: Container()),
        Expanded(child: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/main_background_bottom_logos.png"))),)),
      ],),),
    );
  }
}
