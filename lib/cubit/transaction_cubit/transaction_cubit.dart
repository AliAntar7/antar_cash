import 'package:antar_cash/cubit/transaction_cubit/transaction_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionInit());

  List<bool> isSelected = [true, false];
  int index = 0;

  /// this function to change the transaction type
  void transactionType() {
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex == index) {
        isSelected[buttonIndex] = true;
      } else {
        isSelected[buttonIndex] = false;
      }
    }
    print(index);
    emit(TransactionType());
  }

  /// this function to add transaction to firebase
  void addTransaction({
    required String amount,
    required String fees,
    required String service,
    required String note,
    required String name,
  }) async {
    emit(TransactionLoading());
    try {
      await FirebaseFirestore.instance.collection('transactions').add({
        'user_name': name,
        'amount': amount,
        'fees': fees,
        'service': service,
        'note': note,
        'type': index == 0 ? 'إيداع' : 'تحويل',
        'date': Timestamp.fromDate(DateTime.now()),
      }).then((value) {
        emit(TransactionAdded());
      });
    } on FirebaseException catch (e) {
      emit(TransactionFailed(message: '-------------${e.message}'));
    } catch (e) {
      emit(TransactionFailed(message: e.toString()));
    }
  }

  /// this function to get all transactions from firebase
  void getAllTransactions() async {
    emit(LoadingToGetAllTransaction());
    try {
      final transactionsList = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();
      emit(GetAllTransactionSucces(transactionsList: transactionsList.docs));
    } on FirebaseException catch (e) {
      emit(GetAllTransactionFailed(message: '-------------${e.message}'));
    } catch (e) {
      print(e);
      emit(GetAllTransactionFailed(message: e.toString()));
    }
  }


  void deleteTransaction(String id) async {
    emit(LoadingToDeleteTransaction());
    try {
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(id)
          .delete()
          .then((value) {
        getAllTransactions();
        emit(DeleteTransactionSucces());
      });
    } on FirebaseException catch (e) {
      emit(DeleteTransactionFailed(message: '-------------${e.message}'));
    } catch (e) {
      print(e);
      emit(DeleteTransactionFailed(message: e.toString()));
    }
  }
}
