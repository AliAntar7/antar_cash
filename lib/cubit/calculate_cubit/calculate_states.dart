import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CalculateStates {}

class CalculatingTotalAmount extends CalculateStates {}
class CalculatedTotalAmount extends CalculateStates {}
class CalculateTotalAmountFailed extends CalculateStates {
  final String message;
  CalculateTotalAmountFailed({required this.message});
}

class LoadingToGetAllTransaction extends CalculateStates {}
class GetTransactionsGroupedByHourSuccess extends CalculateStates {}
class GetAllTransactionFailed extends CalculateStates {
  final String message;
  GetAllTransactionFailed({required this.message});
}
