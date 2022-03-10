import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      actions: [
        Text(
          'OX',
          style: TextStyle(
              fontSize: 45, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: Theme.of(context).iconTheme,
      elevation: 0,
    );
  }
}
