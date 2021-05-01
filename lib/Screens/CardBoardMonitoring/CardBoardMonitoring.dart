import 'package:bpm/Screens/CardBoardMonitoring/cardBoardModelMonitoring.dart';
import 'package:bpm/Screens/CardBoardMonitoring/fechCardBoadsMonitoring.dart';
import 'package:bpm/Screens/Cardboard/cardBoardPage/cardBoardPage.dart';
import 'package:bpm/global/glabalVariables.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<AllCardBoardsMonitoring> allCardBoardsMonitoring = new List();
var flagCardBoardMonitoring = 0;

class CardBoardMonitoring extends StatefulWidget {
  @override
  _CardBoardMonitoringState createState() => _CardBoardMonitoringState();
}

class _CardBoardMonitoringState extends State<CardBoardMonitoring> {

  var myIcons = {
    'fa fa-calendar': FontAwesomeIcons.calendar,
    'fa fa-hourglass': FontAwesomeIcons.hourglass,
    'fa fa-truck-loading': FontAwesomeIcons.truckLoading,
    'fa fa-file-invoice': FontAwesomeIcons.fileInvoice,
    'fa fa-box-open': FontAwesomeIcons.boxOpen,
    'fa fa-search-dollar': FontAwesomeIcons.searchDollar,
    'fa fa-shipping-fast': FontAwesomeIcons.shippingFast,
    'fa fa-newspaper': FontAwesomeIcons.newspaper,
    'fa fa-medkit': FontAwesomeIcons.medkit,
    'fa fa-balance-scale': FontAwesomeIcons.balanceScale,
  };

  @override
  Widget build(BuildContext context) {

    if(flagCardBoardMonitoring == 0){
      setState(() {
        getAllTasksMonitoring();
        flagCardBoardMonitoring = 1;
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: allCardBoardsMonitoring.isEmpty
          ? LoadingPage()
          : Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: allCardBoardsMonitoring.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cardBoardPage(
                          allCardBoardsMonitoring[index].value,
                          allCardBoardsMonitoring[index].orderKey,
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
                              myIcons['${allCardBoardsMonitoring[index].icon}'],
                              color: themeColor,
                            ),
                          ),
                          allCardBoardsMonitoring[index].count == 0
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
                                '${allCardBoardsMonitoring[index].count}',
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
                          '${allCardBoardsMonitoring[index].value}',
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

  getAllTasksMonitoring() async {
    var response = await get_AllCardBoardsMonitoring.get_allcardboardsmonitoring();

    setState(() {
      allCardBoardsMonitoring = response['allCardBoardsMonitoring'];

    });
  }
}
