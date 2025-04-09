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

class NaveHolderPageView extends StatefulWidget {
  const NaveHolderPageView({super.key});

  @override
  State<NaveHolderPageView> createState() => _NaveHolderPageViewState();
}

class _NaveHolderPageViewState extends State<NaveHolderPageView> {
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

    return Scaffold(
      body: PersistentNavBar(context: context).build(),
    );
  }
}
