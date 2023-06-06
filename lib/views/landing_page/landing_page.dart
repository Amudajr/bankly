import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bankly/utils/theme.dart';
import 'package:bankly/views/transaction_page/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .45,
          ),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Bankly',
                  textStyle: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    fontWeight: FontWeight.w700,
                    color: PRIMARY,
                  ),
                  speed: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              pause: const Duration(milliseconds: 100),
              stopPauseOnTap: true,
              onTap: () => Get.offAll(const TransactionPage()),
              onFinished: () => Get.offAll(const TransactionPage()),
            ),
          )
        ],
      ),
    );
  }
}
