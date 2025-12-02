import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../services/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final AuthService _auth = AuthService();
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    try {
      if (_isLogin) {
        await _auth.signIn(_emailCtrl.text.trim(), _passCtrl.text.trim());
      } else {
        await _auth.signUp(_emailCtrl.text.trim(), _passCtrl.text.trim());
      }
      if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(_isLogin ? 'Login' : 'Sign up', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
                        TextFormField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                        const SizedBox(height: 12),
                        if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
                        ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Login' : 'Create account')),
                        TextButton(onPressed: () => setState(() => _isLogin = !_isLogin), child: Text(_isLogin ? 'Create an account' : 'Have an account? Login')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
