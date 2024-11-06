import 'package:flutter/material.dart';

class ShopHoursFormView extends StatelessWidget {
  final int shopId;
  final int? hoursId; // Optional: if you want to edit existing shop hours.

  const ShopHoursFormView({super.key, required this.shopId, this.hoursId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hoursId == null ? 'Add Shop Hours' : 'Edit Shop Hours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Day of the Week'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Opening Time'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Closing Time'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save shop hours logic
              },
              child: const Text('Save Shop Hours'),
            ),
          ],
        ),
      ),
    );
  }
}
