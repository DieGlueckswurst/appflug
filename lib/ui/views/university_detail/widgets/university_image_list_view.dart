import 'package:appflug/data/classes/university.dart';
import 'package:appflug/routes/views.dart';
import 'package:flutter/material.dart';

class UniversityImageListView extends StatefulWidget {
  final University university;

  const UniversityImageListView({
    Key? key,
    required this.university,
  }) : super(key: key);
  @override
  _UniversityImageListViewState createState() =>
      _UniversityImageListViewState();
}

class _UniversityImageListViewState extends State<UniversityImageListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
          widget.university.images.length,
          (index) => MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Views.universityPhoto,
                    arguments: <Object>[
                      widget.university,
                      index,
                    ]);
              },
              child: Hero(
                tag: widget.university.images[index].index,
                child: Container(
                  height: 100,
                  width: 200,
                  padding: EdgeInsets.symmetric(
                    horizontal: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    child: Image.network(
                      widget.university.images[index].downloadUrl,
                      loadingBuilder: (
                        context,
                        image,
                        loadingProgress,
                      ) {
                        if (loadingProgress == null) return image;
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: const CircularProgressIndicator.adaptive(),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
