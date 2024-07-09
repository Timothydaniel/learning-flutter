import 'package:flutter/material.dart';
import 'home.dart';
import '../bottom_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = 'admin';
  String _password = '123';

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_username == 'admin' && _password == '123') {
        _navigateToHome();
      } else {
        debugPrint('Login gagal');
      }
    }
  }

  void _navigateToHome() {
    debugPrint('Login berhasil');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()), // Navigate to Home page on successful login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line to prevent the keyboard from causing overflow
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Add this line to the Column widget to prevent overflow
              children: <Widget>[
                _buildTextFormField(
                  labelText: 'Username',
                  onSaved: (value) => _username = value!,
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  labelText: 'Password',
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Add forget password logic here
                  },
                  child: const Text('Forget Password'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAndLogin,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    bool obscureText = false,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}