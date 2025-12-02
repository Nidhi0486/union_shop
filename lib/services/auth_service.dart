// Lightweight AuthService stub for local development.
// This simulates async sign-in/sign-up so the UI works without Firebase.
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? _userEmail;
  Map<String, String> _profile = {};

  String? get currentUser => _userEmail;

  // Simple stream that isn't implemented for now; UI uses immediate results.
  Stream<String?> authStateChanges() async* {
    yield _userEmail;
  }

  Future<void> signIn(String email, String password) async {
    // very small delay to simulate network call
    await Future.delayed(const Duration(milliseconds: 300));
    // naive check: accept any non-empty credentials
    if (email.isEmpty || password.isEmpty) throw Exception('Invalid credentials');
    _userEmail = email;
  }

  Future<void> signUp(String email, String password, {String? name, String? surname, String? phone}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (email.isEmpty || password.isEmpty) throw Exception('Invalid credentials');
    _userEmail = email;
    _profile = {
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (phone != null) 'phone': phone,
      'email': email,
    };
    // persist profile locally
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_email', email);
      if (name != null) await prefs.setString('profile_name', name);
      if (surname != null) await prefs.setString('profile_surname', surname);
      if (phone != null) await prefs.setString('profile_phone', phone);
    } catch (_) {
      // ignore persistence errors in stub
    }
  }

  /// For development: return stored profile info.
  Map<String, String> get profile => Map.from(_profile);

  /// Load profile from SharedPreferences into the stub
  Future<void> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('profile_email') ?? '';
      if (email.isEmpty) return;
      _profile = {
        'email': email,
        if (prefs.containsKey('profile_name')) 'name': prefs.getString('profile_name')!,
        if (prefs.containsKey('profile_surname')) 'surname': prefs.getString('profile_surname')!,
        if (prefs.containsKey('profile_phone')) 'phone': prefs.getString('profile_phone')!,
      };
      _userEmail = email;
    } catch (_) {
      // ignore load errors for stub
    }
  }

  Future<void> signOut() async {
    _userEmail = null;
  }

  /// Update profile fields and persist them
  Future<void> updateProfile({String? name, String? surname, String? phone}) async {
    if (_userEmail == null) throw Exception('Not signed in');
    if (name != null) _profile['name'] = name;
    if (surname != null) _profile['surname'] = surname;
    if (phone != null) _profile['phone'] = phone;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (name != null) await prefs.setString('profile_name', name);
      if (surname != null) await prefs.setString('profile_surname', surname);
      if (phone != null) await prefs.setString('profile_phone', phone);
    } catch (_) {
      // ignore
    }
  }
}
