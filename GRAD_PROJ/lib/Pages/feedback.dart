// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gradproject/Pages/doctor_profile.dart';
import 'package:gradproject/Widgets/custom_button.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/review_model.dart';
import 'package:gradproject/services/get_all_review_service.dart';
import 'package:gradproject/services/post_review_service.dart';

class FeedBack extends StatefulWidget {
  const FeedBack(
      {super.key,
      required this.id,
      required this.name,
      required this.specialization,
      required this.image});
  final String id;
  final String name;
  final String specialization;
  final dynamic image;
  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool giveFeedback = false;
  TextEditingController review = TextEditingController();
  num rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 66,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(widget.image),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${widget.specialization},United States',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color(0xffBEBEBE))),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
                    child: CustomButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      text: 'About',
                      textcolor: const Color(0xff5C5C5C),
                      color: Colors.white,
                      width: 100,
                      radius: 5,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Feedback',
                    width: 100,
                    radius: 5,
                    color: const Color(0xff44A0A0),
                  ),
                ],
              ),
              if (!giveFeedback)
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    FutureBuilder<List<ReviewModel>>(
                        future:
                            GetAllReviewService().getAllReview(id: widget.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ReviewModel> reviews = snapshot.data!;
                            print(widget.id);
                            print(reviews.length);
                            return reviews.isEmpty
                                ? const Text('There is no Reviews')
                                : Column(
                                    children: [
                                      Text(
                                        'All Reviews(${reviews.length})',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: reviews.length,
                                        itemBuilder: (context, index) => Review(
                                          reviewModel: reviews[index],
                                        ),
                                      ),
                                    ],
                                  );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(color: kColor,));
                          }
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      onTap: () {
                        giveFeedback = true;
                        setState(() {});
                      },
                      text: 'Give your Feedback',
                      radius: 5,
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Rate your Experence',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_border,
                        color: Color(0xff44A0A0),
                      ),
                      onRatingUpdate: (rate) {
                        rating = rate;
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Share Your Feedback or Suggestion',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    TextFormField(
                      maxLines: 6,
                      controller: review,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Excellent Service!',
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color(0xffF4F4F4),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff44A0A0))),
                          child: CustomButton(
                            onTap: () {
                              giveFeedback = false;
                              setState(() {});
                            },
                            text: 'cancel',
                            textcolor: const Color(0xff44A0A0),
                            color: Colors.white,
                            width: 100,
                            radius: 5,
                          ),
                        ),
                        const Spacer(),
                        CustomButton(
                          onTap: () async {
                            var data = await PostReview().postReview(
                              id: widget.id,
                              review: review.text,
                              rating: rating,
                            );
                            print(kToken!);
                            print(widget.id);
                            if (data['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Review Added Succefully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              giveFeedback = false;
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(data['message']),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          text: 'post',
                          width: 100,
                          radius: 5,
                          color: const Color(0xff44A0A0),
                        ),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
