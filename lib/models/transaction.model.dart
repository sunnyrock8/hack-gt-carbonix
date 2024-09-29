class Transaction {
  final String from;
  final String to;
  final double amount;
  final DateTime timestamp;
  final int type; // 0 - credit, 1 - debit

  Transaction(
      {required this.from,
      required this.to,
      required this.amount,
      required this.timestamp,
      required this.type});
}
