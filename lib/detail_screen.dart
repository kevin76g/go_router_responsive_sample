import 'package:flutter/material.dart';
import 'package:go_router_responsive_sample/detail_widget.dart';

class DetailScreen extends StatefulWidget {
  final String index;
  const DetailScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Screen'),
        ),
        body: DetailWidget(index: widget.index));
  }
}
