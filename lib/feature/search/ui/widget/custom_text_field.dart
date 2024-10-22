import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/search_cubit.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.title, required this.prefixIcon});
  final String title;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    var search = TextEditingController();
    return TextFormField(
      onChanged: (val) {
        context.read<SearchCubit>().onCheckSearch(val);
      },
      onFieldSubmitted: (val) {
        context.read<SearchCubit>().emitSearch(text: val);
      },
      controller: search,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: IconButton(
            color: Colors.white,
            onPressed: () {
              context.read<SearchCubit>().emitSearch(text: search.text);
            },
            icon: Icon(prefixIcon)),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        filled: true,
        fillColor: const Color.fromARGB(255, 50, 46, 46),
      ),
      textInputAction:
          TextInputAction.done, // Adds a "Done" button on the keyboard
    );
  }
}
