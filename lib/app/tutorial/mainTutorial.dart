import 'package:adote_um_amigo/app/tutorial/step_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Step App',
      home: StepForm(),
    );
  }
}
