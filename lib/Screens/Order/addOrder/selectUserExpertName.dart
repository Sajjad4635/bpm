import 'package:bpm/Screens/Order/addOrder/ServiceSelection/serviceSelection.dart';
import 'package:bpm/Screens/Order/getAllUserExpert.dart';
import 'package:bpm/Screens/Order/getAllUsers.dart';
import 'package:bpm/global/SearchUserModel.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

List<UserSearch> allUserExpert = new List();

class selectUserExpert extends StatefulWidget {
  final Function(String userName, String userID) setSelectedUserExpertName;

  selectUserExpert({Key key, @required this.setSelectedUserExpertName}) : super(key: key);
  @override
  _selectUserExpertState createState() => _selectUserExpertState();
}

class _selectUserExpertState extends State<selectUserExpert> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allUserExpert.clear();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: allUserExpert.isEmpty
            ? LoadingPage()
            : Container(
          child: allUserExpert.isEmpty
              ? LoadingPage()
              : ListView.separated(
            separatorBuilder: (context, index) {
              return Container(
                height: 10.0,
              );
            },
            itemCount: allUserExpert.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.setSelectedUserExpertName(allUserExpert[index].name, allUserExpert[index].id);
                    Navigator.pop(
                      context,
                    );
                  });
                },
                child: Container(
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: themeColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Marquee(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                        ),
                        child: Container(
                          child: Text(
                            '${allUserExpert[index].name}',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeColor,
                                fontFamily: 'iran_yekan',
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      direction: Axis.horizontal,
                      textDirection: TextDirection.rtl,
                      animationDuration: Duration(seconds: 30),
                      backDuration: Duration(milliseconds: 1000),
                      pauseDuration: Duration(milliseconds: 1000),
                      directionMarguee: DirectionMarguee.TwoDirection,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getAllUsers() async {
    var response = await GetAllUserExpert.getallusersexpert();
    setState(() {
      allUserExpert = response['allUserExpert'];
    });
  }
}
