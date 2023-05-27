import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_fusion/constants/color_constant.dart';
import 'package:food_fusion/view/shopkeeper/screens/menu_screen.dart';
import 'package:food_fusion/view/shopkeeper/screens/orders_screen.dart';
import 'package:food_fusion/view/shopkeeper/screens/profile_screen.dart';
import 'package:food_fusion/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../repos/user_repo.dart';
import '../../../states/user_state.dart';

class ShopKeeperDashboard extends StatefulWidget {
  const ShopKeeperDashboard({super.key});

  @override
  State<ShopKeeperDashboard> createState() => _ShopKeeperDashboardState();
}

class _ShopKeeperDashboardState extends State<ShopKeeperDashboard> {
  int pageIndex = 0;
  File? uploadImage;
  @override
  void initState() {
    super.initState();
    _getUserInfo(context: context);
  }

  _getUserInfo({required BuildContext context}) async {
    final userProvider = Provider.of<UserState>(context, listen: false);
    UserModel? user = await UserRepo.instance
        .getUserDetail(FirebaseAuth.instance.currentUser!.uid);
    if (user != null) {
      userProvider.setUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const OrderScreen(),
      const MenuScreen(),
      const EditProfileView()
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
          showLeading: false, title: context.watch<UserState>().userModel.name),
      body: pages.elementAt(pageIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          currentIndex: pageIndex,
          unselectedFontSize: 13,
          selectedFontSize: 13,
          onTap: (index) {
            if (mounted) {
              setState(() {
                pageIndex = index;
              });
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/order.png',
                    color: secondaryColor),
                label: 'Orders'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.file), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
