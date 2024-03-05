import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: backgroundHeaderAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(
                Icons.person,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            SvgPicture.asset(
              'lib/assets/svgs/signs-post.svg',
              width: screenWidth * 0.08,
            ),
            const Spacer(),
            const Text(
              'Welcome, Hai!',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const Text(
              'Let\'s start with your first project post',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Get started!',
                style: textTheme.bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(
              flex: 16,
            )
          ],
        ),
      ),
    );
  }
}
