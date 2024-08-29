import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/controller.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final QuotesController controller = Get.find<QuotesController>();

    return Scaffold(
      backgroundColor: Color(0xff242D3C),
      appBar: AppBar(
        backgroundColor: Color(0xff242D3C),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            size: w * 0.08,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Explore topics',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.07,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff344050),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     controller.randomQuote();
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 12),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           'Random quotes',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: w * 0.062,
                    //           ),
                    //         ),
                    //         Icon(
                    //           CupertinoIcons.right_chevron,
                    //           color: Colors.white,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Most Popular',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Love',
                  'Affirmation',
                  'Motivation',
                  'Deep',
                  'Positive thinking',
                  'Mental health',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Hard time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Sadness',
                  'Heartbroken',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Personal growth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Self-esteem',
                  'Positive thinking',
                  'Happiness',
                  'Gratitude',
                  'Ego',
                  'Mental health',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Calm down',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Hope',
                  'Patience',
                  'Smile',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Work & productivity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Success',
                  'Discipline',
                  'Smile',
                  'Loyalty',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Inspiration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.066,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildCategorySection(
                context,
                null,
                [
                  'Friendship',
                  'Kindness',
                  'Funny',
                ],
                controller,
              ),
              SizedBox(height: h * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      BuildContext context,
      String? title,
      List<String> categories,
      QuotesController controller,
      ) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (title != null)
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.066,
              fontWeight: FontWeight.w500,
            ),
          ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Color(0xff344050),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: categories.map((category) {
              return GestureDetector(
                onTap: () {
                  controller.selectCategory(category);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 12),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.062,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}