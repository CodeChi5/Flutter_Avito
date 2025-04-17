import 'package:flutter/material.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/views/SingleCategorisPage.dart';

class CategoriesCard extends StatelessWidget {
  final CategoriesModel category; // Accepts CategoriesModel as a parameter

  const CategoriesCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SingleCategorisPage.withProviders(
                    context,
                    mainCategoryId: category.id,
                  )),
        )
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: 150, // Adjust width as needed
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
                category.name,
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
                  'http://192.168.84.57:8000/${category.imageUrl}', // Replace with actual image path
                  scale: 1,
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
