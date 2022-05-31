import 'package:get/get.dart';
import 'package:nasa_app/bindings/base_binding.dart';
import 'package:nasa_app/bindings/curiosity_binding.dart';
import 'package:nasa_app/bindings/opportunity_binding.dart';
import 'package:nasa_app/bindings/spirit_binding.dart';
import 'package:nasa_app/routes/app_routes.dart';
import 'package:nasa_app/view/curiosity/curiosity_screen.dart';
import 'package:nasa_app/view/home_page.dart';
import 'package:nasa_app/view/opportunity/opportunity_screen.dart';
import 'package:nasa_app/view/spirit/spirit_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.homeScreen,
        page: () => const HomePage(),
        binding: BaseBinding()),
    GetPage(
        name: Routes.curiosityScreen,
        page: () => const CuriosityScreen(),
        binding: CuriosityBinding()),
    GetPage(
        name: Routes.opportunityScreen,
        page: () => const OpportunityScreen(),
        binding: OpportunityBinding()),
    GetPage(
        name: Routes.spiritScreen,
        page: () => const SpiritScreen(),
        binding: SpiritBinding()),
  ];
}
