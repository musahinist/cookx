import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../store/recipe/recipe_store.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'search_page.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key? key,
  }) : super(key: key);
  static const String $PATH = '/';
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _selectedIndex = 0;
  late RecipeStore _recipeStore;
  late List<ReactionDisposer> _disposers;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _recipeStore = Provider.of<RecipeStore>(context)..getRecipes();
    _disposers = [
      reaction(
        (_) => _recipeStore.errorMessage,
        // Run some logic with the content of the observed field
        (String? message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message!),
            ),
          );
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [HomePage(), SearchPage(), FavoritesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages.elementAt(_selectedIndex),

        //  floatingActionButtonLocation: FloatingActionButtonLocation.,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          elevation: 0,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ));
  }
}
