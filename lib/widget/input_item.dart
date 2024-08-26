import 'package:flutter/material.dart';

Widget buildInputItem(
    {required String title,
    required String subtitle,
    required String hintText,
    String? initValue,
    Function(String)? onSubmitted}) {
  return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(children: [
        ListTile(
          minTileHeight: 0,
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.black45),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            initialValue: initValue ?? '',
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w300),
                constraints: const BoxConstraints(maxHeight: 40),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                )),
          ),
        )
      ]));
}
