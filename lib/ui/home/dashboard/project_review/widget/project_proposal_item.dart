import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ProposalItem extends StatefulWidget {
  const ProposalItem({super.key, required this.theme, required this.item, this.activeSentButton});

  final ThemeData theme;
  final dynamic item;
  final bool? activeSentButton;

  @override
  State<ProposalItem> createState() => _ProposalItemState();
}

class _ProposalItemState extends State<ProposalItem> {
  bool isPressHiredButton = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 70,
                clipBehavior: Clip.none,
                width: 70,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.theme.colorScheme.grey!.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                // child: Image.network(
                //   item['avatar'],
                //   fit: BoxFit.cover,
                // ),
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/images/circle_avatar.png'),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['fullname'],
                    style: widget.theme.textTheme.bodyMedium,
                  ),
                  Text(
                    widget.item['year'],
                    style: widget.theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                widget.item['major'],
                style: widget.theme.textTheme.bodyMedium,
              ),
              const Spacer(),
              Text(
                widget.item['rating'],
                style: widget.theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.item['description'],
            style: widget.theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 35),
                  ),
                  onPressed: () {
                    context.push('/chat_detail');
                  },
                  child: Text(
                    "Message",
                    style: widget.theme.textTheme.bodyMedium!.copyWith(
                      color: widget.theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              widget.activeSentButton ?? true
                  ? const SizedBox(
                      width: 10,
                    )
                  : const SizedBox(),
              widget.activeSentButton ?? true
                  ? Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 35),
                        ),
                        onPressed: () {
                          showDialogCustom(context,
                              title: 'Hide Offer',
                              textButtom: 'Hired',
                              subtitle: 'Do you readllly want to hide this offer for student to do this project?',
                              onSave: () {
                            SnackBarService.showSnackBar(content: "Hired Sucessfully", status: StatusSnackBar.success);
                            context.pop();
                            setState(() {
                              isPressHiredButton = true;
                            });
                          });
                        },
                        child: Text(
                          isPressHiredButton ? 'Sent offer' : "Hired",
                          style: widget.theme.textTheme.bodyMedium!.copyWith(
                            color: widget.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
