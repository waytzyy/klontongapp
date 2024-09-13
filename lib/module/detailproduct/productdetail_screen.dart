import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../productlist/bloc/product_bloc.dart';
import '../productlist/bloc/product_event.dart';
import '../productlist/bloc/product_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductDetailEvent(productId));

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${product.categoryName}', style: TextStyle(fontSize: 16)),
                    Text('SKU: ${product.sku}', style: TextStyle(fontSize: 16)),
                    Text('Name: ${product.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Description: ${product.description}', style: TextStyle(fontSize: 16)),
                    Text('Weight: ${product.weight}', style: TextStyle(fontSize: 16)),
                    Text('Width: ${product.width}', style: TextStyle(fontSize: 16)),
                    Text('Length: ${product.length}', style: TextStyle(fontSize: 16)),
                    Text('Height: ${product.height}', style: TextStyle(fontSize: 16)),
                    Text('Image: ${product.image}', style: TextStyle(fontSize: 16)),
                    Text('Price: ${product.harga}', style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Product not found'));
            }
          },
        ),
      ),
    );
  }
}
