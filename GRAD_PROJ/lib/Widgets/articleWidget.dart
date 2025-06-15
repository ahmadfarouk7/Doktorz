import 'package:flutter/material.dart';
import 'package:gradproject/models/aricleModel.dart';

class ArtcileWidget extends StatelessWidget {
  const ArtcileWidget({
    super.key,
    required this.articleModel,
  });
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                child: GestureDetector(
                  child: Container(
                    height: 110, // Height of the photo container
                    width: 100, // Width of the photo container
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      image: DecorationImage(
                        image: AssetImage(
                            articleModel.image!), // Placeholder image
                        fit: BoxFit.cover, // Cover the entire container
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  width: 16), // Add spacing between the photo and description
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        articleModel.title!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        articleModel.subTitle!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18, right: 18),
          child: Divider(
            color: Colors.black26,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
