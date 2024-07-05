import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/commons/custom_icons.dart';

class SquareCheckBox extends StatelessWidget {
  const SquareCheckBox({
    Key? key,
    this.enabled = true,
    this.checked = false,
    this.onTap,
  }) : super(key: key);

  final bool enabled;
  final bool checked;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 24.0,
        height: 24.0,
        alignment: Alignment.topLeft,
        child: Icon(
          checked ? CustomIcons.squarecheck : CustomIcons.square,
          color:
              !enabled || !checked ? Consts.textGreyColor : Consts.greenColor,
          size: checked ? 24.0 : 22.0,
        ),
      ),
    );
  }
}
