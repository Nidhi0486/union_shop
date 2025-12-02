import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../services/auth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthService _auth = AuthService();
  Map<String, String> _profile = {};
  bool _editing = false;
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _auth.loadProfile();
    _profile = _auth.profile;
    _nameCtrl.text = _profile['name'] ?? '';
    _surnameCtrl.text = _profile['surname'] ?? '';
    _phoneCtrl.text = _profile['phone'] ?? '';
    setState(() {});
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('My account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => setState(() => _editing = !_editing),
                        child: Text(_editing ? 'Cancel' : 'Edit'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (!_editing) ...[
                    ListTile(title: const Text('Name'), subtitle: Text(_profile['name'] ?? '-')),
                    ListTile(title: const Text('Surname'), subtitle: Text(_profile['surname'] ?? '-')),
                    ListTile(title: const Text('Phone'), subtitle: Text(_profile['phone'] ?? '-')),
                    ListTile(title: const Text('Email'), subtitle: Text(_profile['email'] ?? '-')),
                  ] else ...[
                    TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
                    TextFormField(controller: _surnameCtrl, decoration: const InputDecoration(labelText: 'Surname')),
                    TextFormField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _auth.updateProfile(name: _nameCtrl.text.trim(), surname: _surnameCtrl.text.trim(), phone: _phoneCtrl.text.trim());
                          await _load();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed: ${e.toString()}')));
                        }
                      },
                      child: const Text('Save changes'),
                    ),
                  ],
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
