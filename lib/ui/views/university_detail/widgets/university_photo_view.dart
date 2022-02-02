import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class UniversityPhotoView extends StatefulWidget {
  final University university;
  final int initIndex;

  const UniversityPhotoView({
    Key? key,
    required this.university,
    required this.initIndex,
  }) : super(key: key);
  @override
  _UniversityPhotoViewState createState() => _UniversityPhotoViewState();
}

class _UniversityPhotoViewState extends State<UniversityPhotoView> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initIndex;
    _pageController = PageController(
      initialPage: widget.initIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(
        false,
      ),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      widget.university.images[index].downloadUrl,
                    ),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: widget.university.images[index].index,
                    ),
                  );
                },
                itemCount: widget.university.images.length,
                loadingBuilder: (context, event) => Container(
                  color: AppColors.black,
                  child: Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
                pageController: _pageController,
                onPageChanged: onPageChanged,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(
                    sidePadding,
                  ),
                  child: Text(
                    "Bild ${_currentIndex + 1}",
                    style: AppTextStyles.montserratH6Regular.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleIconButton(
                      onTapped: _onPrevPage,
                      svgPath: 'assets/icons/arrow_left.svg',
                      backgroundColor: AppColors.transparent,
                      svgColor: AppColors.white,
                      svgSize: 20,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: CircleIconButton(
                        onTapped: _onNextPage,
                        svgPath: 'assets/icons/arrow_left.svg',
                        backgroundColor: AppColors.transparent,
                        svgColor: AppColors.white,
                        svgSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: sidePadding,
                right: sidePadding,
                child: CircleIconButton(
                  onTapped: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  svgPath: 'assets/icons/multiply.svg',
                  backgroundColor: AppColors.transparent,
                  svgColor: AppColors.white,
                  svgSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPrevPage() {
    _pageController.previousPage(
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _onNextPage() {
    _pageController.nextPage(
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
