import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/home/widgets/findProductTextField.dart';

class ResearchList extends StatefulWidget {
  const ResearchList({super.key});

  @override
  State<ResearchList> createState() => _ResearchListState();
}

class _ResearchListState extends State<ResearchList> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(); // Initialize controller
    /*   BlocProvider.of<CategoriesReseachBLoc>(context)
        .GetVertialCategoriess(CategoriesReseachTrigerState());*/
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;
    return BlocBuilder<CategoriesReseachBLoc, CategoriesReseachState>(
        builder: (context, state) {
      if (state is CategoriesReseachLoadingState) {
        return Positioned(
            top: 0,
            child: Container(
              color: const Color.fromARGB(179, 0, 0, 0),
              width: screenWeight,
              height: screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: CircularProgressIndicator(), // Default loading spinner
              ),
            ));
      }
      if (state is CategoriesReseachLoadedState) {
        List<CategoriesModel> listCategories = state.Categories_List;

        return Positioned(
            top: 0,
            child: Container(
              color: const Color.fromARGB(230, 0, 0, 0),
              width: screenWeight,
              height: screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                  children: listCategories.map((category) {
                return ListTile(
                  leading: Icon(BootstrapIcons.airplane, color: Colors.white),
                  title: Text(category.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(category.subtitle,
                      style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
                  onTap: () {
                    // Handle button click
                  },
                );
              }).toList()),
            ));
      }
      return SizedBox();
    });
  }
}
