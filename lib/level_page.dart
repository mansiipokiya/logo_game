import 'package:flutter/material.dart';
import 'package:logo_game/game.dart';
import 'package:logo_game/main.dart';

class level_page extends StatefulWidget {
  int ?hin;
  level_page([this.hin]);
  @override
  State<level_page> createState() => _level_pageState();
}

class _level_pageState extends State<level_page> {
  List img = [
    "l_a_facebook_s.png",
    "l_a_mcdonalds_s.png",
    "l_a_lufthansa.png",
    "l_a_mercedes.png",
    "l_a_lacoste.png",
    "l_a_shell_s.png",
    "l_a_nike_s.png",
    "l_a_redbull.png",
    "l_a_wikipedia.png",
    "l_a_volkswagen_s.png",
    "l_a_visa.png",
    "l_a_twitter_s.png",
    "l_a_louis_vuitton.png",
    "l_a_citroen.png",
    "l_a_audi.png",
    "l_a_apple_s.png",
    "l_a_adidas.png",
  ];
  int hint=20;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.hin!=null){
      hint=widget.hin!;
    }else{
      hint=logo_qwiz.prefs!.getInt("Hint")??0;
    }
    // logo_qwiz.prefs!.setInt("Hint", hint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(height: 50,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,
                image: AssetImage("my_asset/main_background_header.png"))),
            child: Row(children: [
              Expanded(child: InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return logo_qwiz();
                },));
              },child: Container(height: 30,width: 30,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("my_asset/main_icon_arrow_back.png"))),))),
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("LEVEL 1",style: TextStyle(fontSize: 20,color: Colors.white),),)),
              Expanded(child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("my_asset/n_bulb_mark.png"))),)),
              Expanded(child: Text("hints\n${hint}",style: TextStyle(color: Colors.white),))
            ],),),
        Expanded(
          child: GridView.builder(
            itemCount: img.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 30, crossAxisSpacing: 30),
            itemBuilder: (context, index) {
              String test=logo_qwiz.prefs!.getString("level$index") ?? "";
              return InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return game(img, index);
                },));
              },
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(opacity:(test=="yes")?  170:1,
                          image: AssetImage("my_asset/${img[index]}"))),
                  child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Expanded(child: Container()),
                    Container(height: 70,width: 70,decoration: BoxDecoration(image:(test=="yes")? DecorationImage(image: AssetImage("my_asset/level_guessed_badge.png")):null),)]),
                ),
              );
            },
          ),
        )
      ],),
    );
  }
}
