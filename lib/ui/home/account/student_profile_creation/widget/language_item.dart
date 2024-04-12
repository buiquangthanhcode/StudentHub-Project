import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/edit_language.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.theme,
    required this.item,
  });

  final ThemeData theme;
  final Language item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.grey!.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Text('${item.languageName}: ${item.level}'),
          const Spacer(),
          InkWell(
            onTap: () {
              showModalBottomSheetCustom(context, widgetBuilder: LanguageEdit(item: item));
            },
            child: FaIcon(
              FontAwesomeIcons.penToSquare,
              size: 16,
              color: theme.colorScheme.grey!,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialogCustom(context,
                  image: 'lib/assets/images/delete.png',
                  title: 'Are you sure you want to delete this language?',
                  textButtom: 'Delete',
                  subtitle: 'This action cannot be undone', onSave: () {
                int userId = BlocProvider.of<StudentBloc>(context).state.student.id ?? -1;
                List<Language> languages =
                    List<Language>.from(BlocProvider.of<StudentBloc>(context).state.student.languages ?? []);
                context.read<StudentBloc>().add(UpdateLanguageEvent(
                    languages: languages..remove(item),
                    userId: userId,
                    onSuccess: () {
                      SnackBarService.showSnackBar(content: "Delete Sucessfully", status: StatusSnackBar.success);
                      Navigator.pop(context);
                      // context.read<StudentBloc>().add(GetAllLanguageEvent(onSuccess: () {}, userId: userId));
                    }));
              });
            },
            child: const FaIcon(
              FontAwesomeIcons.xmark,
              size: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
