import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/common/global/library.dart';
import 'package:pinker/common/utils/library.dart';
import 'package:pinker/pages/area_code/library.dart';

class AreaCodeController extends GetxController {
  final state = AreaCodeState();
  final searchController = TextEditingController();
  final searchNode = FocusNode();

  final codeList = ConfigController.to.areaCodeList.areaCodeList;

  @override
  void onReady() async {
    super.onReady();

    state.showList.clear();
    state.showList.addAll(codeList);

    searchController.addListener(() {
      state.searchValue = searchController.text;
      if (state.searchValue.isEmpty) {
        state.showList.addAll(codeList);
      }
    });

    debounce(
      state.searchRx,
      (String value) {
        if (value.isNotEmpty) {
          state.showList.clear();
          for (int i = 0; i < codeList.length; i++) {
            if (MyCheck.isInclude(codeList[i].chineseName, value) ||
                MyCheck.isInclude(codeList[i].countryCode, value) ||
                MyCheck.isInclude(codeList[i].phoneCode, value) ||
                MyCheck.isInclude(codeList[i].tradName, value) ||
                MyCheck.isInclude(
                    codeList[i].englishName, value.toUpperCase()) ||
                MyCheck.isInclude(
                    codeList[i].chinesePinyin, value.toUpperCase())) {
              state.showList.add(codeList[i]);
            }
          }
        }
      },
      time: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();
    super.dispose();
  }
}
