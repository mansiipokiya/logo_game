import 'package:flutter/material.dart';

class game_page extends StatefulWidget {
  int index;
  List img;

  game_page(this.img, this.index);

  @override
  State<game_page> createState() => _game_pageState();
}

class _game_pageState extends State<game_page> {
  PageController? controller;
  int str = 0;
  int cnt = 0;
  List ans = ["one", "two", "three"];
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
  List user_ans = [];
  List option = [];
  List temp = [];
  int levelNo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
    user_ans=List.filled(ans[levelNo].toString().length, "");
    random_op.shuffle();
    option=List.filled(14, "");
    temp=List.filled(user_ans.length, "");
    for(int i=0;i<user_ans.length;i++){
      option[i]=ans[levelNo][i];
    }
    for(int i=0;i<user_ans.length;i++){
      option[i]=random_op[i];
    }
    option.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Center(child: Text("${widget.index + 1}/${widget.img.length}")),
          backgroundColor: Colors.indigo),
      body: PageView.builder(
        onPageChanged: (value) {
          widget.index = value;
          setState(() {});
        },
        controller: controller,
        itemBuilder: (context, index) {
          return Column(children: [
            Expanded(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.index > 0) {
                        widget.index--;
                      }
                      controller!.jumpToPage(widget.index);
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("my_asset/game_arrow_left.png"))),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("my_asset/${widget.img[index]}"))),
                  )),
                  InkWell(
                    onTap: () {
                      if (widget.index < widget.img.length - 1) {
                        widget.index++;
                      }
                      controller!.jumpToPage(widget.index);
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("my_asset/game_arrow_right.png"))),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                            user_ans.length,
                            (index) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    color: Colors.black38,
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      "${user_ans[index]}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                )),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "my_asset/hint_icon_bulb.png"))),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                            "Use hints",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              )),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "my_asset/ic_round_close_24px.png"))),
                          )),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "my_asset/main_icon_arrow_back.png"))),
                          )),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: GridView.builder(
                        itemCount: 14,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3),
                        itemBuilder: (context, index) {
                          return (option[index] != '')
                              ? InkWell(
                                  onTap: () {
                                    option[temp[index]]=user_ans[index];
                                    user_ans[index]="";
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.black38,
                                    child: Text(
                                      "${option[index]}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                )
                              : Text("");
                        },
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            )
          ]);
        },
      ),
    );
  }
}

