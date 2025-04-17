import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/blocs/categories_state.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/sub_categories_model.dart';
import 'package:myapp/products/blocs/product_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';
import 'package:myapp/home/widgets/homeTopBar.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  int? _selectedMainCategoryId;
  int? _selectedSubCategoryId;
  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    // Load categories when the view is initialized
    context.read<CategoriesBLoc>().GetCategoriess(CategoriesTrigerState());
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  void _onMainCategorySelected(int? categoryId) {
    setState(() {
      _selectedMainCategoryId = categoryId;
      _selectedSubCategoryId =
          null; // Reset subcategory when main category changes
    });
    if (categoryId != null) {
      // Load subcategories for the selected main category
      context.read<SubCategoriesBLoc>().GetSubCategoriess(
            SubCategoriesTrigerState(id: categoryId.toString()),
          );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedMainCategoryId != null &&
        _selectedSubCategoryId != null &&
        _selectedImages.isNotEmpty) {
      context.read<ProductBLoc>().add(
            CreateProductEvent(
              title: _titleController.text,
              description: _descriptionController.text,
              price: _priceController.text,
              mainCategoryId: _selectedMainCategoryId!,
              subCategoryId: _selectedSubCategoryId!,
              images: _selectedImages,
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select at least one image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBLoc, ProductState>(
      listener: (context, state) {
        if (state is ProductCreatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully!')),
          );
          Navigator.pop(context);
        } else if (state is ProductErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HomeTopBar(CanComeBack: true),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                            prefixText: '\$',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Main Category Dropdown
                        BlocBuilder<CategoriesBLoc, CategoriesState>(
                          builder: (context, state) {
                            if (state is CategoriesLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CategoriesLoadedState) {
                              final categories = state.Categories_List;
                              return DropdownButtonFormField<int>(
                                value: _selectedMainCategoryId,
                                decoration: const InputDecoration(
                                  labelText: 'Main Category',
                                  border: OutlineInputBorder(),
                                ),
                                items: categories.map((category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                                onChanged: _onMainCategorySelected,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a main category';
                                  }
                                  return null;
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 16),
                        // Sub Category Dropdown
                        BlocBuilder<SubCategoriesBLoc, SubCategoriesState>(
                          builder: (context, state) {
                            if (state is SubCategoriesLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is SubCategoriesLoadedState) {
                              final subcategories = state.Categories_List;
                              return DropdownButtonFormField<int>(
                                value: _selectedSubCategoryId,
                                decoration: const InputDecoration(
                                  labelText: 'Sub Category',
                                  border: OutlineInputBorder(),
                                ),
                                items: subcategories.map((subcategory) {
                                  return DropdownMenuItem<int>(
                                    value: subcategory.id,
                                    child: Text(subcategory.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSubCategoryId = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a sub category';
                                  }
                                  return null;
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _pickImages,
                          icon: const Icon(Icons.add_photo_alternate),
                          label: const Text('Add Images'),
                        ),
                        if (_selectedImages.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        _selectedImages[index],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _selectedImages.removeAt(index);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        BlocBuilder<ProductBLoc, ProductState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is ProductLoadingState
                                  ? null
                                  : _submitForm,
                              child: state is ProductLoadingState
                                  ? const CircularProgressIndicator()
                                  : const Text('Add Product444'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
