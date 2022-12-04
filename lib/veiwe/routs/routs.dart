import 'package:get/get.dart';
import 'package:tour_aplication/veiwe/auth_Screens/sign_up.dart';
import 'package:tour_aplication/veiwe/auth_Screens/users_form_page.dart';
import 'package:tour_aplication/veiwe/drawer_payges/faq.dart';
import 'package:tour_aplication/veiwe/drawer_payges/how_to_use.dart';
import 'package:tour_aplication/veiwe/drawer_payges/privacy.dart';
import 'package:tour_aplication/veiwe/drawer_payges/rate_us.dart';
import 'package:tour_aplication/veiwe/home_pages/main_homeScreen.dart';
import 'package:tour_aplication/veiwe/home_pages/favorite_Screen.dart';
import '../auth_Screens/login_screen.dart';
import '../auth_Screens/onbording_Screen.dart';
import '../auth_Screens/priveci_plice_Screen.dart';
import '../auth_Screens/splashScreen.dart';
import '../drawer_payges/my password.dart';
import '../drawer_payges/setting.dart';
import '../drawer_payges/support.dart';
import '../home_pages/details_Screen.dart';
import '../home_pages/drawer_screen.dart';
import '../home_pages/home_page.dart';
import '../home_pages/add_tour_screen.dart';
import '../home_pages/nav_add_last_step.dart';
import '../home_pages/profile_screen.dart';
import '../home_pages/search_Sceen.dart';
import '../home_pages/see_allscreen.dart';
import '../home_pages/tour_screen.dart';

const String splash = "/SplashScreen";
const String onboarding = "/onboardingScreen";
const String signUp = "/signupScreen";
const String usersForm = "/users_Form_Screen";
const String priviceScreen = "/Privice_Policy_Screen";
const String loginScreen = "/login_Screen";
const String mainhomeScreen = "/main_home_screen";
const String homePage = "/Home_Page";
const String drawerScreen = "/drawer_Screen";
const String tourScreen = "/Tour_Screen";
const String supportScreen = "/support_Screen";
const String privacyScreen = "/privacy_Screen";
const String faqScreen = "/faq_Screen";
const String rateUsScreen = "/rate_us_Screen";
const String howToUseScreen = "/how_to_use_Screen";
const String favoriteScreen = "/favorite_Screen";
const String searchScreen = "/search_Screen";
const String detailsScreen = "/details_Screen";
const String seeAllScreen = "/seeAll_Screen";
const String addTourScren = "/addTour_Scren";
const String navAddLastStep = "/navAdd_LastStep";
const String profileScreen = "/profile_Screen";
const String settingScreen = "/Setting_Screen";
const String myPassword = "/myPassword";

List<GetPage> payges = [
  GetPage(name: splash, page: () => const SplashScreen()),
  GetPage(name: onboarding, page: () => OnbordingScreen()),
  GetPage(name: signUp, page: () => SignUp()),
  GetPage(name: usersForm, page: () => UsersForm()),
  GetPage(name: priviceScreen, page: () => PrivicePolicyScreen()),
  GetPage(name: loginScreen, page: () => LoginScreen()),
  GetPage(name: mainhomeScreen, page: () => const MainHomeScreen()),
  GetPage(name: homePage, page: () => HomePage()),
  GetPage(name: tourScreen, page: () => const TourScreen()),
  GetPage(name: supportScreen, page: () => SupportScreen()),
  GetPage(name: privacyScreen, page: () => PrivacyScreen()),
  GetPage(name: faqScreen, page: () => FQAScreen()),
  GetPage(name: rateUsScreen, page: () => RateUsScreen()),
  GetPage(name: howToUseScreen, page: () => const HowToUseScreen()),
  GetPage(name: favoriteScreen, page: () => const FavoriteScreen()),
  GetPage(name: searchScreen, page: () => SearchScreen()),
  GetPage(
      name: detailsScreen,
      page: () {
        DetailsScreen detailsScreen = Get.arguments;
        return detailsScreen;
      }),
  GetPage(
      name: seeAllScreen,
      page: () {
        SeeAllScreen seeAllScreen = Get.arguments;
        return seeAllScreen;
      }),
  GetPage(name: addTourScren, page: () => AddTourScren()),
  GetPage(
      name: navAddLastStep,
      page: () {
        NavAddLastStep addlaststep = Get.arguments;
        return addlaststep;
      }),
  GetPage(name: profileScreen, page: () => ProfileScreen()),
  GetPage(name: drawerScreen, page: () => const DrawerScreen()),
  GetPage(name: settingScreen, page: () => SettingScreen()),
  GetPage(name: myPassword, page: () => const MyPassword()),
];
