import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _obscure = true;
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
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
                  const Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                  TextField(
                    controller: _pass,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    obscureText: _obscure,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: () async {
                    try {
                      await _auth.signIn(_email.text.trim(), _pass.text.trim());
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged in (dummy)')));
                      Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${e.toString()}')));
                    }
                  }, child: const Text('Login')),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
