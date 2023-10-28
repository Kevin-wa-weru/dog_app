import 'package:flutter/material.dart';

class DashBoardAppBar extends StatelessWidget with PreferredSizeWidget {
  const DashBoardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: const TabBar(
        tabs: [
          Tab(child: Text('Tab One')),
          Tab(child: Text('Tab Two')),
          Tab(child: Text('Tab Three')),
          Tab(child: Text('Tab Four')),
        ],
      ),
      title: const Text('Dog ceo'),
      backgroundColor: Colors.teal,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
