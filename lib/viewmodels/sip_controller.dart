import 'package:get/get.dart';
import '../data/models/sip_model.dart';

class SIPController extends GetxController {
  var monthlyInvestment = 1000.0.obs;
  var annualRate = 12.0.obs;
  var tenure = 12.obs;

  RxDouble maturityAmount = 0.0.obs;

  void calculate() {
    SIPModel sip = SIPModel(
      monthlyInvestment: monthlyInvestment.value,
      annualRate: annualRate.value,
      tenure: tenure.value,
    );
    maturityAmount.value = sip.calculateMaturityAmount();
  }
}
