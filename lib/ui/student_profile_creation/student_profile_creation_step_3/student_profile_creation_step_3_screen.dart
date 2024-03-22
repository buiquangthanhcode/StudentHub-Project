// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/widgets/continue_button.dart';
import 'package:studenthub/ui/student_profile_creation/student_profile_creation_step_3/widgets/title_widget.dart';

class StudentProfileCreationStep3Screen extends StatefulWidget {
  const StudentProfileCreationStep3Screen({Key? key}) : super(key: key);

  @override
  _StudentProfileCreationStep3ScreenState createState() => _StudentProfileCreationStep3ScreenState();
}

class _StudentProfileCreationStep3ScreenState extends State<StudentProfileCreationStep3Screen> {
  FilePickerResult? result;
  // var? fileName;
  PlatformFile? pickerfile;
  bool resumeLoadingState = false;
  bool transcriptLoadingState = false;
  // File? fileToDisplay;
  List<FileModel> resume = [];
  List<FileModel> transcript = [];
  String excel_path = 'lib/assets/images/icons8-excel-48.png';
  String image_path = 'lib/assets/images/icons8-image-48.png';
  String pdf_path = 'lib/assets/images/icons8-pdf-48.png';

  String getLastSubstringAfterDot(String filename) {
    List<String> parts = filename.split('.');
    if (parts.length > 1) {
      return parts.last;
    }
    return '';
  }

  void pickFile(int type) async {
    try {
      setState(() {
        type == 0 ? resumeLoadingState = true : transcriptLoadingState = true;
      });

      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['png', 'pdf', 'xlsx', 'jpg'], allowMultiple: true);

      if (result != null) {
        // print(result);
        // fileName = result!.files.first;
        // pickerfile = result!.files.first;
        // fileToDisplay = File(pickerfile!.path.toString());
        // number.toStringAsFixed(1)

        for (var file in result!.files) {
          type == 0
              ? resume.add(
                  FileModel(
                    name: file.name,
                    type: getLastSubstringAfterDot(file.name),
                    size: (file.size / 1000000).toStringAsFixed(1),
                  ),
                )
              : transcript.add(
                  FileModel(
                    name: file.name,
                    type: getLastSubstringAfterDot(file.name),
                    size: (file.size / 1000000).toStringAsFixed(1),
                  ),
                );
        }
      }

      setState(() {
        type == 0 ? resumeLoadingState = false : transcriptLoadingState = false;
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, screenSize.height * (Platform.isIOS ? 0.04 : 0.03)),
        child: Column(
          children: [
            const TitleWidget(),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Resume/CV (*)',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                pickFile(0);
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 2,
                dashPattern: const [8, 8],
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                color: colorTheme.hintColor!,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                      alignment: Alignment.center,
                      height: screenSize.height * 0.16,
                      width: double.infinity,
                      child: resumeLoadingState
                          ? const CircularProgressIndicator(
                              color: primaryColor,
                              strokeAlign: 2,
                              strokeWidth: 6,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.cloudArrowUp,
                                  size: screenSize.height * 0.06,
                                  color: colorTheme.hintColor!,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text('Select File to Upload', style: textTheme.bodyMedium),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Select PDF, Excel or Image',
                                  style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                                )
                              ],
                            )),
                ),
              ),
            ),
            // if (resume.isNotEmpty)
            Container(
              // color: Colors.yellow,
              height: 70,
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...resume.map((e) => Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffF6F7F9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  e.type == 'png' || e.type == 'jpg'
                                      ? image_path
                                      : e.type == 'pdf'
                                          ? pdf_path
                                          : excel_path,
                                  scale: 1.8,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${e.size!}MB',
                                      style:
                                          TextStyle(color: colorTheme.grey, fontWeight: FontWeight.w400, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  resume.remove(e);
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Transcript (*)',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                pickFile(1);
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 2,
                dashPattern: const [8, 8],
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                color: colorTheme.hintColor!,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    alignment: Alignment.center,
                    height: screenSize.height * 0.16,
                    width: double.infinity,
                    child: transcriptLoadingState
                        ? const CircularProgressIndicator(
                            color: primaryColor,
                            strokeAlign: 2,
                            strokeWidth: 6,
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.cloudArrowUp,
                                size: screenSize.height * 0.06,
                                color: colorTheme.hintColor!,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('Select File to Upload', style: textTheme.bodyMedium),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Select PDF, Excel or Image',
                                style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ),
            Container(
              // color: Colors.yellow,
              height: 70,
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...transcript.map((e) => Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                          decoration: const BoxDecoration(
                            color: Color(0xffF6F7F9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  e.type == 'png' || e.type == 'jpg'
                                      ? image_path
                                      : e.type == 'pdf'
                                          ? pdf_path
                                          : excel_path,
                                  scale: 1.8,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${e.size!}MB',
                                      style:
                                          TextStyle(color: colorTheme.grey, fontWeight: FontWeight.w400, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  transcript.remove(e);
                                  setState(() {});
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            ContinueButton(buttonActive: true, press: () {}),
          ],
        ),
      ),
    );
  }
}

class FileModel {
  String? name;
  String? type;
  String? size;

  FileModel({
    this.name,
    this.type,
    this.size,
  });
}
