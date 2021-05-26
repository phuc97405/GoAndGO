import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:goandgo/components/constants.dart';
import 'package:get/get.dart';

class Welcome extends GetView<GetxController> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.fitWidth,
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                'Welcome to Go And Go App',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Go And Go help connect people',
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.64)),
              ),
              FittedBox(
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/auth');
                      },
                      child: Row(
                        children: [
                          Text(
                            'Skip ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.8)),
                          ),
                          SizedBox(
                            width: kDefaultPadding / 4,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8),
                          )
                        ],
                      ))),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
