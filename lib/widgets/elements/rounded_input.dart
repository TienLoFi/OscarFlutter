import 'package:oscar_ballot/consts.dart';
import 'package:flutter/material.dart';

class RoundedInput extends StatefulWidget {
  RoundedInput({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.enabled = true,
    this.isRequired = false,
    this.hintText = '',
    this.labelText = '',
    this.helperText = '',
    this.counterText = '',
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    this.maxLength = 0,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool isRequired;
  final String hintText;
  final String labelText;
  final String helperText;
  final String counterText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final String Function(String)? validator;
  final int maxLength;
  final int maxLines;
  final int minLines;

  @override
  // ignore: library_private_types_in_public_api
  _RoundedInputState createState() => _RoundedInputState();
}

class _RoundedInputState extends State<RoundedInput> {
  FocusNode _focusNode = FocusNode();

  static const hintStyle = TextStyle(
    fontSize: 14.0,
    height: 0.8,
    color: Consts.textGreyColor,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    _focusNode.addListener(_onFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    var inputStyle = textTheme.titleLarge!
        .copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        )
        .merge(widget.style);

    final outlineStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Consts.greyColor,
      ),
      borderRadius: BorderRadius.circular(12.0),
    );

    final focusedStyle = outlineStyle.copyWith(
      borderSide: BorderSide(
        color: Consts.primaryColor,
      ),
    );

    return TextFormField(
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: _focusNode,
      autofocus: false,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: _focusNode.hasFocus
          ? inputStyle.copyWith(color: Consts.primaryColor)
          : inputStyle,
      cursorColor: Consts.primaryColor,
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        isDense: false,
        focusColor: Consts.primaryColor,
        border: outlineStyle,
        focusedBorder: focusedStyle,
        enabledBorder: outlineStyle,
        disabledBorder: outlineStyle,
        prefixIconConstraints: BoxConstraints(minWidth: 0.0),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 12.0, bottom: 2.0),
                child: Icon(
                  widget.prefixIcon,
                  size: 16.0,
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(minWidth: 0.0),
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(widget.suffixIcon),
              )
            : null,
        filled: false,
        counterText: widget.counterText,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        helperText: widget.validator != null
            ? (widget.helperText)
            : widget.helperText,
      )
    );
  }
}
