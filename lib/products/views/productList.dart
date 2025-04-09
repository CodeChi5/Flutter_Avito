import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/views/widgets/categorisList.dart';
import 'package:myapp/products/data/product_model.dart';
import 'package:myapp/categories/views/widgets/categorisCard.dart';
import 'package:myapp/home/widgets/findProductTextField.dart';
import 'package:myapp/products/views/productPage.dart';
import 'package:myapp/products/views/widgets/productCard.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/product_bloc.dart';
import '../blocs/product_state.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  // late List<Product> _products;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBLoc>(context).GetProducts(ProductTrigerState());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeight = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          BlocBuilder<ProductBLoc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Row(
                          children: [
                            for (int i = 0; i < 2; i++)
                              Shimmer.fromColors(
                                baseColor: const Color.fromARGB(27, 30, 30, 30),
                                highlightColor: Theme.of(context).primaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: screenWeight *
                                      .40, // Adjust width as needed
                                  height: screenHeight *
                                      0.3, // Adjust height as needed
                                  margin: const EdgeInsets.all(
                                      5), // Simplified margin syntax
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                );
              } else if (state is ProductLoadedState) {
                return GridView.builder(
                  shrinkWrap: true, // Allows GridView to wrap content
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables GridView's internal scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.Product_List.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel product = state.Product_List[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    images: product.imageUrl,
                                    price: '${product.price}',
                                    title: product.name,
                                  )),
                        );
                        print("testt");
                      },
                      child: ProductCard(
                        product: product,
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
