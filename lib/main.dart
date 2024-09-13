import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'module/addproduct/addproduct_screen.dart';
import 'module/detailproduct/productdetail_screen.dart';
import 'module/productlist/api/product_repository.dart';
import 'module/productlist/bloc/product_bloc.dart';
import 'module/productlist/bloc/product_event.dart';
import 'module/productlist/screen/product_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductService())..add(FetchProductsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Product App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),  // This is the main screen for product listing
        onGenerateRoute: (settings) {
          // Route to handle product details screen dynamically
          if (settings.name == '/productDetail') {
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(productId: productId),
            );
          }
          return null;
        },
        routes: {
          '/addProduct': (context) => AddProductScreen(),
          // '/updateProduct': (context) => UpdateProductScreen(),
        },
      ),
    );
  }
}
