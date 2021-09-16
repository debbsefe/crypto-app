import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenericTextFormField extends StatelessWidget {
  const GenericTextFormField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      onChanged: onChanged,
      decoration: kInputDecoration,
    );
  }
}

final kInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
);
