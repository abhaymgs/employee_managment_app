import 'package:flutter/material.dart';

class OutlinedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const OutlinedInputField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.readOnly = false,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: textEditingController,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
