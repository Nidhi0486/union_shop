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
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _obscure = true;

  final AuthService _auth = AuthService();
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    try {
      if (_isLogin) {
        if (!_formKey.currentState!.validate()) return;
        await _auth.signIn(_emailCtrl.text.trim(), _passCtrl.text.trim());
      } else {
        if (!_formKey.currentState!.validate()) return;
        await _auth.signUp(
          _emailCtrl.text.trim(),
          _passCtrl.text.trim(),
          name: _nameCtrl.text.trim(),
          surname: _surnameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
        );
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
                  // Mode toggle buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLogin ? const Color(0xFF4d2963) : Colors.grey[200],
                            foregroundColor: _isLogin ? Colors.white : Colors.black,
                          ),
                          onPressed: () => setState(() => _isLogin = true),
                          child: const Text('Sign in'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_isLogin ? const Color(0xFF4d2963) : Colors.grey[200],
                            foregroundColor: !_isLogin ? Colors.white : Colors.black,
                          ),
                          onPressed: () => setState(() => _isLogin = false),
                          child: const Text('Sign up'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isLogin)
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(labelText: 'Name'),
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                          ),
                        if (!_isLogin)
                          TextFormField(
                            controller: _surnameCtrl,
                            decoration: const InputDecoration(labelText: 'Surname'),
                            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your surname' : null,
                          ),
                        if (!_isLogin)
                          TextFormField(
                            controller: _phoneCtrl,
                            decoration: const InputDecoration(labelText: 'Phone number'),
                            keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Please enter phone number';
                              if (!RegExp(r"^[0-9 +()-]{7,}").hasMatch(v.trim())) return 'Enter a valid phone number';
                              return null;
                            },
                          ),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter email';
                            if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(v.trim())) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passCtrl,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          obscureText: _obscure,
                          validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                        ),
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
