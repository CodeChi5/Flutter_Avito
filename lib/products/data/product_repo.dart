import 'product_model.dart';

class ProductRepo {
  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> listProduct = [
      ProductModel(
          id: 1,
          name: "Laptop",
          price: 999.99,
          description: "A high-performance laptop with 16GB RAM and 512GB SSD.",
          imageUrl: [
            'https://lh3.googleusercontent.com/QX6FAxGVzfYZaWGl3fFIiTfclInWKBbCOjw4sIzgpMM-D4eP2W1yHcVvQF4y-YwGosDdmuDeFaLVpUeTCp1iPtA3iL5dyafVRGWmFKw041SUpREgshI=w360-e365',
            'https://lh3.googleusercontent.com/XJenfpdInN3LjS4b9ulFiV8mc2PncCXHoE9xsdjYChZND38koCCTU49tDtq8tU6fLQdaKN5XGP3UpeddoK0sxypYgt14f_-HLQuHjBNB04cCEcsjMeE=w360-e365',
            'https://lh3.googleusercontent.com/XJenfpdInN3LjS4b9ulFiV8mc2PncCXHoE9xsdjYChZND38koCCTU49tDtq8tU6fLQdaKN5XGP3UpeddoK0sxypYgt14f_-HLQuHjBNB04cCEcsjMeE=w360-e365'
          ]),
      ProductModel(
          id: 1,
          name: "Laptop",
          price: 999.99,
          description: "A high-performance laptop with 16GB RAM and 512GB SSD.",
          imageUrl: [
            'https://lh3.googleusercontent.com/QX6FAxGVzfYZaWGl3fFIiTfclInWKBbCOjw4sIzgpMM-D4eP2W1yHcVvQF4y-YwGosDdmuDeFaLVpUeTCp1iPtA3iL5dyafVRGWmFKw041SUpREgshI=w360-e365',
            'https://lh3.googleusercontent.com/XJenfpdInN3LjS4b9ulFiV8mc2PncCXHoE9xsdjYChZND38koCCTU49tDtq8tU6fLQdaKN5XGP3UpeddoK0sxypYgt14f_-HLQuHjBNB04cCEcsjMeE=w360-e365'
          ]),
      ProductModel(
          id: 1,
          name: "Laptop",
          price: 999.99,
          description: "A high-performance laptop with 16GB RAM and 512GB SSD.",
          imageUrl: [
            'https://lh3.googleusercontent.com/QX6FAxGVzfYZaWGl3fFIiTfclInWKBbCOjw4sIzgpMM-D4eP2W1yHcVvQF4y-YwGosDdmuDeFaLVpUeTCp1iPtA3iL5dyafVRGWmFKw041SUpREgshI=w360-e365',
            'https://lh3.googleusercontent.com/XJenfpdInN3LjS4b9ulFiV8mc2PncCXHoE9xsdjYChZND38koCCTU49tDtq8tU6fLQdaKN5XGP3UpeddoK0sxypYgt14f_-HLQuHjBNB04cCEcsjMeE=w360-e365'
          ]),
      ProductModel(
          id: 1,
          name: "Laptop",
          price: 999.99,
          description: "A high-performance laptop with 16GB RAM and 512GB SSD.",
          imageUrl: [
            'https://lh3.googleusercontent.com/QX6FAxGVzfYZaWGl3fFIiTfclInWKBbCOjw4sIzgpMM-D4eP2W1yHcVvQF4y-YwGosDdmuDeFaLVpUeTCp1iPtA3iL5dyafVRGWmFKw041SUpREgshI=w360-e365',
            'https://lh3.googleusercontent.com/XJenfpdInN3LjS4b9ulFiV8mc2PncCXHoE9xsdjYChZND38koCCTU49tDtq8tU6fLQdaKN5XGP3UpeddoK0sxypYgt14f_-HLQuHjBNB04cCEcsjMeE=w360-e365'
          ]),
    ];
    return listProduct;
  }
}
