import 'package:bpm/style/Colors.dart';
import 'package:flutter/material.dart';

class orderProductModel {
  var row;
  var serial;
  var productName;
  var unitNumber;
  var number;
  var unitWeight;
  var totalMassWeight;
  var totalWeightPrice;
  var unitLength;
  var totalCBM;
  var totalVolumetricWeight;
  var productNumberInBox;
  var productNumberInBoxValue;
  var totalValue;
  var HSCODE;
  var partNumber;
  var buyLink;
  var imageFile;
  var proformaInvoiceFile;
  var packingListFile;
  var attachedFile;
  var description;

  orderProductModel(
      {
        this.row,
        this.serial,
        this.productName,
        this.unitNumber,
        this.number,
        this.unitWeight,
        this.totalMassWeight,
        this.totalWeightPrice,
        this.unitLength,
        this.totalCBM,
        this.totalVolumetricWeight,
        this.productNumberInBox,
        this.productNumberInBoxValue,
        this.totalValue,
        this.HSCODE,
        this.partNumber,
        this.buyLink,
        this.imageFile,
        this.proformaInvoiceFile,
        this.packingListFile,
        this.attachedFile,
        this.description,
      });
}

List<orderProductModel> orderProductList = new List();

class checkOrderList extends StatefulWidget {
  @override
  _checkOrderListState createState() => _checkOrderListState();
}

class _checkOrderListState extends State<checkOrderList> {

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
          body: orderProductList.isEmpty
              ? Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'رکوردی برای نمایش نیست',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'iran_yekan',
                    fontSize: 16.0),
              ),
            ),
          )
              : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, indexSep){
                    return Container(
                      margin: EdgeInsets.only(
                          left: 30.0,
                          right: 30.0
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            height: 1.0,
                            color: themeColor,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: orderProductList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width / 3,

                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'ردیف',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          '${index + 1}',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'شناسه',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].serial == null
                                              ? '-'
                                              : '${orderProductList[index].serial}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'نام کالا',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].productName == null
                                              ? '-'
                                              : '${orderProductList[index].productName}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'واحد تعداد',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].unitNumber == null
                                              ? '-'
                                              : '${orderProductList[index].unitNumber}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'تعداد',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].number == null
                                              ? '-'
                                              : '${orderProductList[index].number}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'وزن واحد(kg)',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].unitWeight == null
                                              ? '-'
                                              : '${orderProductList[index].unitWeight}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'جمع وزن جرمی(kg)',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].totalMassWeight == null
                                              ? '-'
                                              : '${orderProductList[index].totalMassWeight}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'کل وزن قابل پرداخت',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].totalWeightPrice == null
                                              ? '-'
                                              : '${orderProductList[index].totalWeightPrice}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'طول واحد(cm)',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].unitLength == null
                                              ? '-'
                                              : '${orderProductList[index].unitLength}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'cbm کل',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].totalCBM == null
                                              ? '-'
                                              : '${orderProductList[index].totalCBM}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'جمع وزن حجمی',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].totalVolumetricWeight == null
                                              ? '-'
                                              : '${orderProductList[index].totalVolumetricWeight}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'تعداد کالا در هر جعبه',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].productNumberInBox == null
                                              ? '-'
                                              : '${orderProductList[index].productNumberInBox}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'ارزش واحد کالای در جعبه',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].productNumberInBox == null
                                              ? '-'
                                              : '${orderProductList[index].productNumberInBox}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'ارزش کل کالا(ها)',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].totalValue == null
                                              ? '-'
                                              : '${orderProductList[index].totalValue}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'HSCODE',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].HSCODE == null
                                              ? '-'
                                              : '${orderProductList[index].HSCODE}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'پارت نامبر',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].partNumber == null
                                              ? '-'
                                              : '${orderProductList[index].partNumber}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'لینک خرید',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].buyLink == null
                                              ? '-'
                                              : '${orderProductList[index].buyLink}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'تصویر',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].imageFile == null
                                              ? '-'
                                              : '${orderProductList[index].imageFile}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'فایل Proforma Invoice',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].proformaInvoiceFile == null
                                              ? '-'
                                              : '${orderProductList[index].proformaInvoiceFile}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'فایل Packing List',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].packingListFile == null
                                              ? '-'
                                              : '${orderProductList[index].packingListFile}',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'سایر فایل های پیوست',
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].attachedFile == null
                                              ? '-'
                                              : '${orderProductList[index].attachedFile}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),
                                Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'توضیحات',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: themeColor),
                                        ),
                                        Text(
                                          orderProductList[index].description == null
                                              ? '-'
                                              : '${orderProductList[index].description}',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'iran_yekan',
                                              fontSize: 16.0,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    )),


                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    height: 50.0,
                    width: 120.0,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: themeColor,
                    ),
                    child: Center(
                      child: Text(
                        'بازگشت',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'iran_yekan',
                            fontSize: 15.0),
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}