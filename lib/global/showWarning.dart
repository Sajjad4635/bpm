import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

showWarnning(context, warnningText) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          //this right here
          child: Container(
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              left:15.0,
              right: 15.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // To make the card compact
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Warning-rafiki.png'))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  warnningText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iran_yekan',
                      fontSize: 15.0,
                      color: Colors.black54),
                ),
                SizedBox(height: 24.0),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 75.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Center(
                      child: Text(
                        'تایید',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
showDialogTaskDone(context, warnningText) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          //this right here
          child: Container(
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 15.0,
              left:15.0,
              right: 15.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // To make the card compact
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: SvgPicture.asset('images/taskDone.svg',
                    width: 23.0,
                    height: 23.0,
                    color: themeColor),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  warnningText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'iran_yekan',
                      fontSize: 15.0,
                      color: Colors.black54),
                ),
                SizedBox(height: 24.0),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 75.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Center(
                      child: Text(
                        'تایید',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}