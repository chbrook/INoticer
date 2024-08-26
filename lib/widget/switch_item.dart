import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSwitchItem({
  required String title,
  required String subtitle,
  required bool value,
  Function(bool)? onChanged,
}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(
      subtitle,
      style: const TextStyle(color: Colors.black45),
    ),
    trailing: Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    ),
  );
}
