import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
// import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _descriptionFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool imageUrlIsValid(String url) {
    bool isUrlValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool pathExtension =
        url.endsWith('.png') || url.endsWith('.jpg') || url.endsWith('.jpeg');

    return isUrlValid && pathExtension;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();

    final messageStatus = _formData['id'] == null ? 'create' : 'update';
    notificationMessage(context, messageStatus);
  }

  @override
  Widget build(BuildContext context) {        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
        actions: [
          IconButton(onPressed: _submitForm, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            key: GlobalKey<FormState>(),
            children: [
              TextFormField(
                  initialValue: _formData['name']?.toString(),
                  decoration: InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (name) {
                    final nameValue = name ?? '';

                    if (nameValue.trim().isEmpty) return 'Nome é obrigatório';
                    if (nameValue.trim().length < 3) return 'Nome precisa de no mínimo 3 caracteres';

                    return null;
                  }),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0.0'),
                validator: (price) {
                  final priceValue = double.parse(price ?? '0.0');

                  if (priceValue == 0) return 'Preço deve ser maior que 0';

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                validator: (description) {
                  final descriptionValue = description ?? '';

                  if (descriptionValue.trim().isEmpty)
                    return 'Descrição é obrigatória';
                  if (descriptionValue.trim().length < 10)
                    return 'Descrição deve conter no mínimo 10 caracteres';
                  if (descriptionValue.trim().length > 100)
                    return 'Descrição pode conter no máximo 100 caracteres';

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm,
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      validator: (url) {
                        final urlValue = url ?? '';

                        if (!imageUrlIsValid(urlValue)) return 'Url inválida!';

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(left: 20, top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void notificationMessage(BuildContext context, String messageStatus) {
  final message = 'Produto ${messageStatus == 'create' ? 'adicionado' : 'atualizado'} com sucesso!!';

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green[700],
      duration: Duration(seconds: 2),
    ),
  );
}