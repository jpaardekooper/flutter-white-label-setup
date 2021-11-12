import 'dart:convert';

import 'package:base/helper/shared_preference.dart';
import 'package:base/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:base/models/faq_item.dart';
import 'package:base/repository/controller/faq_controller.dart';
import 'package:http/http.dart';

class FAQState with ChangeNotifier {
  final LocalStorage localStorage;
  final AuthState authState;
  FAQState(this.localStorage, this.authState);

  final FaqController _faqController = FaqController();

  List<FAQItem> get faqList => _faqList;

  List<bool> get faqListStatus => _faqStatus;

  List<FAQItem> _faqList = [];

  List<bool> _faqStatus = [];

  Future<dynamic> fetchFAQData() async {
    try {
      if (await authState.refreshSession()) {
        Response response = await _faqController
            .fetchFaqData(authState.token.accessToken!.bearerToken!);

        if (response.statusCode == 200) {
          List<dynamic> parsed = json.decode(response.body) as List;
          _faqList = parsed.map((val) => FAQItem.fromJson(val)).toList();

          notifyListeners();
        }
      }
    } on Exception catch (_) {
      print(_);
    }
  }
}
