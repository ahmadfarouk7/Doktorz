// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/Pages/update_doctor_profile2.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/days_appoin_model.dart';
import 'package:gradproject/services/create_avilable_time.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDoctorProfile extends StatefulWidget {
  const UpdateDoctorProfile({super.key, required this.profileImage});
  final dynamic profileImage;
  @override
  State<UpdateDoctorProfile> createState() => _UpdateDoctorProfileState();
}

class _UpdateDoctorProfileState extends State<UpdateDoctorProfile> {
  dynamic choosen;
  List specialist = [
    'Cardiology',
    'Dermatology',
    'Orthopedics',
    'Oncology',
    'Neurology',
    'Pediatrics',
    'Gynecology',
    'Psychiatry',
    'Endocrinology',
    'Urology',
  ];
  List days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  var chooseDay;
  late Cloudinary cloudinary;
  @override
  void initState() {
    super.initState();
    cloudinary = Cloudinary.signedConfig(
      apiKey: '939799869145548',
      apiSecret: 'eFzHNda-ovMHLPhXCkG0lrKup_M',
      cloudName: 'dah8fxqsr',
    );
  }

  String? start;
  String? end;
  String? max;
  String? yExp;
  int addAppoin = 1;
  List<dynamic> daysAppointement = [];
  TextEditingController price = TextEditingController();
  String imageUrl = '';
  String about = '';
  String specilization = '';
  String address = '';
  String hospital = '';
  dynamic ticketPrice;
  @override
  Widget build(BuildContext context) {
    XFile? image;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 3,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back')),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                width: 100,
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (image != null) {
                                    final response = await cloudinary.upload(
                                      file: image!.path,
                                      resourceType:
                                          CloudinaryResourceType.image,
                                    );
                                    setState(() {
                                      imageUrl = response.secureUrl!;
                                    });
                                  }
                                  print(imageUrl);
                                },
                                text: 'Take Photo',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                width: 100,
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    final response = await cloudinary.upload(
                                      file: image!.path,
                                      resourceType:
                                          CloudinaryResourceType.image,
                                    );

                                    setState(() {
                                      imageUrl = response.secureUrl!;
                                    });
                                  }
                                  print(imageUrl);
                                },
                                text: 'Upload Photo',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.profileImage),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(kName),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                onChanged: (value) {
                  about = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffE7E7E7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'About',
                  labelStyle: const TextStyle(
                    color: Color(0xff125D5D),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Specialization',
                          style: TextStyle(
                            color: Color(0xff455A64),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButton(
                            hint: const Text(
                              'choose',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            underline: const SizedBox(),
                            value: choosen,
                            onChanged: (value) {
                              setState(() {
                                choosen = value;
                              });
                              print(choosen);
                            },
                            items: specialist.map((itemVlaue) {
                              return DropdownMenuItem(
                                value: itemVlaue,
                                child: Text(
                                  itemVlaue,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: TextFieldNumb(
                      onChanged: (value) {
                        ticketPrice = value;
                      },
                      label: 'Ticket Price',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFieldNumb(
                      label: 'Experencen',
                      onChanged: (value) {
                        yExp = value;
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  TextFieldNumb(
                    label: 'Waiting',
                    onChanged: (value) {
                      max = value;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Appointements',
                    style: TextStyle(
                        color: Color(0xff0F5A5A),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () {
                      daysAppointement.add(DaysAppointement(
                              dayOfWeek: chooseDay,
                              startTime: start,
                              endTime: end)
                          .toJson());
                      // for (int i = 0; i < daysAppointement.length; i++)
                      //   print(daysAppointement[i].startWorkingTime);
                      addAppoin++;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: addAppoin,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Days',
                              style: TextStyle(
                                color: Color(0xff455A64),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              height: 30,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: DropdownButton(
                                hint: const Text(
                                  'choose',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                underline: const SizedBox(),
                                value: chooseDay,
                                onChanged: (value) {
                                  setState(() {
                                    chooseDay = value;
                                    //days.remove(value);
                                  });
                                  print(chooseDay);
                                },
                                items: days.map((itemVlaue) {
                                  return DropdownMenuItem(
                                    value: itemVlaue,
                                    child: Text(
                                      itemVlaue,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 9,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFieldNumb(
                            onChanged: (value) {
                              start = value;
                            },
                            label: 'Starting Time',
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFieldNumb(
                            onChanged: (value) {
                              end = value;
                            },
                            label: 'Ending Time',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DoctorProfileDetails(
                onChanged: (value) {
                  address = value;
                },
                label: 'Locations of the Clinic',
              ),
              const SizedBox(
                height: 15,
              ),
              DoctorProfileDetails(
                label: 'Hospital',
                onChanged: (value) {
                  hospital = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  onTap: () async {
                    daysAppointement.add(DaysAppointement(
                      dayOfWeek: chooseDay,
                      startTime: start,
                      endTime: end,
                    ).toJson());
                    var data = await CreateAvilableTime().createAvilableTime(
                      slotDuration: int.parse(max!),
                      availability: daysAppointement,
                    );
                    print(data);
                    if (data['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(data['message']),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(data['message']),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    dynamic doctorData = {
                      'image': imageUrl,
                      'specialization': choosen,
                      'about': about,
                      'ticketPrice': ticketPrice,
                      'address': address,
                      'hospital': hospital,
                      'yearsExperience':yExp,
                    };
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ContinueUpdateDoctor(
                          doctorData: doctorData,
                        ),
                      ),
                    );
                  },
                  text: 'Continue',
                  radius: 10,
                  color: const Color(0xff3DA7A7),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldNumb extends StatelessWidget {
  const TextFieldNumb({
    super.key,
    required this.label,
    this.icon = false,
    this.onChanged,
  });
  final String label;
  final bool icon;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff455A64),
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(3),
          height: 30,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            onChanged: onChanged,
            cursorHeight: 16,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorProfileDetails extends StatelessWidget {
  const DoctorProfileDetails({
    super.key,
    required this.label,
    this.value = '',
    this.onChanged,
  });
  final String label;
  final String value;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff455A64),
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            helperText: value,
            filled: true,
            fillColor: const Color(0xffE7E7E7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class AppointChoose extends StatefulWidget {
  const AppointChoose({super.key});

  @override
  State<AppointChoose> createState() => _AppointChooseState();
}

class _AppointChooseState extends State<AppointChoose> {
  List days = [
    'SUNDAY',
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
  ];
  var chooseDay;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Days',
                style: TextStyle(
                  color: Color(0xff455A64),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(3),
                height: 30,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButton(
                  hint: const Text(
                    'choose',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  underline: const SizedBox(),
                  value: chooseDay,
                  onChanged: (value) {
                    setState(() {
                      chooseDay = value;
                      //days.remove(value);
                    });
                    print(chooseDay);
                  },
                  items: days.map((itemVlaue) {
                    return DropdownMenuItem(
                      value: itemVlaue,
                      child: Text(
                        itemVlaue,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          const TextFieldNumb(
            label: 'Starting Time',
          ),
          const SizedBox(
            width: 5,
          ),
          const TextFieldNumb(
            label: 'Ending Time',
          ),
        ],
      ),
    );
  }
}
