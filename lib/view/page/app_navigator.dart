import 'package:cookx/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../store/recipe/recipe_store.dart';
import 'home_page.dart';
import 'search_page.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  static const String $PATH = '/';

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final List _pages = [HomePage.$PATH, SearchPage.$PATH];
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState!.canPop()) {
          _navigatorKey.currentState!.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey, reportsRouteUpdateToEngine: true,

          initialRoute: HomePage.$PATH, // _pages.elementAt(_selectedIndex),
          onGenerateRoute: AppRouter.generateRoute,
        ),
        appBar: AppBar(),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.red,
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    // _selectedIndex = 0;
                    // setState(() {});
                    // print("home");
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        HomePage.$PATH, (route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {
                    // _selectedIndex = 1;
                    // print("serach");
                    // setState(() {});
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        SearchPage.$PATH, (route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    Key? key,
  }) : super(key: key);

  static const String $PATH = '/AppNav';

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late List<ReactionDisposer> _disposers;
  late RecipeStore _recipeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recipeStore = Provider.of<RecipeStore>(context)..getRecipes();
    _disposers = [
      reaction(
        (_) => _recipeStore.errorMessage,
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomePage();
  }
}

class Deneme1 extends StatelessWidget {
  const Deneme1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("sdfsdf"),
    );
  }
}
