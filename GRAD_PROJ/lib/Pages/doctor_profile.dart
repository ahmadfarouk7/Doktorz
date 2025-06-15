import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradproject/Pages/book_appoin.dart';
import 'package:gradproject/Pages/feedback.dart';
import 'package:gradproject/Pages/update_doctor_profile.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/Widgets/image_profile.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/models/review_model.dart';
import 'package:gradproject/services/get_all_review_service.dart';
import 'package:gradproject/services/get_doctor_service.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        index: 3,
      ),
      body: FutureBuilder<GetDoctorModel>(
        future: GetDoctorService().getDoctor(id: id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            snapshot.data!.photo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    kRole == 'doctor'
                        ? Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width - 50,
                              top: 10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateDoctorProfile(
                                      profileImage: snapshot.data!.photo,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : const SizedBox(
                            width: 1,
                          )
                  ],
                ),
                Positioned(
                  top: 220,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.fullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Text(
                              '${snapshot.data!.specialization},${snapshot.data!.city}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Color(0xffBEBEBE))),
                          Row(
                            children: [
                              CustomListTile(
                                icon: Icons.location_on,
                                title:
                                    '${snapshot.data!.area},${snapshot.data!.city}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    color: Color(0xff626060)),
                              ),
                              const Spacer(),
                              CustomListTile(
                                  icon: Icons.phone,
                                  title: snapshot.data!.phoneNumber,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Doctorvisits(
                                text: 'Patient',
                                icon: Icons.people,
                                subText: '490+',
                              ),
                              Doctorvisits(
                                text: 'Experrience',
                                icon: Icons.verified,
                                subText:
                                    '${snapshot.data!.yearsExperience} Yrs',
                              ),
                              Doctorvisits(
                                text: 'Rating',
                                icon: Icons.star,
                                subText: '${snapshot.data!.ratingAverage}',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('About',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Color(0xffBEBEBE)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Availability',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Mon - Fri : 9:00am - 17.30pm",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Color(0xffBEBEBE)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Feedback   ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 12),
                              const Text('4.0    (185)'),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => FeedBack(
                                          id: id,
                                          image: snapshot.data!.photo,
                                          name: snapshot.data!.fullName,
                                          specialization:
                                              snapshot.data!.specialization),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(color: Color(0xff3d8888)),
                                ),
                              )
                            ],
                          ),
                          FutureBuilder<List<ReviewModel>>(
                              future:
                                  GetAllReviewService().getAllReview(id: id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<ReviewModel> reviews = snapshot.data!;
                                  print(id);
                                  print(reviews.length);
                                  return reviews.isEmpty
                                      ? const Text('There is no Reviews')
                                      : Review(
                                          reviewModel: reviews[0],
                                        );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: kColor,
                                  ));
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CustomButton(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookAppointement(
                                        id: id,
                                        ticketPrice: snapshot.data!.ticketPrice,
                                        doctorName: snapshot.data!.fullName,
                                        specialization:
                                            snapshot.data!.specialization,
                                      ),
                                    ),
                                  );
                                },
                                radius: 10,
                                text: 'Book Appointement',
                                color: const Color(0xff076363)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: kColor,
              ),
            );
          }
        },
      ),
    );
  }
}

class Review extends StatelessWidget {
  const Review({
    super.key,
    required this.reviewModel,
  });
  final ReviewModel reviewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 3,
            offset: Offset(3, 8),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(reviewModel.image),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  Text(
                    reviewModel.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: Color(0xff0F5A5A),
                    ),
                  ),
                  Text(
                    reviewModel.createdAt.substring(0, 10),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color(0xff444141),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              for (var i = 0; i < reviewModel.rating; i++)
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 13,
                ),
            ],
          ),
          Text(reviewModel.review,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }
}

class Doctorvisits extends StatelessWidget {
  const Doctorvisits({
    super.key,
    required this.text,
    required this.icon,
    required this.subText,
  });
  final String text;
  final IconData icon;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 3,
            offset: Offset(3, 8),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff626060)),
          ),
          Expanded(
            child: CustomListTile(
              icon: icon,
              title: subText,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.color = const Color(0xff3d8888),
    this.style = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xff626060)),
  });
  final IconData icon;
  final String title;
  final TextStyle style;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 19,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(title, style: style),
      ],
    );
  }
}
