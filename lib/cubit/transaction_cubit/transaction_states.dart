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
  final List<QueryDocumentSnapshot> transactionsList;
  GetAllTransactionSucces({required this.transactionsList});
}
class GetTransactionsGroupedByHourSuccess extends TransactionStates {
  final Map<String, List<QueryDocumentSnapshot>> transactionsByHour;
  GetTransactionsGroupedByHourSuccess({required this.transactionsByHour});
}
class GetAllTransactionFailed extends TransactionStates {
  final String message;
  GetAllTransactionFailed({required this.message});
}

class LoadingToDeleteTransaction extends TransactionStates {}
class DeleteTransactionSucces extends TransactionStates {}
class DeleteTransactionFailed extends TransactionStates {
  final String message;
  DeleteTransactionFailed({required this.message});
}

