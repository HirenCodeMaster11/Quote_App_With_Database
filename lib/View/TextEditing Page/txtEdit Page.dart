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
                children: fonts.map((fontMap) {
                  String fontName = fontMap.keys.first;
                  TextStyle fontStyle = fontMap[fontName]!;
                  return GestureDetector(
                    onTap: () {
                      controller.selectedFont = fontStyle;
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                              Text(
                                fontName,
                                style: fontStyle.copyWith(
                                  fontSize: w * 0.05,
                                  color: Colors.white,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Text(
                              'Pick Color',
                              style: TextStyle(fontSize: 20),
                            ),
                            children: [
                              HueRingPicker(
                                pickerColor: controller.selectedColor,
                                onColorChanged: (value) {
                                  controller.selectedColor = value;
                                },
                              ),
                              Align(
                                  alignment:
                                  Alignment.bottomRight,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        right: 20.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20),
                                        ),),
                                  ),),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(

                            shape: BoxShape.circle),
                      ),
                    ),
                    InkWell(
                        onTap: () {

                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: controller.selectedColor,
                              shape: BoxShape.circle),
                        ),
                      ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: colors.map((colorMap) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectedColor = colorMap['color'];
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
