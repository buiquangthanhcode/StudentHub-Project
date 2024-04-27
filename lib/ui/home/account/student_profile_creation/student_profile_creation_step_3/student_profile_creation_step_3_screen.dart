// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';

import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/student/student_model.dart';
import 'package:studenthub/ui/home/account/company_profile_creation/profile_creation/widgets/continue_button.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/student_profile_creation_step_3/widgets/title_widget.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StudentProfileCreationStep3Screen extends StatefulWidget {
  const StudentProfileCreationStep3Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentProfileCreationStep3ScreenState createState() =>
      _StudentProfileCreationStep3ScreenState();
}

class _StudentProfileCreationStep3ScreenState
    extends State<StudentProfileCreationStep3Screen> {
  FilePickerResult? resultResume;
  FilePickerResult? resultTranScript;
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
  late Student student;
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  // final GlobalKey<SfPdfViewerState> _pdfViewerKeyTranScrip = GlobalKey();

  String getLastSubstringAfterDot(String filename) {
    List<String> parts = filename.split('.');
    if (parts.length > 1) {
      return parts.last;
    }
    return '';
  }

  void pickFileResume(int type) async {
    try {
      setState(() {
        type == 0 ? resumeLoadingState = true : transcriptLoadingState = true;
      });

      resultResume = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'pdf', 'xlsx', 'jpg'],
          allowMultiple: true);

      if (resultResume != null) {
        // print(result);
        // fileName = result!.files.first;
        // pickerfile = result!.files.first;
        // fileToDisplay = File(pickerfile!.path.toString());
        // number.toStringAsFixed(1)
        for (var file in resultResume!.files) {
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

  void pickFileTranScript(int type) async {
    try {
      setState(() {
        type == 0 ? resumeLoadingState = true : transcriptLoadingState = true;
      });

      resultTranScript = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'pdf', 'xlsx', 'jpg'],
          allowMultiple: true);

      if (resultTranScript != null) {
        // print(result);
        // fileName = result!.files.first;
        // pickerfile = result!.files.first;
        // fileToDisplay = File(pickerfile!.path.toString());
        // number.toStringAsFixed(1)
        for (var file in resultTranScript!.files) {
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
  void initState() {
    super.initState();
    student = BlocProvider.of<StudentBloc>(context).state.student;
    context
        .read<StudentBloc>()
        .add(GetResumeEvent(studentId: student.id.toString()));
    context
        .read<StudentBloc>()
        .add(GetTranScription(studentId: student.id.toString()));

    if (student.resume != null) {
      String fileName =
          student.resume!.split('/').last.split('?').first; // Lấy tên file
      String fileType = fileName.split('.').last;
      double fileSize = 0.1;
      String url = student.resume ?? '';
      resume.add(FileModel(
          name: fileName, type: fileType, size: fileSize.toString(), url: url));
    }
    if (student.transcript != null) {
      String fileName =
          student.transcript!.split('/').last.split('?').first; // Lấy tên file
      String fileType = fileName.split('.').last;
      double fileSize = 0.1;
      String url = student.transcript ?? '';
      transcript.add(FileModel(
          name: fileName, type: fileType, size: fileSize.toString(), url: url));
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CV & Transcript',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 0, 20, screenSize.height * (Platform.isIOS ? 0.04 : 0.03)),
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            return Column(
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
                    pickFileResume(0);
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
                                    Text('Select File to Upload',
                                        style: textTheme.bodyMedium),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Select PDF, Excel or Image',
                                      style: textTheme.bodySmall!
                                          .copyWith(color: colorTheme.grey),
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
                        ...resume.map((e) => GestureDetector(
                              onTap: () {
                                logger.d(e.url);
                                // _pdfViewerKey.currentState?.openBookmarkView();
                                showDialog(
                                    context: context,
                                    builder: (context) => Theme(
                                          data: Theme.of(context).copyWith(
                                            dialogBackgroundColor: Colors.white,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Dialog(
                                            surfaceTintColor:
                                                Colors.transparent,
                                            backgroundColor: Colors.white,
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.8,
                                              // child: SfPdfViewer.network(
                                              //   currentSearchTextHighlightColor: Colors.black,
                                              //   e.url ?? '',
                                              //   key: _pdfViewerKey,
                                              //   onDocumentLoadFailed: (details) {
                                              //     logger.e(details.error);
                                              //   },
                                              // ),
                                            ),
                                          ),
                                        ));
                              },
                              child: Container(
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
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '${e.size!}MB',
                                            style: TextStyle(
                                                color: colorTheme.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: FaIcon(
                                          FontAwesomeIcons.xmark,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
                    pickFileTranScript(1);
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
                                  Text('Select File to Upload',
                                      style: textTheme.bodyMedium),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Select PDF, Excel or Image',
                                    style: textTheme.bodySmall!
                                        .copyWith(color: colorTheme.grey),
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
                        ...transcript.map((e) => GestureDetector(
                              onTap: () {
                                try {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Theme(
                                            data: Theme.of(context).copyWith(
                                              dialogBackgroundColor:
                                                  Colors.white,
                                              shadowColor: Colors.transparent,
                                            ),
                                            child: Dialog(
                                              surfaceTintColor:
                                                  Colors.transparent,
                                              backgroundColor: Colors.white,
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.8,
                                                // child: SfPdfViewer.network(
                                                //   currentSearchTextHighlightColor:
                                                //       Colors.black,
                                                //   e.url ?? '',
                                                //   key: _pdfViewerKeyTranScrip,
                                                //   onDocumentLoadFailed:
                                                //       (details) {
                                                //     logger.e(details.error);
                                                //   },
                                                // ),
                                              ),
                                            ),
                                          ));
                                } catch (e) {
                                  SnackBarService.showSnackBar(
                                      content: 'Error',
                                      status: StatusSnackBar.error);
                                }
                              },
                              child: Container(
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
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            '${e.size!}MB',
                                            style: TextStyle(
                                                color: colorTheme.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: FaIcon(
                                          FontAwesomeIcons.xmark,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                ContinueButton(
                    buttonActive: true,
                    press: () {
                      int userId = BlocProvider.of<StudentBloc>(context)
                              .state
                              .student
                              .id ??
                          -1;
                      if (resultResume != null) {
                        context.read<StudentBloc>().add(
                              UploadResumeEvent(
                                path: resultResume!.files.first.path.toString(),
                                userId: userId,
                                onSuccess: () {},
                                name: resultResume!.files.first.name.toString(),
                              ),
                            );
                      }
                      if (resultTranScript != null) {
                        context.read<StudentBloc>().add(
                              SubmitTranScript(
                                path: resultTranScript!.files.first.path
                                    .toString(),
                                userId: userId,
                                onSuccess: () {
                                  SnackBarService.showSnackBar(
                                      content: 'Upload Successfully',
                                      status: StatusSnackBar.success);
                                  context.pop(context);
                                  context.pop(context);
                                  context.pop(context);
                                },
                                name: resultTranScript!.files.first.name
                                    .toString(),
                              ),
                            );
                      }
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FileModel {
  String? name;
  String? type;
  String? size;
  String? url;

  FileModel({this.name, this.type, this.size, this.url});
}
