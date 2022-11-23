import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:movies/module/base/base.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(Base());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: SizedBox(
            width: 160,
            height: 104,
            child: Image.asset('assets/images/il_splash.png'),
          ),
        ),
      ),
    );
  }
}
