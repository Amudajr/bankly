//MediaQuery Width

// ignore_for_file: must_be_immutable, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'theme.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget primaryButton(
        {onClick,
        color,
        text,
        textColor = WHITE,
        context,
        hPadding,
        vPadding,
        myKey,
        hasIcon = false,
        iconColor,
        icon,
        fontSize,
        width}) =>
    InkWell(
      key: Key(myKey ?? ''),
      onTap: onClick,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color ?? PRIMARY,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: hPadding ?? 10.0, vertical: vPadding ?? 17.0),
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasIcon)
                Icon(
                  icon ?? Icons.arrow_drop_down,
                  color: iconColor ?? Colors.white,
                ),
              if (hasIcon) const SizedBox(width: 5),
              Text(
                text ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          )),
        ),
      ),
    );

outlineButton(
        {onClick,
        text,
        context,
        color,
        textColor,
        vPadding,
        hPadding,
        fontSize}) =>
    InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color ?? PRIMARY, width: 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: hPadding ?? 10.0, vertical: vPadding ?? 17.0),
          child: Center(
              child: Text(
            text ?? '',
            style: TextStyle(color: textColor ?? PRIMARY, fontSize: fontSize),
          )),
        ),
      ),
    );

primaryTextButton({onClick, text, color, fontSize}) {
  return TextButton(
    onPressed: onClick,
    child: Text(
      text ?? '',
      style: TextStyle(
        color: color ?? PRIMARY,
        fontSize: fontSize ?? 14.0,
      ),
    ),
  );
}

bubbleSplash() {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: [
      Container(
        width: 650,
        height: 700,
        decoration: BoxDecoration(
          border: Border.all(
            color: WHITE,
            width: 20,
          ),
          shape: BoxShape.circle,
        ),
      ),
      Container(
        width: 550,
        height: 600,
        decoration: BoxDecoration(
          border: Border.all(color: WHITE, width: 20),
          shape: BoxShape.circle,
        ),
      ),
      Container(
        width: 450,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(color: WHITE, width: 20),
          shape: BoxShape.circle,
        ),
      ),
    ],
  );
}

Widget defaultAppBar(text, {goBack, onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      backButton(goBack: goBack),
      Text(
        text,
        style: const TextStyle(
            fontSize: 25, letterSpacing: 0.7, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      const SizedBox(width: 35),
      if (onTap != null)
        InkWell(
          onTap: onTap,
          child: const Icon(Icons.menu_sharp),
        )
    ],
  );
}

Widget backButton({goBack}) {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: const Padding(
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.arrow_back_ios,
        color: BLACK,
        size: 20,
      ),
    ),
  );
}

class Dialogs {
  static showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.error_outlined,
        color: WHITE,
      ),
      borderRadius: 15,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: ACCENT_RED.withOpacity(0.5),
      colorText: WHITE,
      duration: const Duration(seconds: 5),
    );
  }

  static showSuccessSnackBar(String title, String message) {
    Get.snackbar(title, message,
        duration: const Duration(seconds: 5),
        icon: const Icon(
          Icons.check_circle,
          color: WHITE,
        ),
        borderRadius: 15,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: GREEN.withOpacity(0.5),
        colorText: WHITE);
  }

  static showNoticeSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      borderRadius: 15,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: WHITE.withOpacity(0.5),
      colorText: PRIMARY,
    );
  }
}

// Future<void> showSendingData(context, {text}) async {
//   return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return const CustomLoader(
//           color: PRIMARY,
//         );
//       });
// }

class SpinKitPumpingHeart extends StatefulWidget {
  Duration duration = const Duration(milliseconds: 2400);

  SpinKitPumpingHeart({Key? key}) : super(key: key);

  @override
  _SpinKitPumpingHeartState createState() => _SpinKitPumpingHeartState();
}

class _SpinKitPumpingHeartState extends State<SpinKitPumpingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = Tween(begin: 1.0, end: 1.25).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: SpinKitPumpCurve())));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: _itemBuilder(0));
  }

  Widget _itemBuilder(int index) =>
      // widget.itemBuilder != null
      // ? widget.itemBuilder(context, index)
      // :
      Image.asset('assets/images/app_icon_primary.png',
          color: PRIMARY, height: 45);
}

class SpinKitPumpCurve extends Curve {
  const SpinKitPumpCurve();

  static const magicNumber = 4.54545454;

  @override
  double transform(double t) {
    if (t >= 0.0 && t < 0.22) {
      return math.pow(t, 1.0) * magicNumber;
    } else if (t >= 0.22 && t < 0.44) {
      return 1.0 - (math.pow(t - 0.22, 1.0) * magicNumber);
    } else if (t >= 0.44 && t < 0.5) {
      return 0.0;
    } else if (t >= 0.5 && t < 0.72) {
      return math.pow(t - 0.5, 1.0) * (magicNumber / 2);
    } else if (t >= 0.72 && t < 0.94) {
      return 0.5 - (math.pow(t - 0.72, 1.0) * (magicNumber / 2));
    }
    return 0.0;
  }
}
