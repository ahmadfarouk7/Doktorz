import 'package:flutter/material.dart';
import 'package:gradproject/models/aricleModel.dart';

class ArticleDetailsPage extends StatelessWidget {
  final ArticleModel article;

  const ArticleDetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 144, 142, 142), // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                ),
                child: Image.asset(
                  article.image!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                article.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Regular physical activity is essential for maintaining good health, especially when it comes to heart health. Engaging in regular exercise can significantly reduce the risk of developing heart diseases such as heart attacks, strokes, and high blood pressure. Exercise helps to strengthen the heart muscle, improve circulation, and lower cholesterol levels, all of which are essential for maintaining cardiovascular health. According to the American Heart Association, adults should aim for at least 150 minutes of moderate-intensity exercise or 75 minutes of vigorous-intensity exercise per week. This can include activities such as brisk walking, jogging, cycling, swimming, or dancing. Additionally, incorporating strength training exercises into your routine can help to build muscle mass and improve overall fitness Remember to consult with your doctor before starting any new exercise program, especially if you have any pre-existing health conditions. Start slowly and gradually increase the intensity and duration of your workouts as your fitness level improves. By making regular exercise a priority, you can help protect your heart and enjoy better overall health.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 133, 133, 133),
                ),
              ),
              const SizedBox(
                height: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
