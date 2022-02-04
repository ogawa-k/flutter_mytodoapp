import 'package:flutter/material.dart';

import 'post_list.dart';
import 'side_navigation.dart';

class AdminMobilePage extends StatelessWidget {
  const AdminMobilePage({ Key? key }) : super(key: key);
  static String routeName = '/ui/admin_mobile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          SideNavigation(),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: PostList(),
          ),
        ],
      ),
    );
  }
}