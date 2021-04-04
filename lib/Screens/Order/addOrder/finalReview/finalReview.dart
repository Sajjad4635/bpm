import 'package:bpm/Screens/Order/addOrder/getTheCode/getTheCode.dart';
import 'package:bpm/Screens/Order/checkOrderList.dart';
import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class FinalReview extends StatefulWidget {
  @override
  _FinalReviewState createState() => _FinalReviewState();
}

class _FinalReviewState extends State<FinalReview> {
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => checkOrderList()));
                        },
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.only(
                              top: 10.0,
                              left: 80.0,
                              right: 80.0,
                              bottom: 20.0
                          ),
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'کالاهای این سفارش',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'iran_yekan',
                                    fontSize: 14.0),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      miniFinalReview('خدمات موردنیاز', 'حمل بین المللی'),
                      miniFinalReview('شخص ارسال کننده', ' '),
                      miniFinalReview('شرکت ارسال کننده', 'حمل بین المللی'),
                      miniFinalReview('شهر ارسال کننده', 'حمل بین المللی'),
                      miniFinalReview('شخص دریافت کننده', 'حمل بین المللی'),
                      miniFinalReview('شرکت دریافت کننده', 'حمل بین المللی'),
                      miniFinalReview('شهر دریافت کننده', 'حمل بین المللی'),
                      miniFinalReview('پیش فاکتور به نام فرد', 'حمل بین المللی'),
                      miniFinalReview('پیش فاکتور به نام شرکت', 'حمل بین المللی'),
                      miniFinalReview('اینکو ترمز', 'حمل بین المللی'),
                      miniFinalReview('نوع زمان حمل', 'حمل بین المللی'),
                      miniFinalReview('سفارش پارت شود؟', 'حمل بین المللی'),
                      miniFinalReview('نوع پیش فاکتور حمل', 'حمل بین المللی'),
                      miniFinalReview('صدور بارنامه فرعی', 'حمل بین المللی'),
                      miniFinalReview('نوع حمل', 'حمل بین المللی'),
                      miniFinalReview('نوع پیش فاکتور سایر خدمات', 'حمل بین المللی'),
                      miniFinalReview('جمع وزن جرمی (kg)', 'حمل بین المللی'),
                      miniFinalReview('جمع وزن حجمی (kg)', 'حمل بین المللی'),
                      miniFinalReview('وزن قابل پرداخت سفارش (kg)', 'حمل بین المللی'),
                      miniFinalReview('ارزش کل', 'حمل بین المللی'),
                      miniFinalReview('واحد ارزش', 'حمل بین المللی'),
                      miniFinalReview('توضیحات', 'حمل بین المللی'),
                    ],
                  )
              ),
              Container(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GetTheCode()));
                  },
                  child: Container(
                    height: 50.0,
                    margin: EdgeInsets.only(
                        top: 10.0,
                        left: 80.0,
                        right: 80.0,
                        bottom: 10.0
                    ),
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Center(
                      child: Text(
                        'تایید نهایی سفارش',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget miniFinalReview(title, text){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90.0,
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)
                ),
                color: themeColor,
              ),
              child: Center(
                child: Text(
                  '${title.toString()}',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 16.0, fontFamily: 'iran_yekan', color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                    color: themeColor
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)
                ),
                color: Colors.white,
              ),
              child: Center(
                  child: Marquee(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      child: Container(
                        child: Text(
                          ((text == null)||(text == ''))
                              ? '-'
                              : '${text.toString()}',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontSize: 14.0, fontFamily: 'iran_yekan', color: themeColor),
                        ),
                      ),
                    ),
                    direction: Axis.horizontal,
                    textDirection: TextDirection.rtl,
                    animationDuration: Duration(seconds: 30),
                    backDuration: Duration(milliseconds: 1000),
                    pauseDuration: Duration(milliseconds: 1000),
                    directionMarguee: DirectionMarguee.TwoDirection,
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
