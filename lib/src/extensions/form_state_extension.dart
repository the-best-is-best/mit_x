import 'package:flutter/material.dart';

extension ExtensionFormState on GlobalKey<FormState> {
  void save() {
    currentState?.save();
  }

  bool isValid() {
    FocusManager.instance.primaryFocus?.unfocus();
    return currentState?.validate() ?? false;
  }
}
