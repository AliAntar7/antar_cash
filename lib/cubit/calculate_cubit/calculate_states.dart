
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CalculateStates {}

class CalculatingTotalAmount extends CalculateStates {}
class CalculatedTotalAmount extends CalculateStates {}
class CalculateTotalAmountFailed extends CalculateStates {
  final String message;
  CalculateTotalAmountFailed({required this.message});
}

class LoadingToGetAllTransaction extends CalculateStates {}
class LoadingToGetTransactionsGroupedByDay extends CalculateStates {}
class calculateAllTransactionsGroupedByDaySuccess extends CalculateStates {

  final Map<String, Map<String, int>> infoOfEachDay;
  calculateAllTransactionsGroupedByDaySuccess({required this.infoOfEachDay});
}
class getTransactionsGroupedByDaySuccess extends CalculateStates {

  final Map<String, List<QueryDocumentSnapshot>> transactionsByDay;
  getTransactionsGroupedByDaySuccess({required this.transactionsByDay});
}
class GetTransactionsGroupedByMonthSuccess extends CalculateStates {

  final Map<String, Map<String, int>> infoOfEachMonth;
  GetTransactionsGroupedByMonthSuccess({required this.infoOfEachMonth});
}
class GetAllTransactionFailed extends CalculateStates {
  final String message;
  GetAllTransactionFailed({required this.message});
}
class GetTransactionsGroupedByDayFailed extends CalculateStates {
  final String message;
  GetTransactionsGroupedByDayFailed({required this.message});
}
