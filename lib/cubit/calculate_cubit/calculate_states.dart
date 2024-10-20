abstract class CalculateStates {}

class CalculatingTotalAmount extends CalculateStates {}
class CalculatedTotalAmount extends CalculateStates {}
class CalculateTotalAmountFailed extends CalculateStates {
  final String message;
  CalculateTotalAmountFailed({required this.message});
}