import 'package:appflug/constants/box_decoration.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/classes/review.dart';
import 'package:appflug/shared_utils/url_launch_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'category_review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: EdgeInsets.all(
            15,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Gesamt:',
                    style: AppTextStyles.montserratH5SemiBold,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    height: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    review.average.toString(),
                    style: AppTextStyles.montserratH5SemiBold,
                  ),
                  Spacer(),
                  Text(
                    DateFormat('dd.MM.yyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        review.addedAtInMilliSecondsSinceEpoch!,
                      ),
                    ),
                    style: AppTextStyles.montserratH5Regular,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CategoryReview(
                title: 'Professoren:',
                reviewValue: review.professors!,
              ),
              SizedBox(
                height: 10,
              ),
              CategoryReview(
                title: 'Lehre:',
                reviewValue: review.lectures!,
              ),
              SizedBox(
                height: 10,
              ),
              CategoryReview(
                title: 'Ausstattung an der Universität:',
                reviewValue: review.equipment!,
              ),
              SizedBox(
                height: 10,
              ),
              CategoryReview(
                title: 'Campus & Freizeitmöglichkeiten:',
                reviewValue: review.freetimeActivities!,
              ),
              SizedBox(
                height: 10,
              ),
              CategoryReview(
                title: 'Internationalität',
                reviewValue: review.internationality!,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Kontakt:',
                    style: AppTextStyles.montserratH5SemiBold,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  FutureBuilder(
                    future: BackendService().getEmailForUser(
                      uid: review.userId!,
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return GestureDetector(
                          onTap: () {
                            openMail(
                              context,
                              mailReceiverAdress: snapshot.data!,
                              mailSubject: '',
                              mailBodyText: '',
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AutoSizeText(
                              snapshot.data!,
                              style: AppTextStyles.montserratH6Regular.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        );
                      } else {
                        return Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 3,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
