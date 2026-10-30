import 'dart:async';
import 'package:flutter/material.dart';
import '../data/messages_data.dart';
import '../models/prayer_message.dart';

class PrayerLockScreen extends StatefulWidget {
  final Duration lockDuration;
  const PrayerLockScreen({super.key, required this.lockDuration});

  @override
  State<PrayerLockScreen> createState() => _PrayerLockScreenState();
}

class _PrayerLockScreenState extends State<PrayerLockScreen> {
  late int _secondsLeft;
  int _messageIndex = 0;
  Timer? _timer;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.lockDuration.inSeconds;
    _startCountdown();
    _startMessageRotation();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        _endLock();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _startMessageRotation() {
    _messageTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        setState(() => _messageIndex = (_messageIndex + 1) % prayerMessages.length);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _messageTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  void _nextMessage() {
    setState(() => _messageIndex = (_messageIndex + 1) % prayerMessages.length);
  }

  void _endLock() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final PrayerMessage msg = prayerMessages[_messageIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0A1F2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                _formatTime(_secondsLeft),
                style: const TextStyle(color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold),
              ),
              const Text('الوقت المتبقي', style: TextStyle(color: Colors.white54, fontSize: 14)),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                child: Container(
                  key: ValueKey(_messageIndex),
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.teal.withOpacity(0.4)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        msg.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 24, height: 1.8),
                      ),
                      const SizedBox(height: 14),
                      if (msg.source.isNotEmpty)
                        Text(
                          msg.source,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _endLock,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 58),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('صليت', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _nextMessage,
                child: const Text('رسالة أخرى', style: TextStyle(color: Colors.white54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
