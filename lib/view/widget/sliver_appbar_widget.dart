import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    //  DimensionConfig().init(context);
    return SliverAppBar(
      expandedHeight: 250.0,
      backgroundColor: Colors.amber,
      elevation: 0,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white)),
        ),
        // Image(
        //   image: NetworkImage(
        //     "https://image.freepik.com/free-vector/burger-logo_1366-144.jpg",
        //   ),
        // ),
        // titlePadding: EdgeInsetsDirectional.only(top: 150),

        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            //   color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
      ),
      //  toolbarHeight: 56,
    );
  }
}
