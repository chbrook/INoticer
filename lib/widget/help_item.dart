import 'package:flutter/material.dart';

Widget buildHelpItem(String title, {String? content, Widget? contentWidget}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 10),
      contentWidget ??
          Text(
            content ?? '',
            style: const TextStyle(
                fontSize: 14, color: Colors.black54, height: 1.6),
          ),
    ],
  );
}
