import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/views/widgets/categorisList.dart';
import 'package:myapp/home/widgets/homeTopBar.dart';
import 'package:myapp/home/widgets/persistent_nav_bar.dart';
import 'package:myapp/home/widgets/researchList.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';
import 'package:myapp/products/data/product_model.dart';
import 'package:myapp/categories/views/widgets/categorisCard.dart';
import 'package:myapp/home/widgets/findProductTextField.dart';
import 'package:myapp/products/views/productList.dart';
import 'package:myapp/products/views/widgets/productCard.dart';
import 'package:shimmer/shimmer.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: HomeTopBar(),
      ),
      body: RepositoryProvider<CategoriesRepo>(
        create: (context) => CategoriesRepo(),
        child: BlocProvider<CategoriesReseachBLoc>(
          create: (context) =>
              CategoriesReseachBLoc(context.read<CategoriesRepo>()),
          child: BlocListener<CategoriesReseachBLoc, CategoriesReseachState>(
            listener: (context, state) {
              print("lising$state");
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ResearchList(),
                  BlocBuilder<CategoriesReseachBLoc, CategoriesReseachState>(
                    builder: (context, state) {
                      if (state is CategoriesReseachLoadingState) {
                        return SizedBox();
                      }
                      if (state is CategoriesReseachLoadedState) {
                        List<CategoriesModel> listCategories =
                            state.Categories_List;
                        return SizedBox();
                      }
                      return Column(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: RepositoryProvider<CategoriesRepo>(
                              create: (context) => CategoriesRepo(),
                              child: BlocProvider<CategoriesBLoc>(
                                create: (context) => CategoriesBLoc(
                                    context.read<CategoriesRepo>()),
                                child: BlocListener<CategoriesBLoc,
                                    CategoriesState>(
                                  listener: (context, state) {},
                                  child: CategoriesListView(),
                                ),
                              ),
                            ),
                          ),
                          ProductListView()
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
