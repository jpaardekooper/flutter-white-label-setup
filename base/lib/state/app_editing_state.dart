import 'package:flutter/material.dart';

class AppEditingState with ChangeNotifier {
  bool edit = false;

  bool get EditStatus => edit;

  void toggleEdit() {
    edit = !edit;

    notifyListeners();
  }

  void toggleEditToFalse() {
    edit = false;
    notifyListeners();
  }
}
