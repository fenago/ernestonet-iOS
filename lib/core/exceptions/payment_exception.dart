class PaymentException implements Exception {
  final String message;

  const PaymentException(this.message);
}
