import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../entity/product.dart';
import '../productlist/bloc/product_bloc.dart';
import '../productlist/bloc/product_event.dart';
import '../productlist/bloc/product_state.dart';


class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final _skuController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  final _widthController = TextEditingController();
  final _lengthController = TextEditingController();
  final _heightController = TextEditingController();
  final _imageController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _categoryNameController,
                decoration: InputDecoration(labelText: 'Category Name'),
                validator: (value) => value!.isEmpty ? 'Category Name is required' : null,
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU'),
                validator: (value) => value!.isEmpty ? 'SKU is required' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Description is required' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Weight is required' : null,
              ),
              TextFormField(
                controller: _widthController,
                decoration: InputDecoration(labelText: 'Width'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Width is required' : null,
              ),
              TextFormField(
                controller: _lengthController,
                decoration: InputDecoration(labelText: 'Length'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Length is required' : null,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Height is required' : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Price is required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id: '', // This will be generated by the API
                      categoryName: _categoryNameController.text,
                      sku: _skuController.text,
                      name: _nameController.text,
                      categoryId:'' ,
                      description: _descriptionController.text,
                      weight: double.parse(_weightController.text),
                      width: double.parse(_widthController.text),
                      length: double.parse(_lengthController.text),
                      height: double.parse(_heightController.text),
                      image: _imageController.text,
                      harga: double.parse(_hargaController.text),
                    );

                    context.read<ProductBloc>().add(AddProductEvent(product));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Product'),
              ),
              BlocListener<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
