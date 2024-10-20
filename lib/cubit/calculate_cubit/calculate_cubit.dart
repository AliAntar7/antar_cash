import 'package:antar_cash/cubit/calculate_cubit/calculate_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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


  // Map to store transactions grouped by hour
  Map<String, List<QueryDocumentSnapshot>> transactionsByHour = {};
  void getTransactionsGroupedByHour() async {
    emit(LoadingToGetAllTransaction());
    try {
      // Get all transactions ordered by date in descending order
      final transactionsList = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      for (var transaction in transactionsList.docs) {
        // Get the 'date' field from the document
        Timestamp transactionDate = transaction['date'];

        // Format the date to get only the hour (using 24-hour format)
        String hourKey = DateFormat('yyyy-MM-dd HH:mm').format(transactionDate.toDate());

        // Group transactions by hour
        if (transactionsByHour.containsKey(hourKey)) {
          transactionsByHour[hourKey]!.add(transaction);
        } else {
          transactionsByHour[hourKey] = [transaction];
        }
      }
      print(transactionsByHour);

      // Emit success state with the grouped transactions
      emit(GetTransactionsGroupedByHourSuccess());
    } on FirebaseException catch (e) {
      emit(GetAllTransactionFailed(message: 'Firebase Error: ${e.message}'));
    } catch (e) {
      print(e);
      emit(GetAllTransactionFailed(message: e.toString()));
    }
  }
}
