import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/views/widgets/CategorisCard.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  // late List<Categories> _Categoriess;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBLoc>(context)
        .GetCategoriess(CategoriesTrigerState());
/*
    BlocProvider.of<CategoriesReseachBLoc>(context)
        .GetVertialCategoriess(CategoriesReseachTrigerState());*/
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20),
            child: BlocBuilder<CategoriesBLoc, CategoriesState>(
                builder: (context, state) {
              if (state is CategoriesLoadingState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling

                  child: Row(
                    children: [
                      for (int i = 0; i < 5; i++) // Corrected condition
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(27, 30, 30, 30),
                          highlightColor: Theme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 150, // Adjust width as needed
                            height: 80, // Adjust height as needed
                            margin: const EdgeInsets.all(
                                5), // Simplified margin syntax
                          ),
                        ),
                    ],
                  ),
                );
              }
              if (state is CategoriesLoadedState) {
                List<CategoriesModel> listCategories = state.Categories_List;

                // Split the list into two halves
                int mid = (listCategories.length / 2).ceil();
                List<CategoriesModel> firstRow = listCategories.sublist(0, mid);
                List<CategoriesModel> secondRow = listCategories.sublist(mid);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: firstRow.map((category) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CategoriesCard(category: category),
                          );
                        }).toList(),
                      ),
                      Row(
                        children: secondRow.map((category) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CategoriesCard(category: category),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }
              return Text('test');
            })),
      ],
    );
  }
}
