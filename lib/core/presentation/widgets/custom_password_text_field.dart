import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final GlobalKey<FormFieldState> formFieldKey;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final Function validator;
  final bool obscureText;
  final double fontSize;
  final TextInputAction textInputAction;
  const CustomPasswordTextField({
    Key? key,
    required this.textEditingController,
    required this.formFieldKey,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.fontSize = 16,
    this.obscureText = true,
  }) : super(key: key);

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        key: widget.formFieldKey,
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        autofocus: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: widget.fontSize + 2,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: widget.fontSize,
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
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon: obscureText
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          )
        ),
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline2!.color,
          fontSize: widget.fontSize,
        ),
        validator: (value) => widget.validator(value),
        textInputAction: widget.textInputAction,
        onChanged: (value) {
          widget.formFieldKey.currentState!.validate();
        },
      ),
    );
  }
  void _toggleVisibility(){
    setState(() {
      obscureText = !obscureText;
    });
  }

}
