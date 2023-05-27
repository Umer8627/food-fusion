import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_fusion/models/user_model.dart';
import 'package:food_fusion/repos/shop_repo.dart';

class ShopState extends ChangeNotifier {
  List<UserModel> _shopList = [];

  List<UserModel> get shopList => _shopList;

  setShopList({required int value, required UserModel userModel}) async {
    _shopList = await ShopRepo.instance.getAllShops(userModel, value);
    log(_shopList.length.toString());
    notifyListeners();
  }
}
