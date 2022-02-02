import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/review/widgets/review_card.dart';
import 'package:flutter/material.dart';

class ReviewView extends StatefulWidget {
  final University university;

  const ReviewView({
    Key? key,
    required this.university,
  }) : super(key: key);
  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: Column(
            children: [
              CustomBackButton(),
              HeroHeader(
                title: 'Bewertungen',
                isEnabled: false,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      ...widget.university.reviews
                          .map(
                            (review) => ReviewCard(
                              review: review,
                            ),
                          )
                          .toList(),
                      SizedBox(
                        height: sidePadding,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
