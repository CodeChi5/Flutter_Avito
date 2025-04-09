import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/sub_categories_model.dart';
import 'package:myapp/categories/views/widgets/CategorisCard.dart';
import 'package:myapp/categories/views/widgets/subcategorisCard.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesListView extends StatefulWidget {
  const SubCategoriesListView({super.key});

  @override
  State<SubCategoriesListView> createState() => _SubCategoriesListViewState();
}

class _SubCategoriesListViewState extends State<SubCategoriesListView> {
  // late List<Categories> _Categoriess;

  @override
  void initState() {
    BlocProvider.of<SubCategoriesBLoc>(context)
        .GetSubCategoriess(SubCategoriesTrigerState(id: '1'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20),
            child: BlocBuilder<SubCategoriesBLoc, SubCategoriesState>(
                builder: (context, state) {
              if (state is SubCategoriesLoadingState) {
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
              if (state is SubCategoriesLoadedState) {
                List<SubCategoriesModel> listCategories = state.Categories_List;

                // Split the list into two halves
                int mid = (listCategories.length / 2).ceil();
                List<SubCategoriesModel> firstRow =
                    listCategories.sublist(0, mid);
                List<SubCategoriesModel> secondRow =
                    listCategories.sublist(mid);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: firstRow.map((category) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SubCategoriesCard(category: category),
                          );
                        }).toList(),
                      ),
                      Row(
                        children: secondRow.map((category) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SubCategoriesCard(category: category),
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
