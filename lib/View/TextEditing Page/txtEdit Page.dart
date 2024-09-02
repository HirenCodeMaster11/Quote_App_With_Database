import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../Controller/controller.dart';
import '../../utils/font family.dart';
import '../../utils/textColor.dart';

class TextEditingPage extends StatelessWidget {
  const TextEditingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final QuotesController controller = Get.find<QuotesController>();

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
          'Edit quote text',
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.07,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02),
              Text(
                'Edit text font',
                style: TextStyle(color: Colors.white, fontSize: w * 0.066),
              ),
              SizedBox(height: h * 0.02),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: fonts.map((fontMap) {
                  String fontName = fontMap.keys.first;
                  TextStyle fontStyle = fontMap[fontName]!;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedFont = fontStyle;
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0,bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  fontName,
                                  style: fontStyle.copyWith(
                                    fontSize: w * 0.05,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Edit text color',
                style: TextStyle(color: Colors.white, fontSize: w * 0.066),
              ),
              SizedBox(height: h * 0.02),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: colors.map((colorMap) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectedColor = colorMap['color'];
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0,bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                colorMap['name'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: w * 0.05),
                              ),
                              SizedBox(width: w * 0.02),
                              Container(
                                height: h * 0.0248,
                                width: w * 0.051,
                                decoration: BoxDecoration(
                                  color: colorMap['color'],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: h * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
