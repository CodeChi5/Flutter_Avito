import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/home/widgets/persistent_nav_bar.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';

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
    //BlocProvider.of<ProductBLoc>(context).GetProducts(ProductTrigerState());
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
