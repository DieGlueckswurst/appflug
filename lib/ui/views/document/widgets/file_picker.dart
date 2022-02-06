import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/box_decoration.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/url_launch_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilePickerView extends StatefulWidget {
  final Function(PlatformFile) onFilePicked;
  final Document initDocument;

  const FilePickerView({
    Key? key,
    required this.onFilePicked,
    required this.initDocument,
  }) : super(key: key);

  @override
  _FilePickerViewState createState() => _FilePickerViewState();
}

class _FilePickerViewState extends State<FilePickerView> {
  bool _isLoading = false;
  PlatformFile? _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            setState(() {
              _isLoading = true;
            });

            if (widget.initDocument.downloadUrl != null) {
              openURL(
                context,
                url: widget.initDocument.downloadUrl!,
              );
            } else {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'pdf',
                ],
              );
              if (result != null) {
                if (result.files.first.size > 5000000) {
                  AlertService.showSnackBar(
                    title: 'Fehler: Datei ist zu groß.',
                    description:
                        'Das Dokument darf nicht größer als 5 MB sein.',
                    isSuccess: false,
                  );
                } else {
                  setState(
                    () {
                      _pickedFile = result.files.first;
                      widget.onFilePicked(result.files.first);
                    },
                  );
                }
              }
            }
            setState(() {
              _isLoading = false;
            });
          },
          child: Container(
            height: 200,
            width: 180,
            decoration: defaultBoxDecoration,
            child: Center(
              child: AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : _pickedFile != null || widget.initDocument.name != null
                        ? _buildFilePickedWidget()
                        : _buildPickFileWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPickFileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/upload.svg',
          height: 30,
          color: AppColors.blue,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Datei wählen',
          style: AppTextStyles.montserratH6SemiBold,
        ),
      ],
    );
  }

  Widget _buildFilePickedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/document.svg',
          height: 30,
          color: AppColors.blue,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            widget.initDocument.name != null
                ? widget.initDocument.name!
                : _pickedFile!.name,
            style: AppTextStyles.montserratH6SemiBold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
