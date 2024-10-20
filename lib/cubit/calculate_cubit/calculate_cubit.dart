import 'package:antar_cash/cubit/calculate_cubit/calculate_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateCubit extends Cubit<CalculateStates> {
  CalculateCubit() : super(CalculatingTotalAmount());

  /// this function to calculate the total amount, fees, and service from all transactions
  int totalAmount = 0;
  int totalAmountOfTransfers = 0;
  int totalAmountOfDeposits = 0;
  int totalFees = 0;
  int totalService = 0;

  void calculateTotalAllTransaction() async {
    emit(CalculatingTotalAmount());
    try {
      final transactionsList =
          await FirebaseFirestore.instance.collection('transactions').get();
      for (var element in transactionsList.docs) {
        totalAmount += int.parse(element['amount']);
        totalFees += int.parse(element['fees']);
        totalService += int.parse(element['service']);
        if (element['type'] == 'تحويل') {
          totalAmountOfTransfers += int.parse(element['amount']);
        } else {
          totalAmountOfDeposits += int.parse(element['amount']);
        }
      }
      emit(CalculatedTotalAmount());
    } on FirebaseException catch (e) {
      emit(CalculateTotalAmountFailed(message: '-------------${e.message}'));
    } catch (e) {
      print(e);
      emit(CalculateTotalAmountFailed(message: e.toString()));
    }
  }
}
