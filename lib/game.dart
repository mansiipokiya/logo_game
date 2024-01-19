import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logo_game/level_page.dart';
import 'package:logo_game/main.dart';

class game extends StatefulWidget {
  int index;
  List img;

  game(this.img, this.index);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  PageController? controller;
  List ans = [
    "ONE",
    "TWO",
    "THREE",
    "FOUR",
    "FIVE",
    "SIX",
    "SEVEN",
    "EIGHT",
    "NINE",
    "TEN",
    "VISA",
    "TWITTER",
    "louisvuitton",
    "CIRTOEN",
    "AUDI",
    "APPLE",
    "ADIDAS",
  ];
  int levelNo = 0, cnt = 0;
  List user_ans = [];
  List temp = [];
  List temp1 = [];
  List option = [];

  List random_op = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "W",
    "X",
    "Y",
    "Z"
  ];
  int hint=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    levelNo = widget.index;
    hint=logo_qwiz.prefs!.getInt("Hint") ?? 0 ;
    get();
  }

  get() {
    controller = PageController(initialPage: levelNo);
    user_ans = List.filled(ans[levelNo].toString().length, "");
    random_op.shuffle();
    option = List.filled(14, "");
    temp = List.filled(user_ans.length, "");
    temp1 = List.filled(user_ans.length, "");
    for (int i = 0; i < user_ans.length; i++) {
      option[i] = ans[levelNo][i];
    }
    for (int i = user_ans.length; i < 14; i++) {
      option[i] = random_op[i];
    }

    option.shuffle();
  }
  m(){
    logo_qwiz.prefs!.setInt("Hint", hint);
  }
  win() {
    List mans = [];
    mans = List.filled(user_ans.length, "");
    for (int i = 0; i < ans[levelNo].length; i++) {
      mans[i] = ans[levelNo][i];
    }
    if (listEquals(mans, user_ans)) {
      hint=hint+2;

      logo_qwiz.prefs!.setString("level$levelNo", "yes");
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     logo_qwiz.prefs!.setString("level$levelNo", "yes");
      //     return AlertDialog(
      //       actions: [
      //         Container(
      //             alignment: Alignment.center, child: Text("you are win...!")),
      //         TextButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //               levelNo++;
      //               controller!.jumpToPage(levelNo);
      //             },
      //             child: Text("NEXT"))
      //       ],
      //     );
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      onPageChanged: (value) {
        levelNo = value;
        get();
        setState(() {});
      },
      controller: controller,
      itemBuilder: (context, index) {
        String test = logo_qwiz.prefs!.getString("level$index") ?? "";
        return (test == "yes")
            ? Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "my_asset/main_background_header.png"))),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return level_page(hint);
                                    },
                                  ));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "my_asset/main_icon_arrow_back.png"))),
                                ))),
                        Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("${index + 1}/${widget.img.length}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("my_asset/n_bulb_mark.png"))),
                        )),
                        Expanded(
                            child: Text(
                          "hints\n${hint}",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.index > 0) {
                                  levelNo--;
                                }
                                controller!.jumpToPage(levelNo);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "my_asset/game_arrow_left.png"))),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "my_asset/${widget.img[index]}"))),
                            )),
                            InkWell(
                              onTap: () {
                                if (widget.index < widget.img.length - 1) {
                                  levelNo++;
                                }
                                controller!.jumpToPage(levelNo);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "my_asset/game_arrow_right.png"))),
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("my_asset/game_complete_background_green.png"))),
                    child:Column(children: [
                      Expanded(flex: 2,
                        child: Container(
                          child: Text(
                            "\nPerfect !",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: InkWell(onTap: () {
                              // Navigator.pop(context);
                              levelNo++;
                              controller!.jumpToPage(levelNo);
                            },
                              child: Container(margin: EdgeInsets.all(10),alignment: Alignment.center,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("my_asset/game_button_next_clicked.png"))),
                                child: Text(
                                  "NEXT",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],),
                      ),
                    ],)
                  ))
                ],
              )
            : Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "my_asset/main_background_header.png"))),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return level_page(hint);
                                    },
                                  ));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "my_asset/main_icon_arrow_back.png"))),
                                ))),
                        Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text("${index + 1}/${widget.img.length}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("my_asset/n_bulb_mark.png"))),
                        )),
                        Expanded(
                            child: Text(
                          "hints\n${hint}",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.index > 0) {
                                  levelNo--;
                                }
                                // levelNo--;
                                controller!.jumpToPage(levelNo);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "my_asset/game_arrow_left.png"))),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "my_asset/${widget.img[levelNo]}"))),
                            )),
                            InkWell(
                              onTap: () {
                                if (widget.index < widget.img.length-1) {
                                  levelNo++;
                                }
                                controller!.jumpToPage(levelNo);
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "my_asset/game_arrow_right.png"))),
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                    child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                            user_ans.length,
                            (index) => (user_ans[index] != "")
                                ? InkWell(
                                    onTap: () {
                                      if (temp1[index] == false) {
                                        option[temp[index]] = user_ans[index];
                                        user_ans[index] = "";
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      color: (temp1[index] == true)
                                          ? Colors.black12
                                          : Colors.black38,
                                      margin: EdgeInsets.all(5),
                                      child: Text("${user_ans[index]}"),
                                    ),
                                  )
                                : Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    color: Colors.black38,
                                    margin: EdgeInsets.all(5),
                                    child: Text("${user_ans[index]}"),
                                  ))),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(backgroundColor: Colors.black,
                                      actions: [
                                        Column(children: [
                                          Text("You have ${logo_qwiz.prefs!.getInt("Hint")} hints",style: TextStyle(color: Colors.white),),
                                          InkWell(onTap: (hint>=1)?() {
                                            hint=hint-1;
                                            int r = Random().nextInt(user_ans.length);
                                            // print(r);
                                            List abc = [];
                                            abc = List.filled(user_ans.length, "");
                                            for (int i = 0;
                                            i < ans[levelNo].length;i++) {
                                              abc[i] = ans[levelNo][i];
                                            }
                                            user_ans[r] = abc[r];
                                            for (int i = 0; i < option.length; i++) {
                                              if (abc[r] == option[i]) {
                                                temp[r] = i;
                                                temp1[r] = true;
                                                option[i] = "";
                                                break;
                                              }
                                            }
                                            win();
                                            Navigator.pop(context);
                                            setState(() {});
                                          }:null,
                                            child: Container(width: double.infinity,height: 30,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                              Image(image: AssetImage("my_asset/hint_icon_random_letter.png")),
                                              Text("random letter    1",style: TextStyle(color: Colors.white),),
                                              Image(image: AssetImage("my_asset/hint_icon_bulb.png")),
                                            ],),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/n_pop_hints_green.png"))),),
                                          ),
                                          InkWell(onTap:(hint>=2)? () {
                                            hint=hint-2;
                                            int r = Random().nextInt(user_ans.length);
                                            int r1 = Random().nextInt(user_ans.length);
                                            // print(r);
                                            List efg = [];
                                            List efg1 = [];
                                            efg = List.filled(user_ans.length, "");
                                            efg1 = List.filled(user_ans.length, "");
                                            for (int i = 0; i < ans[levelNo].length; i++) {
                                              efg[i] = ans[levelNo][i];
                                              efg1[i] = ans[levelNo][i];
                                            }
                                            user_ans[r] = efg[r];
                                            user_ans[r1] = efg[r1];
                                            for (int i = 0; i < option.length; i++) {
                                              if (efg[r] == option[i]) {
                                                temp[r] = i;
                                                temp1[r] = true;
                                                option[i] = "";
                                                break;
                                              }
                                            }
                                            for (int i = 0; i < option.length; i++) {
                                              if (efg1[r1] == option[i]) {
                                                temp[r1] = i;
                                                temp1[r1] = true;
                                                option[i] = "";
                                                break;
                                              }
                                            }
                                            m();
                                            win();
                                            Navigator.pop(context);
                                            setState(() {});
                                          }:null,
                                            child: Container(width: double.infinity,height: 30,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                              Image(image: AssetImage("my_asset/hint_icon_category.png")),
                                              Text("2 random letter    1",style: TextStyle(color: Colors.white),),
                                              Image(image: AssetImage("my_asset/hint_icon_bulb.png")),
                                            ],),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/n_pop_hints_green.png"))),),
                                          ),
                                          Container(width: double.infinity,height: 30,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                            Image(image: AssetImage("my_asset/hint_icon_selected_letter.png")),
                                            Text("selected letter    2",style: TextStyle(color: Colors.white),),
                                            Image(image: AssetImage("my_asset/hint_icon_bulb.png")),
                                          ],),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/n_pop_hints_blue.png"))),),
                                          InkWell(onTap: (hint>=3)?() {
                                            hint=hint-3;
                                            List man = [];
                                            man = List.filled(user_ans.length, "");
                                            for (int i = 0; i < ans[levelNo].length; i++) {
                                              man[i] = ans[levelNo][i];
                                            }
                                            for(int i=0;i<option.length;i++){
                                              option[i]="";
                                            }
                                            for(int i=0;i<man.length;i++){
                                              option[i]=man[i];
                                            }
                                            m();
                                            win();
                                            setState(() {});
                                            Navigator.pop(context);
                                          }:null,
                                            child: Container(width: double.infinity,height: 30,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                              Image(image: AssetImage("my_asset/hint_icon_remove_letters.png")),
                                              Text("remove extra letters    3",style: TextStyle(color: Colors.white),),
                                              Image(image: AssetImage("my_asset/hint_icon_bulb.png")),
                                            ],),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/n_pop_hints_blue.png"))),),
                                          ),
                                          InkWell(onTap:(hint>=9)? () {
                                            hint=hint-9;
                                            List man = [];
                                            man = List.filled(user_ans.length, "");
                                            for (int i = 0; i < ans[levelNo].length; i++) {
                                              man[i] = ans[levelNo][i];
                                            }
                                            for(int i=0;i<user_ans.length;i++){
                                              user_ans[i]=man[i];
                                            }
                                            m();
                                            setState(() {});
                                            Navigator.pop(context);
                                            win();
                                          }:null,
                                            child: Container(width: double.infinity,height: 30,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                              Image(image: AssetImage("my_asset/hint_icon_solve.png")),
                                              Text("solve    9",style: TextStyle(color: Colors.white),),
                                              Image(image: AssetImage("my_asset/hint_icon_bulb.png")),
                                            ],),decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("my_asset/hint_background_red.png"))),),
                                          ),
                                          InkWell(onTap: () {
                                            Navigator.pop(context);
                                          },child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 2,color: Colors.white)),child: Text("close",style: TextStyle(color: Colors.white),),))
                                        ],)
                                      ],
                                    );
                                  },
                                );

                                setState(() {});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "  Use hint",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "my_asset/game_button_use_hints_clicked.png")),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.all(10),
                              ),
                            )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            for (int i = 0; i < user_ans.length; i++) {
                              if (user_ans[i] != "") {
                                option[temp[i]] = user_ans[i];
                                user_ans[i] = "";
                              }
                            }
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "my_asset/game_button_clear_clicked.png"))),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            for (int i = temp.length - 1; i >= 0; i--) {
                              if (temp[i] != '') {
                                option[temp[i]] = user_ans[i];
                                temp[i] = "";
                                user_ans[i] = "";
                                break;
                              }
                            }
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "my_asset/game_button_back_clicked.png"))),
                          ),
                        )),
                      ],
                    ),
                  )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: GridView.builder(
                          itemCount: 14,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3),
                          itemBuilder: (context, index) {
                            return (option[index] != '')
                                ? InkWell(
                                    onTap: () {
                                      for (int i = 0;
                                          i < user_ans.length;
                                          i++) {
                                        if (user_ans[i] == "") {
                                          user_ans[i] = option[index];
                                          temp[i] = index;
                                          temp1[i] = false;
                                          option[index] = "";
                                          break;
                                        }
                                      }
                                      // print('${user_ans}');
                                      // print('${temp}');
                                      // print('${option}');
                                      m();
                                      win();
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black38,
                                      child: Text("${option[index]}"),
                                    ),
                                  )
                                : Text("");
                          },
                        ),
                      )),
                  Expanded(child: Container()),
                ],
              );
      },
    ));
  }
}
