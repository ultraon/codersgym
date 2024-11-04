import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppPaginationList extends StatelessWidget {
  const AppPaginationList({
    required this.itemBuilder,
    required this.itemCount,
    required this.moreAvailable,
    required this.loadMoreData,
    super.key,
  });
  final VoidCallback loadMoreData;
  final bool moreAvailable;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter.toInt() == 0) {
          // User has reached the end of the list
          // Load more data or trigger pagination in flutter
          loadMoreData();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: itemCount + 1, // Add 1 for loading indicator
        itemBuilder: (context, index) {
          if (index < itemCount) {
            return itemBuilder(context, index);
          } else {
            if (!moreAvailable) return Container();
            loadMoreData(); // fetch more data if reached the end of the list

            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
