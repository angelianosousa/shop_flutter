import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signUp, signIn }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.signIn;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showDialogError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Ocorreu um Erro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isSignIn()) {
        await auth.signIn(_authData['email']!, _authData['password']!);
      } else {
        await auth.signUp(_authData['email']!, _authData['password']!);
        _switchAuthMode();
      }
    } on AuthException catch (error) {
      _showDialogError(error.toString());
    } catch (error) {
      _showDialogError('Ocorreu um erro inesperado!');
    }

    _clearAuthData();
    setState(() => _isLoading = false);
  }

  bool _isSignIn() => _authMode == AuthMode.signIn;
  bool _isSignUp() => _authMode == AuthMode.signUp;

  void _switchAuthMode() {
    setState(() {
      if (_isSignIn()) {
        _authMode = AuthMode.signUp;
      } else {
        _authMode = AuthMode.signIn;
      }
    });
  }

  void _clearAuthData() {
    setState(() => _authData = {'email': '', 'password': ''});
  }

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: _isSignIn() ? 290 : 330,
        width: sizeDevice.width * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';

                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido!';
                  }

                  return null;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  controller: _passwordController,
                  validator: (_password) {
                    final password = _password ?? '';

                    if (password.isEmpty || password.length < 5) {
                      return 'A senha deve ter pelo menos 5 caracteres';
                    } else {
                      return null;
                    }
                  }),
              if (_isSignUp())
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirme a senha'),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: _isSignIn()
                      ? null
                      : (_confirmPass) {
                          final confirPassword = _confirmPass ?? '';

                          if (confirPassword != _passwordController.text) {
                            return 'As senhas não são iguais';
                          } else {
                            return null;
                          }
                        },
                ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    fixedSize: Size(sizeDevice.width * 0.8, 10),
                  ),
                  onPressed: _submitForm,
                  child: Text(_isSignIn() ? 'ENTRAR' : 'REGISTRAR'),
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isSignUp() ? 'JÁ POSSUI UMA CONTA ?' : 'CRIAR CONTA',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
