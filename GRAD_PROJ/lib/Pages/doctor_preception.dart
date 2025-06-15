import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradproject/Pages/doctor_upcomping_appointements.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/services/creat_prescription.dart';

class DoctorPreception extends StatefulWidget {
  const DoctorPreception(
      {super.key, required this.userID, required this.image});
  final String userID;
  final String image;
  @override
  State<DoctorPreception> createState() => _DoctorPreceptionState();
}

List choosed = [true, false];
String status = '';
String medi = '';
List medicine = [];
int numofMrdicine = 1;

class _DoctorPreceptionState extends State<DoctorPreception> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            widget.image,
            height: 250,
          ),
          Expanded(
            child: Container(
              color: const Color(0xffEFEFEF),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    choosed[0]
                        ? GestureDetector(
                            onTap: () {
                              numofMrdicine++;
                              medicine.add(medi);
                              for (int i = 0; i < medicine.length; i++) {
                                print(medicine[i]);
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 255,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xff3E8989),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'want to add any medican ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                width: 35,
                                decoration: BoxDecoration(
                                    color: const Color(0xff3E8989),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                width: 35,
                                decoration: BoxDecoration(
                                    color: const Color(0xff3E8989),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  size: 20,
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: numofMrdicine,
                            itemBuilder: (context, index) => const Medicine(),
                          )
                        : Column(children: [
                            Container(
                              width: double.infinity,
                              height: 150,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 22),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.notesMedical),
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
                                    // child: Text(
                                    //   "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the  1500s, when an unknown printer took",
                                    //   style: TextStyle(
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    // ),
                                    child: TextField(
                                      cursorColor: const Color(0xff3E8989),
                                      onChanged: (value) {
                                        status = value;
                                      },
                                      maxLines: 5,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Column(
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.stethoscope),
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
                                    child: TextField(
                                      cursorColor: Color(0xff3E8989),
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ])
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomButton(
              onTap: () async {
                medicine.add(medi);
                var data = await CreatPrescription().creatPrescription(
                  userID: widget.userID,
                  status: status,
                  medications: medicine,
                );
                if (data['status'] == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preception send successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              text: 'Send',
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class Medicine extends StatelessWidget {
  const Medicine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            child: TextField(
              cursorColor: const Color(0xff3E8989),
              onChanged: (value) {
                medi = value;
              },
              maxLines: 5,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }
}
