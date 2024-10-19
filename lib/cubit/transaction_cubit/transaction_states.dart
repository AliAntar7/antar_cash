import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TransactionStates {}

class TransactionInit extends TransactionStates {}
class TransactionLoading extends TransactionStates {}
class TransactionAdded extends TransactionStates {}
class TransactionFailed extends TransactionStates {
  final String message;
  TransactionFailed({required this.message});
}
class TransactionType extends TransactionStates {}
class GetUserNameSuccess extends TransactionStates {}
class LoadingToGetAllTransaction extends TransactionStates {}
class GetAllTransactionSucces extends TransactionStates {
  final QuerySnapshot<Map<String, dynamic>> transactionsList;
  GetAllTransactionSucces({required this.transactionsList});
}
class GetAllTransactionFailed extends TransactionStates {
  final String message;
  GetAllTransactionFailed({required this.message});
}

class CalculatingTotalAmount extends TransactionStates {}
class CalculatedTotalAmount extends TransactionStates {}
class CalculateTotalAmountFailed extends TransactionStates {
  final String message;
  CalculateTotalAmountFailed({required this.message});
}

