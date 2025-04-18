import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/views/widgets/categorisList.dart';
import 'package:myapp/categories/views/widgets/subcategorisList.dart';
import 'package:myapp/home/widgets/homeTopBar.dart';
import 'package:myapp/home/widgets/researchList.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';
import 'package:myapp/products/data/product_model.dart';
import 'package:myapp/categories/views/widgets/categorisCard.dart';
import 'package:myapp/home/widgets/findProductTextField.dart';
import 'package:myapp/products/data/product_repo.dart';
import 'package:myapp/products/views/productList.dart';
import 'package:myapp/products/views/widgets/productCard.dart';
import 'package:shimmer/shimmer.dart';

class SingleCategorisPage extends StatefulWidget {
  final int mainCategoryId;

  static Widget withProviders(BuildContext context,
      {required int mainCategoryId}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBLoc>(
          create: (context) => ProductBLoc(context.read<ProductRepo>()),
        ),
        BlocProvider<SubCategoriesBLoc>(
          create: (context) =>
              SubCategoriesBLoc(context.read<CategoriesRepo>()),
        ),
        BlocProvider<CategoriesBLoc>(
          create: (context) => CategoriesBLoc(context.read<CategoriesRepo>()),
        ),
      ],
      child: SingleCategorisPage(mainCategoryId: mainCategoryId),
    );
  }

  const SingleCategorisPage({super.key, required this.mainCategoryId});

  @override
  State<SingleCategorisPage> createState() => _SingleCategorisPageState();
}

class _SingleCategorisPageState extends State<SingleCategorisPage> {
  @override
  void initState() {
    super.initState();
    // Load products for the main category
    context
        .read<ProductBLoc>()
        .getProductsByMainCategory(widget.mainCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(57, 33, 158, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                RepositoryProvider<CategoriesRepo>(
                    create: (context) => CategoriesRepo(),
                    child: BlocProvider<CategoriesReseachBLoc>(
                      create: (context) =>
                          CategoriesReseachBLoc(context.read<CategoriesRepo>()),
                      child: BlocListener<CategoriesReseachBLoc,
                          CategoriesReseachState>(
                        listener: (context, state) {
                          print("lising$state");
                        },
                        child: HomeTopBar(CanComeBack: true),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: screenWeight * 0.5,
                            child: Text(
                              "Single Categoris Page",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            width: screenWeight * 0.5,
                            child: Text(
                              "Single Categoris Page",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 110,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.network(
                            'http://192.168.84.57:8000//media/main_images/Shoes_Sale__Flyer_-removebg-preview.png',
                            scale: 2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RepositoryProvider<CategoriesRepo>(
                    create: (context) => CategoriesRepo(),
                    child: BlocProvider<SubCategoriesBLoc>(
                      create: (context) =>
                          SubCategoriesBLoc(context.read<CategoriesRepo>()),
                      child:
                          BlocListener<SubCategoriesBLoc, SubCategoriesState>(
                        listener: (context, state) {},
                        child: SubCategoriesListView(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<ProductBLoc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return SliverPadding(
                padding: EdgeInsets.all(15),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Shimmer.fromColors(
                        baseColor: const Color.fromARGB(27, 30, 30, 30),
                        highlightColor: Theme.of(context).primaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                    childCount: 6,
                  ),
                ),
              );
            } else if (state is ProductLoadedState) {
              return SliverPadding(
                padding: EdgeInsets.all(15),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = state.Product_List[index];
                      return ProductCard(product: product);
                    },
                    childCount: state.Product_List.length,
                  ),
                ),
              );
            } else if (state is ProductErrorState) {
              return SliverFillRemaining(
                child: Center(
                  child: Text('Error: ${state.error}'),
                ),
              );
            }
            return SliverToBoxAdapter(child: SizedBox());
          },
        ),
      ],
    ));
  }
}
