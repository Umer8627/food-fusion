import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_fusion/components/dialog_widget.dart';
import 'package:food_fusion/states/register_state.dart';
import 'package:food_fusion/utills/snippets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectImageWidget extends StatelessWidget {
  const SelectImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterState userState = Provider.of<RegisterState>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        userState.selectImage == null
            ? const CircleAvatar(
                radius: 58,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              )
            : CircleAvatar(
                backgroundImage: FileImage(userState.selectImage!),
                radius: 58,
              ),
        Positioned(
          bottom: -5,
          right: -5,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Card(
              shape: getRoundShape(),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  showDialogOf(context, ImageDialogWidget(
                    onClick: (ref) async {
                      Navigator.of(context).pop();
                      if (ref.toString().contains("camera")) {
                        File? uploadImage = await pickImage(ImageSource.camera);
                        userState.selectImageFile(uploadImage);
                      } else {
                        File? uploadImage =
                            await pickImage(ImageSource.gallery);
                        userState.selectImageFile(uploadImage);
                      }
                    },
                  ));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
