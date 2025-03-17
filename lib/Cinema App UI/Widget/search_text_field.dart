import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String hintText;
  final TextEditingController controller;
  const SearchTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 19),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 35,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
