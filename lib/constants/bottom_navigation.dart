import 'package:easy_localization/easy_localization.dart';
import 'package:studenthub/constants/key_translator.dart';

final bottomNavs = [
  {
    'solid-icon': 'lib/assets/nav_icons/solid/rectangles-mixed.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/rectangles-mixed.svg',
    'title': dashboardNavKey.tr(),
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/ballot-check.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/ballot-check.svg',
    'title': projectsNavKey.tr(),
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/messages.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/messages.svg',
    'title': messagesNavKey.tr(),
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/bell.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/bell.svg',
    'title': alertsNavKey.tr(),
  },
  {
    'solid-icon': 'lib/assets/nav_icons/solid/circle-user.svg',
    'regular-icon': 'lib/assets/nav_icons/regular/circle-user.svg',
    'title': accountNavKey.tr(),
  },
];
