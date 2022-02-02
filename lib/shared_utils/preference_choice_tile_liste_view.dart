import 'package:appflug/ui/views/preference_list/widgets/choice_tile.dart';
import 'package:flutter/material.dart';

class PreferenceChoiseListTileView extends StatefulWidget {
  final Function(String) onPositionChanged;

  const PreferenceChoiseListTileView({
    Key? key,
    required this.onPositionChanged,
  }) : super(key: key);

  @override
  _PreferenceChoiseListTileViewState createState() =>
      _PreferenceChoiseListTileViewState();
}

class _PreferenceChoiseListTileViewState
    extends State<PreferenceChoiseListTileView> {
  String _selectedPosition = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferenceListPositionTile(
          position: '1',
          isSelected: _selectedPosition == '1',
          onCourseChange: (position) {
            setState(() {
              _selectedPosition = position;
            });
            widget.onPositionChanged(
              position,
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        PreferenceListPositionTile(
          position: '2',
          isSelected: _selectedPosition == '2',
          onCourseChange: (position) {
            setState(() {
              _selectedPosition = position;
            });
            widget.onPositionChanged(
              position,
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        PreferenceListPositionTile(
          position: '3',
          isSelected: _selectedPosition == '3',
          onCourseChange: (position) {
            setState(() {
              _selectedPosition = position;
            });
            widget.onPositionChanged(
              position,
            );
          },
        ),
      ],
    );
  }
}
