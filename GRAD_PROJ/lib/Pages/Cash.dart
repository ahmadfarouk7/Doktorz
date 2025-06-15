import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradproject/Pages/Pay_done.dart';

class Cash extends StatelessWidget {
  const Cash(
      {super.key,
      this.ticketPrice,
      required this.specialize,
      required this.doctorName, this.date, this.time});
  final dynamic ticketPrice;
  final dynamic specialize;
  final dynamic doctorName;
  final dynamic date;
  final dynamic time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 105,
                  ),
                  const Text(
                    'Cash',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('To book your appointment and pay'),
              const Text(' at the clinic'),
              const SizedBox(height: 50),
               Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    const Text('Doctor:'),
                    const SizedBox(width: 35),
                    Text(doctorName),
                  ],
                ),
              ),
              const SizedBox(height: 15),
               Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    const Text('Specialty:'),
                    const SizedBox(width: 20),
                    Text(specialize),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(right: 185.0),
                child: Text('Appointment Details'),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    const Text('Consultation Fee:'),
                    const SizedBox(width: 22),
                    Text('$ticketPrice'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    const Text('Appointment Time:'),
                    const SizedBox(width: 12),
                    Expanded(child: Text('$date $time')),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(right: 220.0),
                child: Text('Important Note'),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15),
                child: Text(
                    'A QR Code will be sent to your email. This QR Code is crucial and you will not be able to enter without it! , Please keep it. '),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 25, right: 25),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 225, 225, 225),
                    border: OutlineInputBorder(),
                    hintText: 'Your E-mail ',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('If you have any questions, please contact us'),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PayDone()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3E8989),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
