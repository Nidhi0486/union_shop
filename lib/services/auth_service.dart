// Lightweight AuthService stub for local development.
// This simulates async sign-in/sign-up so the UI works without Firebase.
class AuthService {
  String? _userEmail;

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

  Future<void> signUp(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (email.isEmpty || password.isEmpty) throw Exception('Invalid credentials');
    _userEmail = email;
  }

  Future<void> signOut() async {
    _userEmail = null;
  }
}
