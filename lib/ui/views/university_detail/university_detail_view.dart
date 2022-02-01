import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_expansoin_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/university_hero_logo.dart';
import 'package:appflug/ui/views/university_detail/widgets/review_overview.dart';
import 'package:appflug/ui/views/university_detail/widgets/university_image_list_view.dart';
import 'package:flutter/material.dart';

class UniversityDetailView extends StatefulWidget {
  final University university;

  const UniversityDetailView({
    Key? key,
    required this.university,
  }) : super(key: key);
  @override
  _UniversityDetailViewState createState() => _UniversityDetailViewState();
}

class _UniversityDetailViewState extends State<UniversityDetailView> {
  @override
  Widget build(BuildContext context) {
    Student _student = StudentService.getStudent(
      context,
      listen: false,
    )!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: Column(
            children: [
              CustomBackButton(),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      widget.university.name,
                      style: AppTextStyles.montserratH3Bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UniversityHeroLogo(
                      university: widget.university,
                      width: 200,
                      height: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReviewOverview(
                      university: widget.university,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedCornersTextButton(
                      title: 'In Präferenzliste speichern',
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomExpansionTile(
                      title: 'Beschreibung',
                      content: widget.university.description,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Bilder',
                          style: AppTextStyles.montserratH3Bold.copyWith(
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UniversityImageListView(
                      university: widget.university,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
