import 'package:flutter/material.dart';
import 'prayer_lock_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1F2E),
        title: const Text('مُذكّر الصلاة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'اضغط لتجربة شاشة وضع الصلاة',
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PrayerLockScreen(lockDuration: Duration(minutes: 15)),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('ابدأ وضع الصلاة (15 دقيقة)', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PrayerLockScreen(lockDuration: Duration(minutes: 1)),
                  ));
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: const BorderSide(color: Colors.teal),
                ),
                child: const Text('تجربة سريعة (1 دقيقة)', style: TextStyle(fontSize: 18, color: Colors.teal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
