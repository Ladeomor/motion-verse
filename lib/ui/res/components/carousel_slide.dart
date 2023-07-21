import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:montion_verse/view_models/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ThemeProvider themeProvider, child) {
          return Container(
            height: 150.0,
            child: ListView(
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(image: AssetImage(
                                'assets/images/carousel_image_one.jpg'),
                              fit: BoxFit.cover,
                            )

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(image: AssetImage(
                                'assets/images/carousel_image_two.jpg'),
                              fit: BoxFit.cover,
                            )

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(image: AssetImage(
                                'assets/images/carousel_image_three.jpg'),
                              fit: BoxFit.cover,
                            )

                        ),
                      )
                    ], options: CarouselOptions(
                      height: 150.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 500),
                      viewportFraction: 0.7
                  ),
                  )
                ]
            ),
          );
        }
    );
  }
}
