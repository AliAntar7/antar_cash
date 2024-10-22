import 'package:antar_cash/cubit/calculate_cubit/calculate_cubit.dart';
import 'package:antar_cash/cubit/calculate_cubit/calculate_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPerDayScreen extends StatelessWidget {
  const TransactionsPerDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
              'الإحصائيات حسب اليوم',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: 'changa_regular',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => CalculateCubit()..getTransactionsGroupedByDay(),
          child: BlocConsumer<CalculateCubit, CalculateStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingToGetAllTransaction) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetTransactionsGroupedByDaySuccess) {
                return Column(
                  children: [
                    Text(
                      'إجمالي الحركة: ${context.read<CalculateCubit>().totalLockOfAllDays}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.infoOfEachDay.length,
                      itemBuilder: (context, index) {
                        final day = state.infoOfEachDay.keys.elementAt(index);
                        final infoOfEachDay = state.infoOfEachDay[day]!;
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
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'حركة اليوم: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalAmount'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'إجمالي التحويلات: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalAmountOfTransfers'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'إجمالي الإيداعات: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalAmountOfDeposits'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'إجمالي الأرباح: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalFees'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'إجمالي الخدمة: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalService'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'تقفيلة التحويلات: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalLockOfTransfers'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'تقفيلة الإيدعات: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['totalLockOfDeposits'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'تقسمية الأرباح: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              infoOfEachDay['halfOfTotalFees'].toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'تقفيلة اليوم: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'changa_regular',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            infoOfEachDay['totalLockOfTheDay']! < 0 ? Text(
                                              'مدان بـ ${infoOfEachDay['totalLockOfTheDay'].toString()}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ) : Text(
                                              'مدين بـ ${infoOfEachDay['totalLockOfTheDay'].toString()}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'changa_regular',
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
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
                                  day,
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
                  ],
                );
              } else if (state is GetAllTransactionFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('Failed to get transactions'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
