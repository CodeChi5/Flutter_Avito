import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/views/SingleCategorisPage.dart';
import 'package:myapp/home/views/NavHolder.dart';
import 'package:myapp/home/views/homePage.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';
import 'package:myapp/products/data/product_repo.dart';
import 'package:myapp/products/views/productList.dart';
import 'package:myapp/theme.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/data/user_repo.dart';
import 'package:myapp/user/views/RegisterPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepo>(
          create: (context) => ProductRepo(),
        ),
        RepositoryProvider<CategoriesRepo>(
          create: (context) => CategoriesRepo(),
        ),
        RepositoryProvider<UserRepo>(
          create: (context) => UserRepo(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme, // Light Theme
        darkTheme: AppTheme.darkTheme, // Dark Theme
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<ProductBLoc>(
                    create: (context) =>
                        ProductBLoc(context.read<ProductRepo>()),
                  ),
                  BlocProvider<SubCategoriesBLoc>(
                    create: (context) =>
                        SubCategoriesBLoc(context.read<CategoriesRepo>()),
                  ),
                  BlocProvider<CategoriesBLoc>(
                    create: (context) =>
                        CategoriesBLoc(context.read<CategoriesRepo>()),
                  ),
                  BlocProvider<UserBLoc>(
                    create: (context) => UserBLoc(context.read<UserRepo>()),
                  ),
                ],
                child: NaveHolderPageView(),
              ),
          '/singlecategorisPage': (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<ProductBLoc>(
                    create: (context) =>
                        ProductBLoc(context.read<ProductRepo>()),
                  ),
                  BlocProvider<SubCategoriesBLoc>(
                    create: (context) =>
                        SubCategoriesBLoc(context.read<CategoriesRepo>()),
                  ),
                  BlocProvider<CategoriesBLoc>(
                    create: (context) =>
                        CategoriesBLoc(context.read<CategoriesRepo>()),
                  ),
                  BlocProvider<UserBLoc>(
                    create: (context) => UserBLoc(context.read<UserRepo>()),
                  ),
                ],
                child: SingleCategorisPage(),
              ),
        },
      ),
    );
  }
}
