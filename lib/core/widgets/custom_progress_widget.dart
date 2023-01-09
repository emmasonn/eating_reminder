import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProgressWidget {
  //Loading Icons
  static Widget threeDots({Color? color}) {
    return Container(
      width: 80.0,
      child: SpinKitThreeBounce(
        size: 30.0,
        itemBuilder: (context, index) {
          return Align(
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: color != null ? color : Colors.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          );
        },
      ),
    );
  }

  //Loading Icons
  static Widget loadingHeart({Color? color}) {
    return Container(
      width: 80.0,
      child: SpinKitPumpingHeart(
        size: 30.0,
        color: color,
      ),
    );
  }

  //curpertino loading
  static Widget cupertinoLoading({
    Color? color,
    String? message,
  }) {
    return Column(
      mainAxisAlignment: cupertino.MainAxisAlignment.center,
      crossAxisAlignment: cupertino.CrossAxisAlignment.center,
      children: [
        cupertino.CupertinoActivityIndicator(
          animating: true,
          color: color ?? Colors.grey,
        ),
        const SizedBox(height: 10.0),
        if (message != null) ...[
          Text(
            message,
            style: GoogleFonts.montserrat(
              color: color ?? Colors.grey,
              fontSize: 12.0,
              decoration: TextDecoration.none,
            ),
          ),
        ]
      ],
    );
  }
}
