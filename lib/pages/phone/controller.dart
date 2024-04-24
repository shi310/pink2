import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/pages/phone/library.dart';

class PhoneController extends GetxController {
  final state = PhoneState();

  final inputController = TextEditingController();
  final inputFocusNode = FocusNode();
  @override
  void onReady() async {
    super.onReady();
    await MyTimer.futureMill(300);
    inputFocusNode.requestFocus();
    // nameController.addListener(() {});
  }
}
