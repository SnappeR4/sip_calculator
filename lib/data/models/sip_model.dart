import 'dart:math';

class SIPModel {
  final double monthlyInvestment;
  final double annualRate;
  final int tenure;

  SIPModel({
    required this.monthlyInvestment,
    required this.annualRate,
    required this.tenure,
  });

  double calculateMaturityAmount() {
    double monthlyRate = annualRate / 12 / 100;
    int n = tenure;

    double numerator = pow(1 + monthlyRate, n).toDouble() - 1;
    double denominator = monthlyRate;

    return monthlyInvestment * (numerator / denominator) * (1 + monthlyRate);
  }
}
