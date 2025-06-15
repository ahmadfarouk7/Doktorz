import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradproject/Pages/ArticlesPage.dart';
import 'package:gradproject/Pages/all_doctors2%20(3).dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Pages/search.dart';
import 'package:gradproject/Widgets/articleWidget.dart';
import 'package:gradproject/Widgets/bottom_nav_bar.dart';
import 'package:gradproject/Widgets/drawer.dart';
import 'package:gradproject/Widgets/home_app_bar.dart';
import 'package:gradproject/models/aricleModel.dart';
import 'package:gradproject/models/get_doctor_model.dart';
import 'package:gradproject/models/get_user_model.dart';
import 'package:gradproject/pref.dart';
import 'package:gradproject/services/get_all_doctors_service.dart';
import 'package:gradproject/services/get_user_service.dart';
import 'package:gradproject/services/search_doctors.dart';

class HomePatient extends StatefulWidget {
  const HomePatient({Key? key}) : super(key: key);

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  final List<ArticleModel> categories = [
    ArticleModel(
      image: 'assets/images/heart.jpg',
      title: 'The Importance of Regular Exercise for Heart Health',
      subTitle:
          ' Learn why regular exercise is crucial for maintaining a healthy heart and reducing...',
    ),
    ArticleModel(
      image: 'assets/images/Meditation.jpg',
      title: 'The Benefits of Mindfulness Meditation for Stress Reduction',
      subTitle: 'Explore how mindfulness meditation can be an effective...',
    ),
    ArticleModel(
      image: 'assets/images/Vaccinations.png',
      title:
          'Understanding the Importance of Vaccinations for Disease Prevention',
      subTitle: ' Discover why vaccinations are crucial for preventing...',
    ),
    ArticleModel(
      image: 'assets/images/sleeping.png',
      title:
          'The Importance of Getting Enough Sleep for Overall Health and Well-Being',
      subTitle: ' Learn why adequate sleep is essential for maintaining...',
    ),
    ArticleModel(
      image: 'assets/images/smoking.png',
      title: 'The Dangers of Smoking and How to Quit for Good',
      subTitle:
          ' Explore the health risks associated with smoking and discover ...',
    ),
    ArticleModel(
      image: 'assets/images/style.jpg',
      title: 'Nutrition Tips for a Healthy Lifestyle',
      subTitle:
          ' Discover simple yet effective nutrition tips for maintaining...',
    ),
    ArticleModel(
      image: 'assets/images/stress.jpg',
      title: 'The Role of Stress in Physical and Mental Health',
      subTitle:
          'Explore how chronic stress can impact both physical and mental....',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String id;
    String name;
    return SafeArea(
      child: FutureBuilder<GetUserModel>(
          future: GetUserService().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Prefs.setString('pat_image', snapshot.data!.photo);
              return Scaffold(
                drawer: Drawer(
                  backgroundColor: const Color(0xff3d8888),
                  child: DrawerWidgets(
                    name: snapshot.data!.fullName,
                    image: snapshot.data!.photo,
                    email: snapshot.data!.email,
                  ),
                ),
                bottomNavigationBar: const BottomNavBar(
                  index: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
                    child: Column(
                      children: [
                        HomeAppBar(
                          image: snapshot.data!.photo,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const TextField(
                          cursorColor: Color.fromARGB(255, 73, 153, 153),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 9),
                            hintText: 'Search ...',
                            suffixIcon: Icon(
                              Icons.search,
                              size: 26,
                            ),
                            prefixIconColor: Color.fromARGB(255, 177, 177, 177),
                            filled: true,
                            fillColor: Color.fromARGB(255, 226, 226, 226),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 235, 235),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 200.h,
                              width: 450.w,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(222, 94, 183, 183),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 260.w,
                                bottom: 35.h,
                              ),
                              child: Image.asset(
                                'assets/images/doc.png',
                                height: 200.h,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, top: 55),
                              child: Text(
                                'Get rid of your pain now',
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 55.0, top: 100),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                child: Text(
                                  'Get a Doctor',
                                  style: TextStyle(
                                    color: const Color(0xFF42AAAA),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Suggested  Doctors',
                              style: TextStyle(
                                color: const Color(0xff3E8989),
                                fontSize: 18.sp,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AllDoctors2(),
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
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 700.h,
                          child: FutureBuilder<List<GetDoctorModel>>(
                              future: SerarchDoctorsService().searchDoctors(
                                  searchType: 'ticketPrice[gte]', value: 250),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<GetDoctorModel> doctors = snapshot.data!;

                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        id = doctors[index].id;
                                        name = doctors[index].fullName;
                                        print(id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Padding(
                                              padding: EdgeInsets.all(8.0.h),
                                              child: DoctorProfile(
                                                id: id,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: DoctorCard(
                                        doctorsModel: doctors[index],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30.0.h,
                            bottom: 2.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Articles',
                                style: TextStyle(
                                  color: const Color(0xff3E8989),
                                  fontSize: 18.sp,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => ArticlePage()),
                                  // );
                                },
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    color: const Color(0xff3E8989),
                                    fontSize: 16.sp,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0.w, left: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailsPage(
                                      article: categories[1]),
                                ),
                              );
                            },
                            child: ArtcileWidget(
                              articleModel: categories[1],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailsPage(article: categories[2]),
                              ),
                            );
                          },
                          child: ArtcileWidget(
                            articleModel: categories[2],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class Specialization extends StatelessWidget {
  const Specialization({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(222, 62, 137, 137),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          children: [
            Image.asset(
              image,
              fit: BoxFit.scaleDown,
              height: 60.h,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
