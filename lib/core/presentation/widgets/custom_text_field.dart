import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final GlobalKey<FormFieldState> formFieldKey;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final Function validator;
  final bool obscureText;
  final double fontSize;
  final bool enable;
  final bool readOnly;
  final int? maxLength;
  final String? suffixText;

  final String? errorText;
  final TextInputAction textInputAction;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.formFieldKey,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.fontSize = 16,
    this.obscureText = false,
    this.errorText,
    this.enable = true,
    this.readOnly = false,
    this.suffixText,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        key: formFieldKey,
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        autofocus: false,
        maxLength: maxLength,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize + 2,
          ),
          hintText: hintText,
          suffixText: suffixText,
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: fontSize,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 0.6)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 0.8)),
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
            fontSize: 12.0,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.only(bottom: 8),
          alignLabelWithHint: true,
          errorMaxLines: 3,
          errorText: errorText,
          enabled: enable,
        ),
        cursorColor: Theme.of(context).primaryColor,
        readOnly: readOnly,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline2!.color,
          fontSize: fontSize,
        ),
        validator: (value) => validator(value),
          textInputAction: textInputAction,
        onChanged: (value) {
            formFieldKey.currentState!.validate();
        },
      ),
    );
  }
}
