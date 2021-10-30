import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message + ' worden ingeladen'),
          SizedBox(
            height: 20,
          ),
          Platform.isAndroid
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                )
              : CupertinoActivityIndicator()
        ],
      ),
    );
  }
}
