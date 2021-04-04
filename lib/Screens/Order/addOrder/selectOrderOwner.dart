import 'package:bpm/Screens/Order/getAllUsers.dart';
import 'package:bpm/global/SearchUserModel.dart';
import 'package:bpm/global/loadingPage.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

List<UserSearch> allUsers = new List();
List<String> list = new List();

var searchController = TextEditingController();

class selectOrderOwner extends StatefulWidget {
  final Function(String userName, String userID) setSelectedName;

  selectOrderOwner({Key key, @required this.setSelectedName}) : super(key: key);

  @override
  _selectOrderOwnerState createState() => _selectOrderOwnerState();
}

class _selectOrderOwnerState extends State<selectOrderOwner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allUsers.clear();
    list.clear();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('جست و جو کنید',
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'iran_yekan',
        ),),
      ),
      body: list.isEmpty
      ? LoadingPage()
      : Column(
        children: [
          Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: ListView.separated(
                  separatorBuilder: (context, sIndex){
                    return Container(
                      height: 15.0,
                    );
                  },
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.setSelectedName(
                              allUsers[index].name,
                              allUsers[index].id);
                          Navigator.pop(context,);
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
                                borderRadius: BorderRadius.all(
                                    Radius.circular(35.0)),
                              ),
                              child: Container(
                                child: Text(
                                  '${list[index]}',
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
                            animationDuration:
                            Duration(seconds: 30),
                            backDuration:
                            Duration(milliseconds: 1000),
                            pauseDuration:
                            Duration(milliseconds: 1000),
                            directionMarguee:
                            DirectionMarguee.TwoDirection,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );
  }

  getAllUsers() async {
    var response = await GetAllUsers.getallusers();
    setState(() {
      allUsers = response['allUsers'];
      for(int i=0;i<allUsers.length;i++){
        list.add(allUsers[i].name);
      }
    });
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}