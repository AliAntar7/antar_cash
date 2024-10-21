import 'package:antar_cash/cubit/calculate_cubit/calculate_cubit.dart';
import 'package:antar_cash/cubit/calculate_cubit/calculate_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateCubit()..calculateTotalAllTransaction(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'إحصائيات الشهر',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'changa_regular',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: BlocBuilder<CalculateCubit, CalculateStates>(
            builder: (context, state) {
              if (state is CalculatingTotalAmount) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CalculatedTotalAmount) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/all_transactions.png'),
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'حركة الشهر  ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'changa_regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${context.read<CalculateCubit>().totalAmount.toString()} ج.م ',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'changa_regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/transfers.png'),
                                      height: 80,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'إجمالي التحويلات ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${context.read<CalculateCubit>().totalAmountOfTransfers.toString()} ج.م ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/deposits.png'),
                                      height: 80,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'إجمالي الإيداعات ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${context.read<CalculateCubit>().totalAmountOfDeposits.toString()} ج.م ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/fees.png'),
                                      height: 80,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'إجمالي الأرباح ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${context.read<CalculateCubit>().totalFees.toString()} ج.م ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/service.png'),
                                      height: 80,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'إجمالي الخدمة ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${context.read<CalculateCubit>().totalService.toString()} ج.م ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'changa_regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is CalculateTotalAmountFailed) {
                return Scaffold(
                  body: Center(
                    child: Text(state.message),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
