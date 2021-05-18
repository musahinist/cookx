import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({
    Key? key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.lightGreen[50],
      leading: const Icon(
        CupertinoIcons.slider_horizontal_3,
        color: Colors.black,
      ),
      elevation: 0,
      title: TextField(
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.blueGrey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: 'Search...'),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            CupertinoIcons.search,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
