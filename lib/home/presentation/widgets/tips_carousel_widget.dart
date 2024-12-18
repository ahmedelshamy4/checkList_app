import 'package:carousel_slider/carousel_slider.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TipsCarouselWidget extends StatelessWidget {
  TipsCarouselWidget({super.key});

  final List<TipsCarouselEntity> carouselItems = [
    TipsCarouselEntity(
      title:
          "Each phase plays a critical role in the success of your mobile app.",
      text:
          "Skipping any step can lead to issues down the road. Take your time and do it right!",
    ),
    const TipsCarouselEntity(
      title: "Success in mobile app development",
      text: "requires a focus on UX",
    ),
    const TipsCarouselEntity(
      title: "Success in mobile app development",
      text: "performance, and security",
    ),
    const TipsCarouselEntity(
      title: "Define Clear Goals",
      text: "Know what you want to achieve.",
    ),
    const TipsCarouselEntity(
        title: "Focus on User Experience",
        text: "Design with your users in mind."),
    const TipsCarouselEntity(
        title: "Embrace Agile Methodology",
        text: "Stay flexible and responsive to changes."),
    const TipsCarouselEntity(
        title: "User Stories",
        text: "Create user stories to define user needs and scenarios."),
    const TipsCarouselEntity(
        title: "Test Early and Often", text: "Identify issues before launch."),
    const TipsCarouselEntity(
        title: "Plan for Scalability",
        text: "Design for future growth from day one."),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.large),
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.width * 0.3,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: false,
          initialPage: 0,
        ),
        items: carouselItems.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.mediumGrey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: PaddingDimensions.large),
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyles.ralewayFont20SemiBold(context),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        item.text,
                        style: AppTextStyles.nunitoFont16Regular(context,
                            color: AppColors.blackColor),
                        textAlign: TextAlign.center,
                      ),
                      // const Gap(PaddingDimensions.large),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   height:  MediaQuery.of(context).size.width * 0.2,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //     image: const AssetImage(
                      //         "assets/images/mobile_engineering_image.png"),
                      //     fit: BoxFit.cover,
                      //   )),
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class TipsCarouselEntity extends Equatable {
  final String title;
  final String text;

  const TipsCarouselEntity({
    required this.title,
    required this.text,
  });

  @override
  List<Object?> get props => [
        title,
        text,
      ];
}
