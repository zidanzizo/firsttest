import 'dart:convert';

import 'package:firsttest/app/data/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Results> data = [];
  List<Results> dataSearch = [];
  var searchData = ''.obs;
  var recentSeacrh = List<String>.empty().obs;
  TextEditingController textEditingController = TextEditingController();
  var recent = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<Results>?> getFriends() async {
    print('getUserWorking');
    Uri uri = Uri.parse('https://randomuser.me/api/?results=30');
    var response = await http.get(uri);
    List map = (jsonDecode(response.body) as Map<String, dynamic>)['results'];
    data = map.map((e) => Results.fromJson(e)).toList();
    return data;
  }
}
