import 'package:myapp/categories/data/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/categories/data/sub_categories_model.dart';

class CategoriesRepo {
  static const String baseUrl_getCategories =
      "http://127.0.0.1:8000/api/main-categories/";
  static const String baseUrl_getSubCategories =
      "http://127.0.0.1:8000/api/subcategories/";

  Future<List<CategoriesModel>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl_getCategories));
    print(response.body);

    if (response.statusCode == 200) {
      return CategoriesModel.fromJsonList(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<SubCategoriesModel>> getSubCategories(id) async {
    print(id);
    final response =
        await http.get(Uri.parse(baseUrl_getSubCategories + '${id}' + '/'));
    print('Sub ${response.body}');

    if (response.statusCode == 200) {
      return SubCategoriesModel.fromJsonList(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }
}
