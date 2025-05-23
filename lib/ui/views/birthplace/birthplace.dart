import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';

class BirthplaceView extends StatefulWidget {
  final String? initBirthplace;

  const BirthplaceView({
    Key? key,
    this.initBirthplace,
  }) : super(key: key);
  @override
  _BirthplaceViewViewState createState() => _BirthplaceViewViewState();
}

class _BirthplaceViewViewState extends State<BirthplaceView> {
  String _birthplace = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initBirthplace != null) {
      _birthplace = widget.initBirthplace!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: Column(
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Geburtsort',
                isEnabled: widget.initBirthplace != null,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWithRoundedBorder(
                        initValue: widget.initBirthplace,
                        onChanged: (birthplace) {
                          setState(() {
                            _birthplace = birthplace.trim();
                          });
                        },
                        hintText: 'Geburtsort eingeben',
                        focusOnInit: widget.initBirthplace == null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Speichern',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          _birthplace.isNotEmpty
                              ? _saveBirthplace(context)
                              : AlertService.showSnackBar(
                                  title: 'Ungültiger Geburtsort',
                                  description:
                                      'Bitte gib einen gültigen Geburtsort ein.',
                                  isSuccess: false,
                                );

                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveBirthplace(BuildContext context) async {
    bool wasSuccessfull = await StudentService.setBirthplace(
      context: context,
      birthplace: _birthplace,
    );

    AlertService.showSnackBar(
      title: wasSuccessfull
          ? 'Geburtsort erfolgreich gespeichert'
          : 'Ups, hier ist etwas schiefgelaufen',
      description: wasSuccessfull
          ? 'Du kannst deinen Geburtsort in deinem Profil nachträglich noch ändern.'
          : 'Bitte versuche es erneut oder starte die App neu.',
      isSuccess: wasSuccessfull,
    );

    if (wasSuccessfull) {
      Navigator.pop(context);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
