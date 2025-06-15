import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Cash.dart';
import 'package:gradproject/Pages/pay_visa.dart';
import 'package:gradproject/Pages/voda_page.dart';
import 'package:gradproject/Widgets/Payment_button.dart';
import 'package:gradproject/services/payment_service.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage(
      {super.key,
      this.amount,
      required this.id,
      this.specialization,
      this.doctorName, this.data, this.time});
  final dynamic amount;
  final String id;
  final dynamic specialization;
  final dynamic doctorName;
  final dynamic data;
  final dynamic time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 200.0, top: 320),
            child: Image.asset(
              'assets/images/D.png',
              width: 160,
              height: 180,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      'assets/images/payment.png',
                      width: 265,
                      height: 290,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildButton(
                    text: 'Credit Card',
                    imagePath: 'assets/images/visa.png',
                    onPressed: () async {
                      dynamic payment =
                          await PaymentService().payment(id: id, amount: amount);
                      print(payment);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisaPay(payUrl: payment),
                      ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildButton(
                      text: 'Vodafone Cash',
                      imagePath: 'assets/images/vodafone.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const VodaPage()
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  buildButton(
                      text: 'Cash at the Clinic',
                      imagePath: 'assets/images/cash.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cash(
                              ticketPrice: amount,
                              specialize:specialization ,
                              doctorName: doctorName,
                              date: data,
                              time: time,
                            ),
                          ),
                        );
                      }),
                  Center(
                      child: Opacity(
                    opacity: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 160),
                      child: Image.asset(
                        'assets/images/D1.png',
                        width: 180,
                        height: 120,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
