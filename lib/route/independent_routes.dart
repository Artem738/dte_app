import 'package:dte_app/screens/settings_screen.dart';
import 'package:dte_app/screens/profile_screen.dart';

final List<Map<String, dynamic>> independentRoutes = [
  {
    'path': '/settings',
    'pageName': 'Settings',
    'pagePathName': 'settings',
    'pageType': 'page',
    'builder': (context, state) => SettingsScreen(),
  },
  {
    'path': '/profile',
    'pageName': 'Profile',
    'pagePathName': 'profile',
    'pageType': 'page',
    'builder': (context, state) => ProfileScreen(),
  },
];
