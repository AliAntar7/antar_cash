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




  int totalLockOfAllDays = 0;
  void getTransactionsGroupedByDay() async {
    emit(LoadingToGetAllTransaction());
    try {
      // Get all transactions ordered by date in descending order
      final transactionsList = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      // Map to store transactions grouped by day
      Map<String, List<QueryDocumentSnapshot>> transactionsByDay = {};

      // Arabic days of the week
      List<String> arabicDays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];

      for (var transaction in transactionsList.docs) {
        // Get the 'date' field from the document
        Timestamp transactionDate = transaction['date'];

        // Extract the weekday in Arabic
        String weekday = arabicDays[transactionDate.toDate().weekday - 1];

        // Format the date to "DD/MM/YYYY" and combine with the weekday in Arabic
        String formattedDate = '$weekday ${DateFormat('yyyy/MM/dd').format(transactionDate.toDate())}';

        // Group transactions by the formatted date
        if (transactionsByDay.containsKey(formattedDate)) {
          transactionsByDay[formattedDate]!.add(transaction);
        } else {
          transactionsByDay[formattedDate] = [transaction];
        }
      }


      /// this map to store the total amount, fees, and service for each day
      Map<String, Map<String, int>> infoOfEachDay = {};
      for (var Day in transactionsByDay.keys) {
        final transactions = transactionsByDay[Day];
        int totalAmount = 0;
        int totalAmountOfTransfers = 0;
        int totalAmountOfDeposits = 0;
        int totalFees = 0;
        int totalService = 0;
        /// this loop to calculate the total amount, fees, and service for each day
        for (var transaction in transactions!) {
          totalAmount += int.parse(transaction['amount']);
          totalFees += int.parse(transaction['fees']);
          totalService += int.parse(transaction['service']);
          if (transaction['type'] == 'تحويل') {
            totalAmountOfTransfers += int.parse(transaction['amount']);
          } else {
            totalAmountOfDeposits += int.parse(transaction['amount']);
          }
        }


        int halfOfTotalFees = totalFees ~/ 2;
        int totalLockOfTransfers = totalAmountOfTransfers + totalService + halfOfTotalFees;
        int totalLockOfDeposits = totalAmountOfDeposits + halfOfTotalFees;
        int totalLockOfTheDay = totalLockOfDeposits - totalLockOfTransfers;



        /// this is the map that will be added to the infoOfEachDay map
        infoOfEachDay[Day] = {
          'totalAmount': totalAmount,
          'totalAmountOfTransfers': totalAmountOfTransfers,
          'totalAmountOfDeposits': totalAmountOfDeposits,
          'totalFees': totalFees,
          'totalService': totalService,
          'halfOfTotalFees': halfOfTotalFees,
          'totalLockOfTransfers': totalLockOfTransfers,
          'totalLockOfDeposits': totalLockOfDeposits,
          'totalLockOfTheDay': totalLockOfTheDay,
        };
      }

      for (var day in infoOfEachDay.keys) {
        totalLockOfAllDays += infoOfEachDay[day]!['totalLockOfTheDay']!;
      }



      // Emit success state with the grouped transactions by day
      emit(GetTransactionsGroupedByDaySuccess(infoOfEachDay: infoOfEachDay));
    } on FirebaseException catch (e) {
      emit(GetAllTransactionFailed(message: 'Firebase Error: ${e.message}'));
    } catch (e) {
      print(e);
      emit(GetAllTransactionFailed(message: e.toString()));
    }
  }


  void getTransactionsGroupedByMonth() async {
    emit(LoadingToGetAllTransaction());
    try {
      // Get all transactions ordered by date in descending order
      final transactionsList = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      // Map to store transactions grouped by month
      Map<String, List<QueryDocumentSnapshot>> transactionsByMonth = {};

      // Arabic months names
      List<String> arabicMonths = [
        'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
        'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
      ];

      for (var transaction in transactionsList.docs) {
        // Get the 'date' field from the document
        Timestamp transactionDate = transaction['date'];

        // Extract month and year from the date
        String monthName = arabicMonths[transactionDate.toDate().month - 1];
        String year = DateFormat('yyyy').format(transactionDate.toDate());

        // Format the date to "Month YYYY" in Arabic
        String formattedMonth = '$monthName $year';

        // Group transactions by the formatted month
        if (transactionsByMonth.containsKey(formattedMonth)) {
          transactionsByMonth[formattedMonth]!.add(transaction);
        } else {
          transactionsByMonth[formattedMonth] = [transaction];
        }
      }

      /// this map to store the total amount, fees, and service for each month
      Map<String, Map<String, int>> infoOfEachMonth = {};
      for (var monthName in transactionsByMonth.keys) {
        final transactions = transactionsByMonth[monthName];
        int totalAmount = 0;
        int totalAmountOfTransfers = 0;
        int totalAmountOfDeposits = 0;
        int totalFees = 0;
        int totalService = 0;
        /// this loop to calculate the total amount, fees, and service for each month
        for (var transaction in transactions!) {
          totalAmount += int.parse(transaction['amount']);
          totalFees += int.parse(transaction['fees']);
          totalService += int.parse(transaction['service']);
          if (transaction['type'] == 'تحويل') {
            totalAmountOfTransfers += int.parse(transaction['amount']);
          } else {
            totalAmountOfDeposits += int.parse(transaction['amount']);
          }
        }
        /// this is the map that will be added to the infoOfEachMonth map
        infoOfEachMonth[monthName] = {
          'totalAmount': totalAmount,
          'totalAmountOfTransfers': totalAmountOfTransfers,
          'totalAmountOfDeposits': totalAmountOfDeposits,
          'totalFees': totalFees,
          'totalService': totalService,
        };
      }

      // Emit success state with the grouped transactions by month
      emit(GetTransactionsGroupedByMonthSuccess(infoOfEachMonth: infoOfEachMonth));
    } on FirebaseException catch (e) {
      emit(GetAllTransactionFailed(message: 'Firebase Error: ${e.message}'));
    } catch (e) {
      print(e);
      emit(GetAllTransactionFailed(message: e.toString()));
    }
  }

}
