import 'package:antar_cash/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:antar_cash/cubit/transaction_cubit/transaction_states.dart';
import 'package:antar_cash/screens/add_transaction_screen.dart';
import 'package:antar_cash/screens/profile_screen.dart';
import 'package:antar_cash/screens/statistics_screen.dart';
import 'package:antar_cash/widgets/transactions_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as showDateFormat;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit()..getAllTransactions(),
      child: BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (context, state) {
          if (state is TransactionAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transaction added successfully.'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is TransactionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingToGetAllTransaction
              || state is LoadingToDeleteTransaction) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetAllTransactionSucces) {
            initializeDateFormatting('ar', null);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: const Text('جميع العمليات'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StatisticsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<TransactionCubit>().getAllTransactions();
                          },
                          child: ListView.builder(
                            itemCount: state.transactionsList.length,
                            itemBuilder: (context, index) {
                              final transaction = state.transactionsList[index];
                              return Dismissible(
                                key: Key(transaction.id),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  context.read<TransactionCubit>().deleteTransaction(transaction.id);
                                  state.transactionsList.removeAt(index);
                                },
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'حذف العملية ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: 'changa_regular',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                child: TransactionsCard(
                                  id: transaction.id,
                                  userName: transaction['user_name'],
                                  amount: transaction['amount'],
                                  fees: transaction['fees'],
                                  service: transaction['service'],
                                  note: transaction['note'],
                                  type: transaction['type'],
                                  date: showDateFormat.DateFormat('EEE hh:mm a','ar').format(
                                      (transaction['date'] as Timestamp)
                                          .toDate()),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTransactionScreen(),
                        ));
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            );
          } else if (state is GetAllTransactionFailed) {
            return const Center(
              child: Text('Failed to get transactions.'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
