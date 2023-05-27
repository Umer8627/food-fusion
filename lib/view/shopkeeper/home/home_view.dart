import 'package:flutter/material.dart';

import '../../../constants/color_constant.dart';
import '../../../utills/snippets.dart';

class ShopHomeview extends StatefulWidget {
  const ShopHomeview({super.key});

  @override
  State<ShopHomeview> createState() => _ShopHomeviewState();
}

class _ShopHomeviewState extends State<ShopHomeview>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                // margin: EdgeInsets.zero,
                shape: getRoundShape(val: 10),
                child: TabBar(
                  controller: tabController,
                  labelPadding: const EdgeInsets.all(0),
                  labelColor: Colors.white,
                  onTap: (val) => setState(() {}),
                  indicatorColor: secondaryColor,
                  splashBorderRadius: getRoundBorder(val: 10),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: getRoundBorder(val: 10),
                      color: secondaryColor),
                  tabs: const [
                    Tab(
                        child: Text(
                      'Accepted',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    Tab(
                        child: Text(
                      'In-Making',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    Tab(
                        child: Text(
                      'Picked',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    Tab(
                        child: Text(
                      'Arrived',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
