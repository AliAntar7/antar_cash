import 'package:antar_cash/cubit/calculate_cubit/calculate_cubit.dart';
import 'package:antar_cash/cubit/calculate_cubit/calculate_states.dart';
import 'package:antar_cash/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:antar_cash/screens/add_transaction_screen.dart';
import 'package:antar_cash/screens/profile_screen.dart';
import 'package:antar_cash/screens/statistics_screen.dart';
import 'package:antar_cash/widgets/transactions_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as showDateFormat;

import 'transactions_per_day_screen.dart';

class AllTransactionsDay extends StatelessWidget {
  const AllTransactionsDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateCubit()..getTransactionsGroupedByDay(),
      child: BlocConsumer<CalculateCubit, CalculateStates>(
        listener: (context, state) {
          if (state is GetTransactionsGroupedByDayFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingToGetTransactionsGroupedByDay) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is getTransactionsGroupedByDaySuccess) {
            initializeDateFormatting('ar', null);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: const Text('جميع العمليات'),
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
                            itemCount: state.transactionsByDay.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: const Text(
                                            'تفاصيل اليوم',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'changa_regular',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Container(
                                            height: MediaQuery.of(context).size.height * 0.8,
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              //physics: const NeverScrollableScrollPhysics(),
                                              itemCount: state.transactionsByDay.values.elementAt(index).length,
                                              itemBuilder: (context, i) {
                                                return TransactionsCard(
                                                  id: state.transactionsByDay.values.elementAt(index)[i].id,
                                                  type:  state.transactionsByDay.values.elementAt(index)[i]['type'],
                                                  amount: state.transactionsByDay.values.elementAt(index)[i]['amount'],
                                                  fees: state.transactionsByDay.values.elementAt(index)[i]['fees'],
                                                  service: state.transactionsByDay.values.elementAt(index)[i]['service'],
                                                  note: state.transactionsByDay.values.elementAt(index)[i]['note'],
                                                  date: showDateFormat.DateFormat.yMMMd('ar').format(state.transactionsByDay.values.elementAt(index)[i]['date'].toDate()),
                                                  userName: state.transactionsByDay.values.elementAt(index)[i]['user_name'],
                                                );
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'إغلاق',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'changa_regular',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue.withOpacity(0.3),
                                  ),
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/all_transactions.png'),
                                        height: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        state.transactionsByDay.keys.elementAt(index),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
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
          } else if (state is GetTransactionsGroupedByDayFailed) {
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
