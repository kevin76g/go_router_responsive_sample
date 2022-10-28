import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';

typedef ItemSelectedCallback = void Function(String value);

class ListWidget extends StatefulWidget {
  final ItemSelectedCallback? onItemSelected;

  const ListWidget({required this.onItemSelected, Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final List<int> entries = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 50; i++) {
      entries.add(i);
    }
  }

  void _onTapListTile(int index) {
    bool isLargeScreen = MediaQuery.of(context).size.width > largeScreenSize;
    if (isLargeScreen) {
      GoRouter.of(context).go('/large-list/${index.toString()}');
      widget.onItemSelected!(index.toString());
    } else {
      GoRouter.of(context).go('/list/detail/${index.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: entries.length,
              (BuildContext context, int index) {
            return ListTile(
              onTap: () => _onTapListTile(entries.elementAt(index)),
              shape: Border.all(width: 0.1, color: Colors.grey),
              trailing: const Icon(Icons.keyboard_double_arrow_right_sharp),
              title: Center(
                  child: Text(
                'Entry ${entries[index].toString()}',
                style: const TextStyle(fontSize: 20.0),
              )),
            );
          }),
        ),
      ],
    );
  }
}
