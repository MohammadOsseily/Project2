import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payroll Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PayrollCalculator(),
    );
  }
}

class PayrollCalculator extends StatefulWidget {
  const PayrollCalculator({super.key});

  @override
  _PayrollCalculatorState createState() => _PayrollCalculatorState();
}

class _PayrollCalculatorState extends State<PayrollCalculator> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController taxController = TextEditingController();

  double grossSalary = 0.0;
  double taxAmount = 0.0;
  double netSalary = 0.0;
  double yearlySalary = 0.0;
  double yearlySalaryAfterTax = 0.0;
  double taxRate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/employ.jpg',
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Enter Monthly Salary'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: taxController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Enter Tax Percentage'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculatePayroll,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (grossSalary > 0.0) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Monthly Gross Salary: \$${grossSalary.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Yearly Gross Salary: \$${yearlySalary.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Tax Rate: ${(taxRate * 100).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Tax Amount: \$${taxAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: 'Net Salary: ',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '\$${netSalary.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Yearly Salary After Tax: \$${yearlySalaryAfterTax.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void calculatePayroll() {
    if (salaryController.text.isEmpty || taxController.text.isEmpty) {
      return;
    }

    double monthlySalary = double.parse(salaryController.text);
    grossSalary = monthlySalary;

    taxRate = double.parse(taxController.text) / 100;

    yearlySalary = monthlySalary * 12;

    taxAmount = monthlySalary * taxRate;
    netSalary = monthlySalary - taxAmount;

    yearlySalaryAfterTax = yearlySalary - (taxAmount * 12);

    setState(() {});
  }
}
