import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  DimensionConfig().init(context);
    return SliverAppBar(
      expandedHeight: 250.0,
      backgroundColor: Colors.amber,
      elevation: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Burger Story', style: TextStyle(color: Colors.white)),
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
                "https://s01.sgp1.cdn.digitaloceanspaces.com/article/143395-pysnzzzleh-1593090551.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      leadingWidth: 56,
      //  toolbarHeight: 56,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        //  color: Colors.red,
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          //  color: Colors.red,
          onPressed: () {},
        ),
        // SizedBox(
        //   width: 8,
        // ),
      ],
    );
  }
}
