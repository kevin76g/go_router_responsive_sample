import 'package:flutter/material.dart';
import 'package:go_router_responsive_sample/detail_widget.dart';
import 'package:go_router_responsive_sample/list_widget.dart';
import 'package:go_router_responsive_sample/main.dart';

class ListScreen extends StatefulWidget {
  final String? argIndex;
  const ListScreen({this.argIndex, Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String index = '';
  bool isLargeScreen = false;

  @override
  void initState() {
    super.initState();
    if (widget.argIndex != null) {
      index = widget.argIndex!;
    } else {
      index = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    isLargeScreen = MediaQuery.of(context).size.width > largeScreenSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('${isLargeScreen ? "List & Detail" : "List"} Screen'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListWidget(
              onItemSelected: (value) {
                setState(() {
                  index = value;
                });
              },
            ),
          ),
          isLargeScreen
              ? Expanded(flex: 5, child: DetailWidget(index: index))
              : Container(),
        ],
      ),
    );
  }
}
