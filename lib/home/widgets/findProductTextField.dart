import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';

class FindProductTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onRightIconPressed;

  const FindProductTextField({
    Key? key,
    required this.controller,
    required this.onRightIconPressed,
  }) : super(key: key);

  @override
  _FindProductTextFieldState createState() => _FindProductTextFieldState();
}

class _FindProductTextFieldState extends State<FindProductTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Add listener to detect focus changes
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print("TextField is focused");
        BlocProvider.of<CategoriesReseachBLoc>(context)
            .GetVertialCategoriess(CategoriesReseachTrigerState());
      }
      /* else {
        print("TextField lost focus");
        BlocProvider.of<CategoriesReseachBLoc>(context).CloseResearchList();
      }*/
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose FocusNode to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode, // Attach focus node
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(30, 255, 255, 255),
        hintText: "Enter text...",
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(
          Icons.search,
          color: Color.fromARGB(86, 158, 158, 158),
        ),
        suffixIcon: IconButton(
          onPressed: widget.onRightIconPressed,
          icon: const Icon(
            BootstrapIcons.sliders,
            color: Colors.grey,
            size: 25,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
