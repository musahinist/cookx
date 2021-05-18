import 'dart:ui';

import 'package:flutter/material.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(32),
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://s01.sgp1.cdn.digitaloceanspaces.com/article/143395-pysnzzzleh-1593090551.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 136,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '25-30 min.',
                        style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₺35.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Big Burger',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: const Text("McDonald's"),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  '4.7',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.amber,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
