import 'package:belo_app/home.dart';
import 'package:belo_app/my_theme.dart';
import 'package:belo_app/provider/auth.dart';
import 'package:belo_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/login';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'phonenumber': '',
    'password': '',
    'username': ''
  };

  final _phonenumberController = TextEditingController(text: '0375268329');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController(text: 'admin123');
  final _repeatPasswordController = TextEditingController();

  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['phonenumber']!,
          _authData['password']!,
        );
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['phonenumber']!,
            _authData['password']!,
            _authData['username']!);
        Util.showNotification('Sign up successfully.', context);
        setState(() {
          _authMode = AuthMode.login;
        });
      }
    } catch (error) {
      // const errorMessage =
      //     'Could not authenticate you. Please try again later.';
      Util.showErrorDialog(error.toString(), context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: 320,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _authMode == AuthMode.login ? 'Login' : 'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                if (_authMode == AuthMode.login) ...[
                  _getPhonenumberTextField(),
                  const SizedBox(height: 15),
                  _getPasswordTextField(),
                ] else ...[
                  _getPhonenumberTextField(),
                  const SizedBox(height: 15),
                  _getUsernameTextField(),
                  const SizedBox(height: 15),
                  _getPasswordTextField(),
                  const SizedBox(height: 15),
                  _getRepeatPasswordTextField(),
                ],
                const SizedBox(height: 20),
                CustomButton(
                  _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
                  Colors.white,
                  MyTheme.kPrimaryColor,
                  _submit,
                  btnWidth: 180,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_authMode == AuthMode.login
                        ? 'Don\'t have an account ?'
                        : 'Already have an account ?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (_authMode == AuthMode.login) {
                            _authMode = AuthMode.signUp;
                          } else {
                            _authMode = AuthMode.login;
                          }
                        });
                      },
                      child: Text(
                          _authMode == AuthMode.login ? 'Sign up' : 'Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhonenumberTextField() {
    return TextFormField(
      controller: _phonenumberController,
      keyboardType: TextInputType.number,
      decoration: Util.getCustomDecoration(
        'phonenumber',
        const Icon(Icons.phone),
        context,
      ),
      onSaved: (value) {
        _authData['phonenumber'] = value!;
      },
      validator: _authMode == AuthMode.signUp
          ? (value) {
              if (value!.trim().isEmpty || value.length < 10) {
                return 'phonnumber is invalid (at least 10 characters)';
              }
            }
          : null,
    );
  }

  Widget _getUsernameTextField() {
    return TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.text,
      decoration: Util.getCustomDecoration(
        'Username',
        const Icon(Icons.account_circle),
        context,
      ),
      onSaved: (value) {
        _authData['username'] = value!;
      },
      validator: _authMode == AuthMode.signUp
          ? (value) {
              if (value!.trim().isEmpty || value.length < 6) {
                return 'Username is too short (at least 6 characters)';
              }
            }
          : null,
    );
  }

  Widget _getPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      decoration: Util.getCustomDecoration(
        'Password',
        const Icon(Icons.lock),
        context,
      ),
      obscureText: true,
      validator: _authMode == AuthMode.signUp
          ? (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password is too short (at least 6 characters)';
              }
            }
          : null,
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _getRepeatPasswordTextField() {
    return TextFormField(
        controller: _repeatPasswordController,
        decoration: Util.getCustomDecoration(
          'Repeat Password',
          const Icon(Icons.lock),
          context,
        ),
        obscureText: true,
        validator: (value) {
          if (value != _passwordController.text) {
            return 'Repeat password not match!';
          }
        });
  }
}
