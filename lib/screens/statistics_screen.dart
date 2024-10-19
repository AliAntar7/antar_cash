import 'package:antar_cash/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:antar_cash/cubit/transaction_cubit/transaction_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => TransactionCubit()..calculateTotalAllTransaction(),
  child: BlocBuilder<TransactionCubit, TransactionStates>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text('الإحصائيات'),
            ),
            body: Column(
              children: [
                Text(
                  'إجمالي الأموال: ${context.read<TransactionCubit>().totalAmount.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'إجمالي الأموال: ${context.read<TransactionCubit>().totalService.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'إجمالي الأموال: ${context.read<TransactionCubit>().totalFees.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
);
  }
}
