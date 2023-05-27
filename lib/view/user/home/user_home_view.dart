import 'package:flutter/material.dart';
import 'package:food_fusion/constants/color_constant.dart';
import 'package:food_fusion/models/user_model.dart';
import 'package:food_fusion/repos/shop_repo.dart';
import 'package:food_fusion/states/user_state.dart';
import 'package:provider/provider.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  final radiusController = TextEditingController();
  int radius = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              TextField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black),
                controller: radiusController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: greyColor, fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: textFieldColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: textFieldColor),
                  ),
                  isDense: true,
                  filled: true,
                  hintText: 'Enter Radius',
                ),
                onSubmitted: (value) {
                  setState(() {
                    radius = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 10),
              StreamBuilder<List<UserModel>>(
                stream: ShopRepo.instance.getAllUsersByGeoPackage(
                    userModel: context.read<UserState>().userModel,
                    rad: radius),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());

                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data?[index].name ?? ''),
                              subtitle:
                                  Text(snapshot.data?[index].address ?? ''),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
