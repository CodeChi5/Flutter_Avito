import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/categories/blocs/categories_event.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/categories/data/sub_categories_model.dart';

class CategoriesBLoc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo repo;
  CategoriesBLoc(this.repo) : super(ProdcutcalmState()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoriesLoadingState());
    });
  }

  @override
  Future<List<CategoriesModel>> GetCategoriess(
      CategoriesTrigerState event) async {
    print("Im here Cat");
    emit(CategoriesLoadingState());
    List<CategoriesModel> listCategories = await repo.getCategories();

    emit(CategoriesLoadedState(Categories_List: listCategories));

    return listCategories;
  }
}

class CategoriesReseachBLoc
    extends Bloc<CategoriesEvent, CategoriesReseachState> {
  final CategoriesRepo repo;
  CategoriesReseachBLoc(this.repo) : super(CategoriesReseachcalmState()) {
    on<LoadCategoriesEvent>((event, emit) async {});
  }

  @override
  Future<List<CategoriesModel>> GetVertialCategoriess(
      CategoriesReseachTrigerState event) async {
    print("Im here bLOClist");
    emit(CategoriesReseachLoadingState());
    List<CategoriesModel> listCategories = await repo.getCategories();
    await Future.delayed(const Duration(seconds: 3));

    emit(CategoriesReseachLoadedState(Categories_List: listCategories));

    return listCategories;
  }

  @override
  Future CloseResearchList() async {
    emit(CategoriesReseachcalmState());

    return null;
  }
}

class SubCategoriesBLoc extends Bloc<CategoriesEvent, SubCategoriesState> {
  final CategoriesRepo repo;
  SubCategoriesBLoc(this.repo) : super(SubCategoriescalmState()) {
    on<LoadSubCategoriesEvent>((event, emit) async {
      emit(SubCategoriesLoadingState());
    });
  }

  @override
  Future<List<SubCategoriesModel>> GetSubCategoriess(
      SubCategoriesTrigerState event) async {
    print("Im id ${event.id}");
    emit(SubCategoriesLoadingState());
    List<SubCategoriesModel> listSubCategories =
        await repo.getSubCategories(event.id);
    print('list_sub $listSubCategories');
    emit(SubCategoriesLoadedState(Categories_List: listSubCategories));

    return listSubCategories;
  }
}
