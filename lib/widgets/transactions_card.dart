import 'package:flutter/material.dart';

class TransactionsCard extends StatelessWidget {
  const TransactionsCard({
    super.key,
    required this.userName,
    required this.amount,
    required this.date,
    required this.type,
    required this.id,
    this.note,
    required this.fees,
    this.service,
  });

  final String id;
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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 20,
                ),
                Text(
                  ' $userName',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'changa_regular',
                    color: Colors.black87,
                  ),
                ),
                const Spacer(
                  flex: 12,
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.black87,
                  size: 20,
                ),
                Text(
                  ' $date',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'changa_regular',
                    color: Colors.black87,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.7,
                    color: Colors.black.withOpacity(0.7),
                ),
                borderRadius: BorderRadius.circular(30),
                color: type == 'تحويل' ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              ),
              child: Row(
                children:
                [
                  Image(
                    image: type == 'تحويل' ? const AssetImage('assets/images/red_arrow.png') : const AssetImage('assets/images/green_arrow.png'),
                    height: 40,
                    width: 40,
                  ),
                  const Spacer(),
                  Text(
                    '$amount ج.م',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'changa_regular',
                      fontWeight: FontWeight.bold,
                      color: type == 'تحويل' ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
