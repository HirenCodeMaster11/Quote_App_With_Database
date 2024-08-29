import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app_with_database/Controller/controller.dart';

import 'Component/themeList.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

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
            )),
        title: Text(
          'Themes',
          style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.07,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Text(
            'Unlock all',
            style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.056,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: w * 0.037,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 12),
          child: Column(
            children: [
              _buildCategoryRow('For you', plain, controller, context),
              _buildCategoryRow('Most Popular', popular, controller, context),
              _buildCategoryRow('Animated', animated, controller, context),
              _buildCategoryRow('Community', people, controller, context),
              _buildCategoryRow('Minimalism', minimalism, controller, context),
              _buildCategoryRow('Sports', sport, controller, context),
              _buildCategoryRow('Abstract', abstract, controller, context),
              _buildCategoryRow('Animal', animal, controller, context),
              _buildCategoryRow('Nature', nature, controller, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title, List<String> images, QuotesController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.068,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'View all',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.057,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                images.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.bgImage = images[index];
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(images[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }
}
