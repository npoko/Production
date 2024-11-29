import 'package:engineer/pm_check/screens/screen_typepm.dart';
import 'package:engineer/screens/checklist/lineproduction_screen.dart';
import 'package:engineer/screens/checklist/selectJobMachine_screen.dart';
import 'package:engineer/screens/checklist/selectMachine_sceen.dart';
import 'package:engineer/screens/login/login_screen.dart';
import 'package:engineer/screens/checklist/report_screen.dart';
import 'package:engineer/screens/singup/signup_screen.dart';
import 'package:engineer/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Router Map Key
  static const String welcome = '/welcome';
  static const String login = '/LoginScreen';
  static const String register = '/SignUpScreen';
  static const String home = '/SelectMachineScreen';
  static const String report = '/report';
  static const String typm = '/pm_pim';
  static const String newsand = '/newsand';
  static const String Checklistdaily = '/checklistdaily';
  static const String reclaimedSandScreen = '/ReclaimedSandScreen';
  static const String customBottomNavigationBarScreen =
      '/customBottomNavigationBar';
  static const String Checklistscreen = '/Checklistscreen';
  static const String line = '/LineProductionScreen';
  static const String select = '/SelectJobMachineScreen';

  static get routes => {
        login: (context) => const LoginScreen(),
        welcome: (context) => const WelcomeScreen(),
        register: (context) => const SignUpScreen(),
        home: (context) => SelectMachineScreen(),
        report: (context) => const ReportScreen(),
        typm: (context) => const typepm(),
        Checklistdaily: (context) => const typepm(),
        line: (context) => LineProductionScreen(
              lineName: 'Default Line Name',
              lineID: '',
            ),
        select: (context) => SelectJobMachineScreen(
              machines: [],
              lineName: '',
              machine: null,
              initialData: {},
            ),
      };
}
