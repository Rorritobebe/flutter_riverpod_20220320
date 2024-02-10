import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  Product({required this.name, required this.price});

  final String name;
  final double price;
}

final _products = [
  Product(name: "Spaghetti", price: 10),
  Product(name: "Indomie", price: 6),
  Product(name: "Fried Yam", price: 9),
  Product(name: "Beans", price: 10),
  Product(name: "Red Chicken feet", price: 2),
];

enum ProductSortType {
  name,
  price,
}

final productSortTypeProvider = StateProvider<ProductSortType>((ref) => ProductSortType.name);

final futureProductsProvider = FutureProvider.autoDispose<List<Product>>(
  (ref) async {
    final sortType = ref.watch(productSortTypeProvider);
    List<Product> sortedProducts = _products.toList();

    switch (sortType) {
      case ProductSortType.name:
        sortedProducts.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductSortType.price:
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
    }

    await Future.delayed(const Duration(seconds: 3));

    return sortedProducts;
  },
);

class ProductPage extends ConsumerWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsProvider = ref.watch(futureProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Provider Example"),
        actions: [
          DropdownButton<ProductSortType>(
            dropdownColor: Colors.brown,
            value: ref.watch(productSortTypeProvider),
            items: const [
              DropdownMenuItem(
                value: ProductSortType.name,
                child: Icon(Icons.sort_by_alpha),
              ),
              DropdownMenuItem(
                value: ProductSortType.price,
                child: Icon(Icons.sort),
              ),
            ],
            onChanged: (value) => ref.read(productSortTypeProvider),
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue,
      body: Container(
        child: productsProvider.when(
          data: (products) => ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  color: Colors.blueAccent,
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      products[index].name,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(
                      "${products[index].price}",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          error: (err, stack) => Text(
            "Error: $err",
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: ProductPage(),
      ),
    ),
  );
}
