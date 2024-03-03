import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

import '../../core/text_field_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Icon(Icons.person),
            ],
          ),
        ),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Center(
                child: Text(
                  'Login with StudentHub',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'username',
              hintText: 'Username',
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.user,
                  size: 16,
                  color: Color(0xffED6C66),
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'password',
              hintText: 'Password',
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.lock,
                  size: 16,
                  color: Color(0xffED6C66),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: const Color(0xffED6C66),
                elevation: 5,
                minimumSize: const Size(150, 40),
              ),
              onPressed: () {
                // Navigate to the second screen using a named route.
                context.go('/homepage');
              },
              child: const Text('Login'),
            ),
            const Spacer(
              flex: 10,
            ),
            Column(
              children: [
                Text(
                  '______ Don\'t have an Student Hub acccount? ____',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: const Color(0xffED6C66),
                    elevation: 5,
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    context.go('/register');
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
