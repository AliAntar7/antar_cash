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
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('transactions')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!.docs;
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
                              builder: (context) => StatisticsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  body: BlocConsumer<TransactionCubit, TransactionStates>(
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
                      if (state is LoadingToGetAllTransaction) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetAllTransactionSucces) {
                        initializeDateFormatting('ar', null);
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    return TransactionsCard(
                                      userName: 'test',//documents[index]['user_name'],
                                      amount: documents[index]['amount'],
                                      type: documents[index]['type'],
                                      date: showDateFormat.DateFormat('EEE hh:mm a','ar').format(
                                          (documents[index]['date'] as Timestamp)
                                              .toDate()),
                                      note: documents[index]['note'],
                                      fees: documents[index]['fees'],
                                      service: documents[index]['service'],
                                    );
                                  },
                                ),
                              ),
                            ],
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
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
