import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app_with_database/Modal/modal.dart';

import '../Home Page/home.dart';

class LikedQuotesScreen extends StatelessWidget {
  const LikedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff242D3C),
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
          'Explore Favorite quotes',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.07,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                if (controller.likedQuotes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favourite quotes added yet.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                }

                // Group quotes by category
                Map<String, List<QuoteModal>> groupedQuotes = {};
                for (var quote in controller.likedQuotes) {
                  if (groupedQuotes.containsKey(quote.category)) {
                    groupedQuotes[quote.category]!.add(quote);
                  } else {
                    groupedQuotes[quote.category] = [quote];
                  }
                }

                return ListView.builder(
                  itemCount: groupedQuotes.keys.length,
                  itemBuilder: (context, index) {
                    String category = groupedQuotes.keys.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black38,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            backgroundColor: Color(0xff344050).withOpacity(0.4),
                            collapsedBackgroundColor:
                                Color(0xff344050),
                            title: Text(
                              category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_drop_down,color: Colors.white,),
                            children: groupedQuotes[category]!.map((quote) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Color(0xff344050).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff344050).withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    quote.quote,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black38,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Text(
                                    '- ${quote.author}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.deleteFavouriteQuotes(quote.id!);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
