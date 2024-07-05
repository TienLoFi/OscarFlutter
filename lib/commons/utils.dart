import 'package:oscar_ballot/routes.dart';
import 'package:oscar_ballot/commons/custom_icons.dart';
import 'package:oscar_ballot/widgets/elements/button.dart';
import 'package:oscar_ballot/widgets/elements/dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

double indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation!.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();

  // The controller's offset is changing because the user is dragging the
  // TabBarView's PageView to the left or right.
  if (!controller.indexIsChanging) {
    return (currentIndex - controllerValue).abs().clamp(0.0, 1.0);
  }

  // The TabController animation's value is changing from previousIndex to currentIndex.
  return (controllerValue - currentIndex).abs() /
      (currentIndex - previousIndex).abs();
}

Future<XFile?> pickPhoto(BuildContext context) async {
  final source = await showDialog<ImageSource>(
    context: context,
    builder: (context) =>
        AppDialog(
          title: "Select image source",
          content:
              "Capture an image from Camera or select an existing one from Gallery.",
          actions: [
            Button(
              title: "Camera",
              icon: Icons.camera_alt,
              width: 115.0,
              action: () {
                Routes.fluro.pop(navigatorKey.currentContext!);
              },
            ),
            Button(
              title: "Gallery",
              icon: CustomIcons.gallery,
              width: 115.0,
              action: () {
                Routes.fluro.pop(navigatorKey.currentContext!);
              },
            ),
          ],
        ) 
  );

  return ImagePicker().pickImage(source: source!);
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
