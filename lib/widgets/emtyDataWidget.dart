import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.mainTitle,
    required this.subTitle,
    this.image,
    this.heightImage,
    this.widthImage,
  });

  final String mainTitle;
  final String subTitle;
  final String? image;
  final double? heightImage;
  final double? widthImage;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Image.asset(
          image ?? 'lib/assets/images/empty_data.png',
          width: widthImage ?? width * 0.75,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          mainTitle,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subTitle,
          style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
        ),
      ],
    );
  }
}
