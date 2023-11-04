import 'dart:math' as math;
import 'package:flutter/material.dart';

class MainCalc extends StatefulWidget {
  const MainCalc({super.key});

  @override
  State<MainCalc> createState() => _MainCalcState();
}

class _MainCalcState extends State<MainCalc> {
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController yearEditingController = TextEditingController();
  TextEditingController interestEditingController = TextEditingController();
  double result = 0.0;
  double totalPayment = 0.0;
  double totalInterest = 0.0;
  int years = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loan Payment Calculator")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/loan1.png',
                  scale: 3,
                ),
                const Text(
                  "PAYMENT CALCULATOR",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: amountEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Enter Loan Amount (RM)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: yearEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Loan Term (years)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: interestEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Interest Rate (%)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: calculatePayment, // Call the function
                      child: const Text("Calculate"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: clearFields,
                      child: const Text("Clear"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Monthly Payment: RM ${result.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      backgroundColor: Colors.blue),
                ),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                  "You will need to pay RM ${result.toStringAsFixed(2)} every month for \n$years years to payoff the debt.",
                  textAlign: TextAlign.center,
                )),
                const SizedBox(height: 20),
                Text(
                    "Total Payment:\t\t\t RM  ${totalPayment.toStringAsFixed(2)}"),
                Text(
                    "Total Interest:\t\t\t\t\t RM  ${totalInterest.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculatePayment() {
    double totalAmount = double.parse(amountEditingController.text);
    years = int.parse(yearEditingController.text);
    double interestRate = double.parse(interestEditingController.text);

    double monthlyPayment =
        calculateLoanPayment(totalAmount, years, interestRate);

    totalPayment = (monthlyPayment * years * 12);
    totalInterest = (monthlyPayment * years * 12) - totalAmount;

    setState(() {
      result = monthlyPayment;
    });
  }

  double calculateLoanPayment(
      double totalAmount, int years, double interestRate) {
    final monthlyInterestRate = interestRate / 12 / 100;
    final totalMonths = years * 12;
    final denominator = 1 - math.pow(1 + monthlyInterestRate, -totalMonths);
    final monthlyPayment = (totalAmount * monthlyInterestRate) / denominator;

    return monthlyPayment;
  }

  void clearFields() {
    amountEditingController.text = "";
    yearEditingController.text = "";
    interestEditingController.text = "";
    setState(() {
      result = 0.0;
      years = 0;
      totalInterest = 0.0;
      totalPayment = 0.0;
    });
  }
}
