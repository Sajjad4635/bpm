import 'package:bpm/Screens/Cardboard/cardBoardModel.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/cardBoardPage.dart';
import 'package:bpm/Screens/Cardboard/fechCardBoads.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<AllCardBoards> allCardBoards = new List();
var flagCardboard = 0;

class Cardboard extends StatefulWidget {
  @override
  _CardboardState createState() => _CardboardState();
}

class _CardboardState extends State<Cardboard> {

  var myIcons = {
    'fa fa-check-double': FontAwesomeIcons.checkDouble,
    'fa fa-calendar-check': FontAwesomeIcons.calendarCheck,
    'fa fa-paper-plane': FontAwesomeIcons.paperPlane,
    'fa fa-phone-square': FontAwesomeIcons.phoneSquare,
    'fa fa-dolly': FontAwesomeIcons.dolly,
    'fa fa-id-card': FontAwesomeIcons.idCard,
    'fa fa-pen-square': FontAwesomeIcons.penSquare,
    'fa fa-plane': FontAwesomeIcons.plane,
    'fa fa-map-marked-alt': FontAwesomeIcons.mapMarkedAlt,
    'fa fa-university': FontAwesomeIcons.university,
    'fa fa-search-dollar': FontAwesomeIcons.searchDollar,
    'fa fa-podcast': FontAwesomeIcons.podcast,
    'fa fa-chat': FontAwesomeIcons.rocketchat,
    'fa fa-exchange-alt': FontAwesomeIcons.exchangeAlt,
    'fa fa-life-ring': FontAwesomeIcons.medkit,
    'fa fa-volume-control-phone': FontAwesomeIcons.medkit,
    'fa fa-print': FontAwesomeIcons.medkit,
  };

  @override
  Widget build(BuildContext context) {

    if(flagCardboard == 0){
      setState(() {
        getAllTasks();
        flagCardboard = 1;
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: allCardBoards.isEmpty
        ? LoadingPage()
      : Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: allCardBoards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cardBoardPage(
                              allCardBoards[index].value,
                              allCardBoards[index].orderKey,
                            )));
              },
              child: Container(
                  child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 60.0,
                        height: 60.0,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                            color: Colors.white,
                            border: Border.all(color: themeColor)),
                        child: Icon(
                          myIcons['${allCardBoards[index].icon}'],
                          color: themeColor,
                        ),
                      ),
                      allCardBoards[index].count == 0
                          ? Container(
                              width: 20.0,
                              height: 20.0,
                            )
                          : Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                  color: Colors.red),
                              child: Center(
                                child: Text(
                                  '${allCardBoards[index].count}',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'iran_yekan',
                                      fontSize: 10.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                    ],
                  ),
                  Container(
                    child: Text(
                      '${allCardBoards[index].modelType}',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'iran_yekan',
                          fontSize: 15.0,
                          color: themeColor),
                    ),
                  ),
                ],
              )),
            );
          },
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => ServiceSelection()));
//        },
//        child: Icon(
//          Icons.shopping_cart,
//        ),
//      ),
    );
  }

  getAllTasks() async {
    var response = await get_AllCardBoards.get_allcardboards();

    setState(() {
      allCardBoards = response['allCardBoards'];
    });
  }
}
