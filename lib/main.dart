import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/views/SingleCategorisPage.dart';
import 'package:myapp/home/views/NavHolder.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/data/product_repo.dart';
import 'package:myapp/theme.dart';
import 'package:myapp/theme/blocs/theme_bloc.dart';
import 'package:myapp/theme/blocs/theme_state.dart';
import 'package:myapp/user/blocs/auth_bloc.dart';
import 'package:myapp/user/blocs/auth_state_bloc.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/data/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configure system UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

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
      child: BlocProvider(
        create: (context) => ThemeBloc(prefs: prefs),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme.copyWith(
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
              ),
              darkTheme: AppTheme.darkTheme.copyWith(
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
              ),
              themeMode: state.themeMode,
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
                          create: (context) =>
                              UserBLoc(context.read<UserRepo>()),
                        ),
                        BlocProvider<CategoriesReseachBLoc>(
                          create: (context) => CategoriesReseachBLoc(
                              context.read<CategoriesRepo>()),
                        ),
                        BlocProvider<AuthStateBloc>(
                          create: (context) => AuthStateBloc(
                            userRepo: context.read<UserRepo>(),
                          )..add(CheckAuthState()),
                        ),
                        BlocProvider<AuthBloc>(
                          create: (context) => AuthBloc(
                            context.read<UserRepo>(),
                            context.read<AuthStateBloc>(),
                          ),
                        ),
                      ],
                      child: NaveHolderPageView(),
                    ),
              },
            );
          },
        ),
      ),
    );
  }
}
