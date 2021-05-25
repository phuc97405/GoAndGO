import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:goandgo/Presentation/Home/SearchAdress/search_adress_controller.dart';
import 'package:goandgo/Presentation/constants.dart';
import 'package:goandgo/components/primary_button.dart';

class SearchAdress extends GetView<SearchAdressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Ban muon di dau?',
          style: TextStyle(fontSize: kDefaultPadding),
          textAlign: TextAlign.center,
        )),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
                padding: EdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                          decoration: InputDecoration(
                        hintText: 'Vị trí của bạn',
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.share_location_outlined,
                          color: Colors.black26,
                          size: kDefaultPadding + 10,
                        ),
                      )),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Điểm đến',
                              icon: Icon(
                                Icons.not_listed_location_sharp,
                                color: Colors.red,
                                size: kDefaultPadding + 10,
                              ),
                            ))),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(
                          kDefaultPadding,
                        ),
                        child: Text('List'),
                      ),
                    ),
                    PrimaryButton(
                        text: 'Submit',
                        press: () {
                          print('submit');
                        }),
                  ],
                ))));
  }
}
