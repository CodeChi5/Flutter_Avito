import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/home/widgets/findProductTextField.dart';

class HomeTopBar extends StatefulWidget {
  final bool CanComeBack; // New optional parameter

  const HomeTopBar({super.key, this.CanComeBack = false}); // Default: false

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(); // Initialize controller
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            widget.CanComeBack
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      BootstrapIcons.arrow_left,
                      color: Colors.grey,
                      size: 25,
                      weight: 800,
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: FindProductTextField(
                controller: controller,
                onRightIconPressed: () {
                  print("Search button clicked${controller.text}");
                },
              ),
            ),
            const SizedBox(width: 8),
            BlocBuilder<CategoriesReseachBLoc, CategoriesReseachState>(
                builder: (context, state) {
              if (state is CategoriesReseachLoadingState) {
                return TextButton(
                  onPressed: () => {
                    BlocProvider.of<CategoriesReseachBLoc>(context)
                        .CloseResearchList()
                  },
                  child: Text("Close",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                );
              }
              if (state is CategoriesReseachLoadedState) {
                List<CategoriesModel> listCategories = state.Categories_List;

                return TextButton(
                  onPressed: () => {
                    BlocProvider.of<CategoriesReseachBLoc>(context)
                        .CloseResearchList()
                  },
                  child: Text("Close",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                );
              }
              return IconButton(
                onPressed: () {
                  print("Cart icon clicked");
                },
                icon: const Icon(
                  BootstrapIcons.cart2,
                  color: Colors.grey,
                  size: 25,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
