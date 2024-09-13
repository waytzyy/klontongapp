import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService = ProductService();

  ProductBloc(ProductService read) : super(ProductLoading()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        print("Error fetching products in BLoC: $e");
        emit(ProductError("Failed to load products"));
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productService.addProduct(event.product);
        final products = await _productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        print("Error adding product in BLoC: $e");
        emit(ProductError("Failed to add product"));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productService.updateProduct(event.product);
        final products = await _productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        print("Error updating product in BLoC: $e");
        emit(ProductError("Failed to update product"));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        await _productService.deleteProduct(event.productId);
        final products = await _productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        print("Error deleting product in BLoC: $e");
        emit(ProductError("Failed to delete product"));
      }
    });

    on<FetchProductDetailEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _productService.fetchProducts();
        final product = products.firstWhere((p) => p.id == event.productId);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        print("Error fetching product detail in BLoC: $e");
        emit(ProductError("Failed to load product detail"));
      }
    });
  }
}
