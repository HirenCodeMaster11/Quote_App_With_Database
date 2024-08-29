import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app_with_database/Controller/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;

    final QuotesController controller = Get.find<QuotesController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (controller.quotes.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        else {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.quotes.length,
            itemBuilder: (context, index) {
              final quote = controller.quotes[index];
              return Stack(
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(controller.bgImage),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quote.category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.1,
                              ),
                            ),
                            SizedBox(height: h * 0.04),
                            Text(
                              quote.quote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.096,
                              ),
                            ),
                            SizedBox(height: h * 0.03),
                            Text(
                              quote.author,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.shantellSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.08,
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.1),
                            GestureDetector(
                              onTap: () {
                                // Add functionality for like button
                                // Example: controller.likeQuote(quote);
                              },
                              child: Icon(
                                Icons.favorite_border,
                                size: w * 0.1,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 38, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 1,
              backgroundColor: const Color(0xff404040),
              onPressed: () {
                Get.toNamed('/cat');
              },
              child: Icon(Icons.search, color: Colors.white, size: w * 0.078),
            ),
            SizedBox(width: w * 0.005),
            FloatingActionButton(
              heroTag: 2,
              backgroundColor: const Color(0xff404040),
              onPressed: () {
                Get.toNamed('/theme');
              },
              child: Icon(Icons.imagesearch_roller_outlined,
                  color: Colors.white, size: w * 0.078),
            ),
            SizedBox(width: w * 0.005),
            FloatingActionButton(
              heroTag: 3,
              backgroundColor: const Color(0xff404040),
              onPressed: () {
                // Add functionality or navigation for this button
              },
              child: Icon(
                Icons.text_fields_outlined,
                color: Colors.white,
                size: w * 0.078,
              ),
            ),
          ],
        ),
      ),
    );
  }
}