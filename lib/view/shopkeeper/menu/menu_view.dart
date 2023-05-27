import 'package:flutter/material.dart';
import 'package:food_fusion/utills/snippets.dart';
import 'package:food_fusion/view/shopkeeper/menu/add_item_popup.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('Menu View'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(context, const AddItemPopup());
          },
          child: const Icon(Icons.add),
        ));
  }
}
