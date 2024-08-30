import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/controller.dart';
import '../../Modal/modal.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final QuotesController controller = Get.find<QuotesController>();
    return Scaffold(
      backgroundColor: Color(0xff242D3C),
      appBar: AppBar(
        backgroundColor: const Color(0xff242D3C),
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
          'Explore favorite quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.07,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.likedQuotes.isEmpty) {
          return Center(
            child: Text(
              'No liked quotes',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        } else {
          var quotesByCategory = controller.likedQuotesByCategory;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: quotesByCategory.keys.length,
              itemBuilder: (context, index) {
                var category = quotesByCategory.keys.elementAt(index);
                var quotes = quotesByCategory[category]!;
                return Card(
                  color: Color(0xff344050),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: OpenContainer(
                    transitionDuration: Duration(milliseconds: 500),
                    openBuilder: (context, _) => FavoriteDetailPage(
                        category: category, quotes: quotes),
                    closedElevation: 0,
                    openColor: Color(0xff344050),
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    closedColor: Theme.of(context).cardColor,
                    closedBuilder: (context, openContainer) => ListTile(
                      title: Text(
                        category,
                        style: controller.selectedFont.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                      onTap: openContainer,
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}

class FavoriteDetailPage extends StatelessWidget {
  final String category;
  final List<QuoteModal> quotes;

  const FavoriteDetailPage({
    super.key,
    required this.category,
    required this.quotes,
  });

  @override
  Widget build(BuildContext context) {
    final QuotesController controller = Get.find<QuotesController>();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              controller.bgImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close,
                          size: w * 0.08,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: w * 0.1),
                      Text(
                        'My favorites',
                        style: controller.selectedFont.copyWith(
                          color: Colors.white,
                          fontSize: w * 0.07,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      final quote = quotes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quote.category,
                              style: controller.selectedFont.copyWith(
                                color: Colors.white,
                                fontSize: w * 0.1,
                              ),
                            ),
                            SizedBox(height: h * 0.04),
                            Text(
                              quote.quote,
                              textAlign: TextAlign.center,
                              style: controller.selectedFont.copyWith(
                                color: Colors.white,
                                fontSize: w * 0.096,
                              ),
                            ),
                            SizedBox(height: h * 0.03),
                            Text(
                              quote.author,
                              textAlign: TextAlign.center,
                              style: controller.selectedFont.copyWith(
                                color: Colors.white,
                                fontSize: w * 0.08,
                              ),
                            ),
                            SizedBox(height: h * 0.1),
                            GestureDetector(
                              onTap: () {
                                controller.toggleLike(quote, controller.likedQuotes.indexOf(quote));
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.delete,
                                size: w * 0.1,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
