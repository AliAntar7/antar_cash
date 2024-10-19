import 'package:antar_cash/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:antar_cash/cubit/transaction_cubit/transaction_states.dart';
import 'package:antar_cash/widgets/number_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({super.key});
  TextEditingController amount = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController service = TextEditingController();
  TextEditingController note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit(),
      child: BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (context, state)
        {

        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('إضافة عملية '),
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: context.read<TransactionCubit>().isSelected,
                          color: Colors.blue,
                          selectedColor: Colors.white,
                          fillColor: Colors.blue,
                          constraints: const BoxConstraints(
                            minWidth: 168,
                            minHeight: 50,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          borderWidth: 1.5,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (int index)
                          {
                            context.read<TransactionCubit>().index = index;
                            context.read<TransactionCubit>().transactionType();
                            print(index);
                          },
                          children: const [
                            Text(
                              'إيداع',
                            ),
                            Text(
                              'تحويل',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NumberField(
                          controller: amount,
                          hintText: 'قد ايه المبلـغ',
                          prefixIcon: Icons.money,
                          onChanged: (value) {
                            amount.addListener(() {
                              // Convert amount to double, calculate fees and update the fees field
                              if (amount.text.isNotEmpty) {
                                int amountValue = int.parse(amount.text);
                                if (amountValue < 500)
                                {
                                  int calculatedFees =  5;
                                  fees.text = calculatedFees.toString(); // Update fees
                                } else {
                                  int calculatedFees =  (amountValue * 0.01).toInt();
                                  int roundedFees = ((calculatedFees + 4) ~/ 5) * 5;

                                  fees.text = roundedFees.toString(); // Update fees
                                  //fees.text = calculatedFees.toString(); // Update fees
                                }
                              } else {
                                fees.clear(); // Clear fees if amount is empty
                              }
                            });
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your amount';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: NumberField(
                                controller: fees,
                                hintText: 'الرسوم كام',
                                prefixIcon: Icons.percent_outlined,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: NumberField(
                                enabled: context.read<TransactionCubit>().index == 0 ? false : true,
                                controller: service,
                                hintText: context.read<TransactionCubit>().index == 0
                                    ? 'مفيش خدمة'
                                    : 'الخدمة كام ',
                                prefixIcon: Icons.balance_outlined,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: note,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your note';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5, color: Colors.black),
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5, color: Colors.black),
                            ),
                            hintText: 'حابب تضيف ملاحظة ؟',
                            prefixIcon: Icon(
                              Icons.comment,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            prefixIconColor: Colors.blue,
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async
                          {
                            // final uid = FirebaseAuth.instance.currentUser!.uid;
                            // final userData = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                            // final userName = userData['name'];
                            context.read<TransactionCubit>().addTransaction(
                              name: 'test',//userName,
                              amount: amount.text,
                              fees: fees.text,
                              service: service.text.isEmpty ? '0' : service.text,
                              note: note.text.isEmpty ? 'no note' : note.text,
                            );
                            amount.clear();
                            fees.clear();
                            service.clear();
                            note.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'إضافة',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
