import 'package:flutter/material.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/sub_categories_model.dart';
import 'package:myapp/categories/views/SingleCategorisPage.dart';

class SubCategoriesCard extends StatelessWidget {
  final SubCategoriesModel category; // Accepts CategoriesModel as a parameter

  const SubCategoriesCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: 190, // Adjust width as needed
        height: 80, // Adjust height as needed
        decoration: BoxDecoration(
          color: const Color.fromARGB(30, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 14, 0),
              child: Text(
                '${category.name}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.network(
                  'http://127.0.0.1:8000/${category.logoImg}', // Replace with actual image path
                  scale: 1.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
