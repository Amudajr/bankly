// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bankly/utils/sizedboxx.dart';
import 'package:bankly/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomTabTile extends StatelessWidget {
  const CustomTabTile({
    Key? key,
    this.isActive = false,
    required this.text,
    required this.color,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            color: color,
          ),
        ),
        15.ph,
        Stack(
          children: [
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: GREY,
            ),
            isActive
                ? Center(
                    child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * .15,
                      color: PRIMARY,
                    ),
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }
}

class CustomTabItem {
  CustomTabItem({
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;
}
