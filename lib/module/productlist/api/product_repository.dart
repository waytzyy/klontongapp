import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../entity/product.dart';

class ProductService {
  // Define the base URL for the API
  final String baseUrl = 'https://crudcrud.com/api/94d62806bdc949358983848201ddb8ff/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      // Print status code and body for debugging
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        return productJson.map((json) => Product.fromJson(json)).toList();
      } else {
        final responseBody = response.body;
        throw Exception("Failed to load products: $responseBody");
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products: $e");
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final products = await fetchProducts();
      return products.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
    } catch (e) {
      print("Error searching products: $e");
      throw Exception("Error searching products");
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode != 201) {
        final responseBody = response.body;
        throw Exception("Failed to add product: $responseBody");
      }
    } catch (e) {
      print("Error adding product: $e");
      throw Exception("Error adding product: $e");
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode != 200) {
        final responseBody = response.body;
        throw Exception("Failed to update product: $responseBody");
      }
    } catch (e) {
      print("Error updating product: $e");
      throw Exception("Error updating product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      if (response.statusCode != 200) {
        final responseBody = response.body;
        throw Exception("Failed to delete product: $responseBody");
      }
    } catch (e) {
      print("Error deleting product: $e");
      throw Exception("Error deleting product: $e");
    }
  }
}
