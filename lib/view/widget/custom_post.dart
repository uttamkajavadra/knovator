import 'package:flutter/material.dart';

class CustomPost extends StatefulWidget {
  const CustomPost({required this.id, required this.title, required this.second, required this.markAsRead, super.key});
  final String id;
  final String title;
  final int second;
  final int markAsRead;
  @override
  State<CustomPost> createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: (widget.markAsRead == 1) ? Colors.white : Colors.amber[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "${widget.id}. ${widget.title}",
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(formatDuration(widget.second))
        ],
      ),
    );
  }
}
