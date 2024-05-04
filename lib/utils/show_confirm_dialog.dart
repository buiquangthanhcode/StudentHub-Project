import 'package:flutter/material.dart';

showDialogConfirm(
  BuildContext context, {
  String title = "Bạn có chắc muốn xoá không?",
  String? cancelTxt,
  String confirmTxt = "Đồng ý",
  Function()? confirmOnPress,
}) {
  showDialog(
    context: context,
    builder: (context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        buttonPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 16),
          width: width - 72,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff21252B),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: height * 0.05,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.transparent),
                              color: const Color(0xfff2f5f8)),
                          child: Text("Huỷ", style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: confirmOnPress,
                        child: Container(
                            height: height * 0.05,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.transparent),
                                color: const Color(0xffCB2134)),
                            child: Text(
                              confirmTxt,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      );
    },
  );
}
