import 'package:flutter/material.dart';
import 'package:gradproject/Pages/ArticlesPage.dart';
import 'package:gradproject/Pages/patient_home.dart';
import 'package:gradproject/Widgets/articleWidget.dart';
import 'package:gradproject/models/aricleModel.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({super.key});
  final List<ArticleModel> categories = [
    ArticleModel(
        image: 'assets/heart.jpg',
        title: 'The Importance of Regular Exercise for Heart Health',
        subTitle:
            ' Learn why regular exercise is crucial for maintaining a healthy heart and reducing......'),
    ArticleModel(
        image: 'assets/Meditation.jpg',
        title: 'The Benefits of Mindfulness Meditation for Stress Reduction',
        subTitle:
            'Explore how mindfulness meditation can be an effective.....'),
    ArticleModel(
        image: 'assets/Vaccinations.png',
        title:
            'Understanding the Importance of Vaccinations for Disease Prevention',
        subTitle: ' Discover why vaccinations are crucial for preventing...'),
    ArticleModel(
        image: 'assets/sleeping.png',
        title:
            'The Importance of Getting Enough Sleep for Overall Health and Well-Being',
        subTitle:
            ' Learn why adequate sleep is essential for maintaining.....'),
    ArticleModel(
        image: 'assets/smoking.png',
        title: 'The Dangers of Smoking and How to Quit for Good',
        subTitle:
            ' Explore the health risks associated with smoking and discover ....'),
    ArticleModel(
        image: 'assets/style.jpg',
        title: 'Nutrition Tips for a Healthy Lifestyle',
        subTitle:
            ' Discover simple yet effective nutrition tips for maintaining...'),
    ArticleModel(
        image: 'assets/stress.jpg',
        title: 'The Role of Stress in Physical and Mental Health',
        subTitle:
            'Explore how chronic stress can impact both physical and mental....'),
    ArticleModel(
        image: 'assets/check.jpg',
        title: 'The Benefits of Regular Health Screenings and Check-Ups',
        subTitle: 'Learn why regular health screenings and check-ups ....'),
    ArticleModel(
        image: 'assets/mental.jpg',
        title: 'The Importance of Mental Health Awareness and Self-Care',
        subTitle:
            ' Discover why mental health awareness and self-care are essential for....'),
    ArticleModel(
        image: 'assets/food.png',
        title: 'The Role of Nutrition in Mental Health and Well-Being',
        subTitle:
            ' Explore the connection between diet and mental health and discover....'),
    ArticleModel(
        image: 'assets/pain.png',
        title: 'Tips for Managing Chronic Pain and Improving Quality of Life',
        subTitle:
            ' Learn effective strategies for coping with chronic pain and....'),
    ArticleModel(
        image: 'assets/Hypertension.png',
        title: 'Understanding Hypertension',
        subTitle:
            ' Learn about hypertension, commonly known as high blood pressure....'),
    ArticleModel(
        image: 'assets/sleep.png',
        title: 'Tips for Better Sleep',
        subTitle:
            ' Discover practical tips for improving the quality of your sleep, including ....'),
    ArticleModel(
        image: 'assets/infection-prevention-and-control.png',
        title: ' Preventing Infections and Illnesses',
        subTitle:
            'Learn about simple yet effective strategies for preventing infections and illnesses, including practicing....'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 27, 127, 116),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePatient(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 19,
            weight: 90,
          ),
        ),
        title: const Text(
          'Articles',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailsPage(article: categories[index]),
                ),
              );
            },
            child: ArtcileWidget(
              articleModel: categories[index],
            ),
          );
        },
      ),
    );
  }
}
