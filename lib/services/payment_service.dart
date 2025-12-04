import 'dart:async';

class PaymentService {
  /// Simulate processing a payment. Returns true on success.
  static Future<bool> processPayment({required String method, Map<String, String>? card, double? amount}) async {
    // Simulate network / gateway latency
    await Future.delayed(const Duration(seconds: 2));
    // In a real implementation, call your payment gateway here.
    return true;
  }
}
