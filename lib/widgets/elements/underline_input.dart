// ignore_for_file: library_private_types_in_public_api

import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/commons/custom_icons.dart';
import 'package:flutter/material.dart';

class UnderlineInput extends StatefulWidget {
  UnderlineInput({
    Key? key,
    this.controller,
    this.enabled = true,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.labelText = '',
    this.helperText = '',
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    this.maxLength = 64,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool enabled;
  final bool isRequired;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final String helperText;
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
  _UnderlineInputState createState() => _UnderlineInputState();
}

class _UnderlineInputState extends State<UnderlineInput> {
  FocusNode _focusNode = FocusNode();

  static const hintStyle = TextStyle(
    fontSize: 14.0,
    height: 0.8,
    color: Consts.textGreyColor,
    fontWeight: FontWeight.w500,
  );

  static const underlineStyle = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Consts.greyColor,
    ),
  );

  static final focusedStyle = underlineStyle.copyWith(
    borderSide: BorderSide(
      color: Consts.primaryColor,
    ),
  );

  bool _isPassword = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    _focusNode.addListener(_onFocusChanged);

    _isPassword = widget.keyboardType == TextInputType.visiblePassword;
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

  Widget _passwordSuffix() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
      child: Icon(_passwordVisible ? CustomIcons.eyeon : CustomIcons.eyeoff),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    var inputStyle = textTheme.titleLarge?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        )
        .merge(widget.style);

    if (_isPassword && !_passwordVisible) {
      inputStyle = inputStyle?.copyWith(fontSize: 24.0, height: 1.0);
    }

    return TextFormField(
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: _focusNode.hasFocus
          ? inputStyle?.copyWith(color: Consts.primaryColor)
          : inputStyle,
      cursorColor: Consts.primaryColor,
      obscureText: _isPassword && !_passwordVisible,
      decoration: InputDecoration(
        isDense: false,
        focusColor: Consts.primaryColor,
        border: underlineStyle,
        focusedBorder: focusedStyle,
        enabledBorder: underlineStyle,
        disabledBorder: underlineStyle,
        prefixIconConstraints: BoxConstraints(minWidth: 0.0),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: _isPassword
              ? Icon(CustomIcons.lock)
              : (widget.prefixIcon != null ? Icon(widget.prefixIcon) : null),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 0.0),
        suffixIcon: _isPassword
            ? _passwordSuffix()
            : Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:
                    widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
              ),
        filled: false,
        counterText: "",
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        helperText: widget.validator != null
            ? (widget.helperText)
            : widget.helperText,
      ),
    );
  }
}
