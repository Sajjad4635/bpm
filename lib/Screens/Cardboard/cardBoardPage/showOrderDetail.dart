import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

var list = [
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
  'عملیات',
];

class showOrderDetail extends StatefulWidget {
  var taskID;

  showOrderDetail(this.taskID);

  @override
  _showOrderDetailState createState() => _showOrderDetailState();
}

class _showOrderDetailState extends State<showOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/ic_back3.png'),
            fit: BoxFit.fitHeight,
            colorFilter: new ColorFilter.mode(
                Colors.blue.withOpacity(0.15), BlendMode.dstATop),
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              left: 15.0,
              right: 15.0
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: themeColor
                  ),
                  height: 50.0,
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'شماره سفارش :',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'iran_yekan',
                            color: Colors.white
                        ),
                      ),
                      Text(
                        '${widget.taskID}',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'iran_yekan',
                            color: Colors.white
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, sIndex){
                      return Container(
                        height: 15.0,
                      );
                    },
                    itemCount: list.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 80.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                                color: themeColor
                            )
                        ),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3.0),
                                      bottomRight: Radius.circular(3.0)
                                  ),
                                  color: themeColor,
                                ),
                                child: Center(
                                  child: Text(
                                    '${list[index]}',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'iran_yekan',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'text',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'iran_yekan',
                                        color: themeColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}