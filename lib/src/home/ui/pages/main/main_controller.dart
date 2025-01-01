
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class MainController extends GetxController {

  int indexPage = defaultInt;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: defaultInt);
    super.onInit();
  }

  void onTapItem(int value){
    indexPage = value;
    pageController.jumpToPage(indexPage);
    update([pageIdGet]);
  }

}