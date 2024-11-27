import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodels/sip_controller.dart';

class SIPScreen extends StatelessWidget {
  final SIPController controller = Get.put(SIPController());

  SIPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIP Calculator'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                'Calculate Your SIP Returns',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your investment details below to estimate your SIP maturity amount.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Input Section
              _buildInputCard(),

              const SizedBox(height: 24),

              // Results Section
              Obx(() {
                double totalInvestment = controller.monthlyInvestment.value * controller.tenure.value;
                double estimatedReturn = controller.maturityAmount.value - totalInvestment;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildResultsCard(
                      maturityAmount: controller.maturityAmount.value,
                      totalInvestment: totalInvestment,
                      estimatedReturn: estimatedReturn,
                    ),
                    const SizedBox(height: 24),

                    // Chart Section
                    _buildChartSection(
                      totalInvestment: totalInvestment,
                      estimatedReturn: estimatedReturn,
                      size: size,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Input Section UI
  Widget _buildInputCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              label: 'Monthly Investment (₹)',
              icon: Icons.currency_rupee,
              onChanged: (value) => controller.monthlyInvestment.value = double.parse(value),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              label: 'Annual Interest Rate (%)',
              icon: Icons.percent,
              onChanged: (value) => controller.annualRate.value = double.parse(value),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              label: 'Tenure (Months)',
              icon: Icons.calendar_month,
              onChanged: (value) => controller.tenure.value = int.parse(value),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Calculate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Results Section UI
  Widget _buildResultsCard({
    required double maturityAmount,
    required double totalInvestment,
    required double estimatedReturn,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildResultRow(
              title: 'Maturity Amount',
              value: '₹${maturityAmount.toStringAsFixed(2)}',
              valueColor: Colors.blue,
            ),
            const Divider(),
            _buildResultRow(
              title: 'Total Investment',
              value: '₹${totalInvestment.toStringAsFixed(2)}',
            ),
            const Divider(),
            _buildResultRow(
              title: 'Estimated Return',
              value: '₹${estimatedReturn.toStringAsFixed(2)}',
              valueColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // Chart Section UI
  Widget _buildChartSection({
    required double totalInvestment,
    required double estimatedReturn,
    required Size size,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Investment vs Returns',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: size.width * 0.6,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: totalInvestment,
                      title: 'Invested\n₹${totalInvestment.toStringAsFixed(0)}',
                      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      radius: 80,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: estimatedReturn,
                      title: 'Return\n₹${estimatedReturn.toStringAsFixed(0)}',
                      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      radius: 80,
                    ),
                  ],
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildInputField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }

  Widget _buildResultRow({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: valueColor ?? Colors.black),
        ),
      ],
    );
  }
}
