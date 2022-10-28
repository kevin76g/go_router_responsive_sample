import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final String index;
  const DetailWidget({required this.index, Key? key}) : super(key: key);

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Details for entry ${widget.index}',
      style: const TextStyle(fontSize: 30.0),
    ));
  }
}
