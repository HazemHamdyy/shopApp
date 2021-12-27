import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/productModel.dart';
import 'package:shop_app/provider/productProvider.dart';

class EditingProductScreen extends StatefulWidget {
  final String? id;

  EditingProductScreen(this.id);

  @override
  _EditingProductScreenState createState() => _EditingProductScreenState();
}

class _EditingProductScreenState extends State<EditingProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editingProduct =
      ProductModel(id: null, description: '', title: '', image: '', price: 0);
  bool isInt = true;
  Map initValue = {
    'title': '',
    'price': '',
    'description': '',
    'image': '',
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInt) {
      if (widget.id == null) {
      } else {
        final productID = widget.id;
        _editingProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productID!);
        initValue = {
          'title': _editingProduct.title,
          'price': _editingProduct.price.toString(),
          'description': _editingProduct.description,
          'image': '',
        };
        _imageController.text = _editingProduct.image!;
      }
    }
    isInt = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      if (_imageController.text.isEmpty) {
        return;
      }
      if (!_imageController.text.startsWith('http')) {
        return;
      }
      if (!_imageController.text.endsWith('.png') &&
          !_imageController.text.endsWith('.jpg') &&
          !_imageController.text.endsWith('.jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (_editingProduct.id != null) {
    } else {}
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
    }
    if (_editingProduct.id != null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editingProduct.id!, _editingProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editingProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: initValue['title'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editingProduct = ProductModel(
                      isFav: _editingProduct.isFav,
                      id: _editingProduct.id,
                      description: _editingProduct.description,
                      title: value,
                      image: _editingProduct.image,
                      price: _editingProduct.price);
                },
              ),
              Divider(),
              TextFormField(
                initialValue: initValue['price'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a Valid Number';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please Enter a Valid Price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editingProduct = ProductModel(
                      isFav: _editingProduct.isFav,
                      id: _editingProduct.id,
                      description: _editingProduct.description,
                      title: _editingProduct.title,
                      image: _editingProduct.image,
                      price: double.parse(value!));
                },
              ),
              Divider(),
              TextFormField(
                initialValue: initValue['description'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Description';
                  }
                  if (value.length < 10) {
                    return 'Please Enter a Longer Description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editingProduct = ProductModel(
                      isFav: _editingProduct.isFav,
                      id: _editingProduct.id,
                      description: value,
                      title: _editingProduct.title,
                      image: _editingProduct.image,
                      price: _editingProduct.price);
                },
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageController.text.isEmpty
                        ? Center(
                            child: Text(
                              'Enter an Image',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : FittedBox(
                            child: Image.network(_imageController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Image';
                        }
                        if (!value.startsWith('http')) {
                          return 'This Image is not Valid';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'This Image is not Valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Image'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _saveForm();
                        setState(() {});
                      },
                      controller: _imageController,
                      focusNode: _imageFocusNode,
                      onSaved: (value) {
                        _editingProduct = ProductModel(
                            isFav: _editingProduct.isFav,
                            id: _editingProduct.id,
                            description: _editingProduct.description,
                            title: _editingProduct.title,
                            image: value,
                            price: _editingProduct.price);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
