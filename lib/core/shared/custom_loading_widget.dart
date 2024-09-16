import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

customLoading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SpinKitWaveSpinner(
        waveColor: Colors.blue,
        trackColor: Colors.blue,
        color: Colors.white,
        size: 70.h,
      ),
    ),
  );
}