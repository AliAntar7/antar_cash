import 'package:flutter/material.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
    required this.userName,
    required this.amount,
    required this.date,
    required this.type,
    this.note,
    required this.fees,
    this.service,
  });

  final String userName;
  final String amount;
  final String date;
  final String type;
  final String? note;
  final String fees;
  final String? service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text(
                    'تفاصيل العملية',
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
                          'اسم الموظف : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'changa_regular',
                              color: Colors.red,
                            ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'قيمة المبلغ : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$amount ج ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'نوع العملية : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'رسوم : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          fees,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'خدمة : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          service ?? 'لا يوجد',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'ملاحظة : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          note ?? 'لا يوجد',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'وقت العملية : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'changa_regular',
                            color: Colors.red,
                          ),
                        ),
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            child: ListTile(
              title: Row(
                children: [
                  const Text(
                    'اسم الموظف : ',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'changa_regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'changa_regular',
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  const Text(
                    'نوع العملية : ',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'changa_regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'changa_regular',
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '$amount ج ',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'changa_regular',
                  color: type == 'تحويل' ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }
}
