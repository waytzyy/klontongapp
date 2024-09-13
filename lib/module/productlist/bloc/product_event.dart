// lib/blocs/product_event.dart
import '../../../entity/product.dart';

abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final Product product;

  UpdateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final String productId;

  DeleteProductEvent(this.productId);
}

class FetchProductDetailEvent extends ProductEvent {
  final String productId;

  FetchProductDetailEvent(this.productId);
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  SearchProductsEvent(this.query);
}
