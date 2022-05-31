import 'package:get/get.dart';
import 'package:nasa_app/view/opportunity/opportunity_controller.dart';

class OpportunityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OpportunityController>(() => OpportunityController());
  }
  
}