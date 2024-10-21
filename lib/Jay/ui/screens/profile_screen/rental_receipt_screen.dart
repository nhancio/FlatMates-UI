import 'package:flutter/material.dart';

class RentalReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rental Receipt',
          style: TextStyle(color: Colors.purple),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Context',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'The contents of a rental receipt are similar to those of a rental agreement but focus on the payment details:\n\n'
                    '• Names of the landlord and tenant.\n'
                    '• Description of the property.\n'
                    '• Payment details including amount, date, and mode of payment.\n'
                    '• Reference number for the payment transaction.\n'
                    '• Signature of both parties or a digital acknowledgment.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
