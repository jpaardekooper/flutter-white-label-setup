import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataMessage extends StatelessWidget {
  const NoDataMessage({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
