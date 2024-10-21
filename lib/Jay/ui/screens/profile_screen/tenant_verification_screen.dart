import 'package:flutter/material.dart';

class TenantVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tenant Verification',
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
                'FORMAT FOR INFORMATION OF TENANTS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Name of Landlord: _____\n'
                    '2. Occupation With: _____\n'
                    '3. Details of Office, Phone No.: _____\n'
                    '4. Present Address: _____\n'
                    '5. Previous Residence Address: _____\n'
                    '6. Permanent Address and Phone Number: _____\n'
                    '7. Family Members: _____\n',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
