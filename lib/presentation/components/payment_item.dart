import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasiya_app/data/model/payment_model.dart';

class PaymentItem extends StatelessWidget {
  final PaymentModel? paymentModel;

  const PaymentItem({
    super.key,
    required this.paymentModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
              onTap: () {

              },
              leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('assets/icons/payment.png'),
                  )
              ),
              title: Text('${paymentModel?.client}'),
              subtitle: Text('To\'ladi: ${NumberFormat.currency(locale: 'uz').format(paymentModel?.quantity).substring(0, NumberFormat.currency(locale: 'uz').format(paymentModel?.quantity).length - 7)} ${paymentModel?.moneyType}')
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16
              ),
              child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26
              )
          )
        ]
    );
  }
}
