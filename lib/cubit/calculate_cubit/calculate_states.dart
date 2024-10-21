import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CalculateStates {}

class CalculatingTotalAmount extends CalculateStates {}
class CalculatedTotalAmount extends CalculateStates {}
class CalculateTotalAmountFailed extends CalculateStates {
  final String message;
  CalculateTotalAmountFailed({required this.message});
}

class LoadingToGetAllTransaction extends CalculateStates {}
class GetTransactionsGroupedByDaySuccess extends CalculateStates {

  final Map<String, Map<String, int>> infoOfEachDay;
  GetTransactionsGroupedByDaySuccess({required this.infoOfEachDay});
}
class GetTransactionsGroupedByMonthSuccess extends CalculateStates {

  final Map<String, Map<String, int>> infoOfEachMonth;
  GetTransactionsGroupedByMonthSuccess({required this.infoOfEachMonth});
}
class GetAllTransactionFailed extends CalculateStates {
  final String message;
  GetAllTransactionFailed({required this.message});
}
