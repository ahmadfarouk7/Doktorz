import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradproject/Pages/doctor_upcomping_appointements.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/prescription_model.dart';
import 'package:gradproject/services/get_prescription.dart';

class PatientPreception extends StatefulWidget {
  const PatientPreception(
      {super.key, required this.id, required this.doctorImage});
  final String id;
  final String doctorImage;
  @override
  State<PatientPreception> createState() => _PatientPreceptionState();
}

List choosed = [true, false];

class _PatientPreceptionState extends State<PatientPreception> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PrescriptionModel>(
          future: Getprescription().getPrescription(doctorId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.network(
                    widget.doctorImage,
                    height: 260,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xffEFEFEF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            width: double.infinity,
                            child: Stack(
                              children: [
                                TwoOptionsStack(
                                  text: 'Medical',
                                  choosed: choosed[0],
                                  onTap: () {
                                    choosed[0] = true;
                                    choosed[1] = false;

                                    setState(() {});
                                  },
                                ),
                                Positioned(
                                  left: 117,
                                  child: TwoOptionsStack(
                                    text: 'Ptient Status',
                                    choosed: choosed[1],
                                    onTap: () {
                                      choosed[0] = false;
                                      choosed[1] = true;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          choosed[0]
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data!.medications.length,
                                    itemBuilder: (context, index) =>
                                        PatientMedicines(
                                      medi: snapshot.data!.medications[index],
                                    ),
                                  ),
                                )
                              : Column(children: [
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 22),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            FaIcon(
                                                FontAwesomeIcons.notesMedical),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Patient Status',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data!.status,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 22),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Column(
                                      children: [
                                        Row(
                                          children: [
                                            FaIcon(
                                                FontAwesomeIcons.stethoscope),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Doctor comments',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'no comment',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ])
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kColor,
                ),
              );
            }
          }),
    );
  }
}

class PatientMedicines extends StatelessWidget {
  const PatientMedicines({
    super.key,
    required this.medi,
  });
  final String medi;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/medicine.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              medi,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
