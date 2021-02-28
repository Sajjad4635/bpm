import 'package:bpm/Screens/chat/allCustomers/allChatsView.dart';
import 'package:flutter/material.dart';

class Operation extends StatefulWidget {
  @override
  _OperationState createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllCustomers()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.3,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color(0xff303F9F),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'ورود به چت',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'iran_yekan',
                              fontSize: 14.0,
                              color: Colors.white
                          ),
                        )
                    ),
                    Expanded(
                        flex: 3,
                        child: Container()
                    ),
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
