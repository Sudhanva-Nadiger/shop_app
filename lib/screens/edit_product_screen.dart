import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
// ignore: library_prefixes
import 'package:shop_app/providers/products_provider.dart' as Product_Provider;

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/editProduct-page';

  @override
  State<EditProductScreen> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descrptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _isInit = true;
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId == null) {
        return;
      }
      _editedProduct =
          Provider.of<Product_Provider.Products>(context, listen: false)
              .findById(productId);
      initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageURL': _editedProduct.imageUrl,
      };

      _imageUrlController.text = _editedProduct.imageUrl;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descrptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    bool? isValid = _form.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id.isNotEmpty) {
      Provider.of<Product_Provider.Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      return;
    }
    Provider.of<Product_Provider.Products>(context, listen: false)
        .addProduct(_editedProduct)
        .catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('An error occured!'),
          content: const Text('Something went wrong'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }).then(
      (_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: initValues['title'],
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: value!,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['price'],
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => {
                        FocusScope.of(context)
                            .requestFocus(_descrptionFocusNode),
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value!),
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide the price';
                        }

                        if (double.tryParse(value) == null) {
                          return 'Please provide a valid number';
                        }

                        if (double.tryParse(value)! <= 0) {
                          return 'Please enter a number greater than zero';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: initValues['description'],
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      focusNode: _descrptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value!,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a descriprion';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Text(
                                  'Enter URL',
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value!,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter as image URL';
                              }

                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL';
                              }

                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.save,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
