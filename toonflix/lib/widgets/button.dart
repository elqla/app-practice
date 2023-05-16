import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        // 원래 const structure Padding 이였는데, text가 상수가 아니기 때문에,
        // button을 초기화해줄때 전송한 text 값에 따라 달라지기 때문에 더이상 상수가 아님
        padding: const EdgeInsets.symmetric(
          // 대신 여기에 const 작성
          vertical: 15,
          horizontal: 40,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
