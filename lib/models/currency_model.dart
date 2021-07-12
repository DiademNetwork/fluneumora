import 'package:fluneumora/all.dart';

class CurrencyModel extends Equatable {
  CurrencyModel({
    required this.name,
    this.balance = 0,
    this.transactions = const [],
  });

  final String name;

  final int balance;

  final List<Object> transactions;

  get props => [];
}
