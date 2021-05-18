import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../store/recipe_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RecipeStore _recipeStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _recipeStore = Provider.of<RecipeStore>(context)..getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(builder: (_) {
          switch (_recipeStore.state) {
            case StoreState.loaded:
              return const Text('Loaded');
            case StoreState.error:
              return Text(_recipeStore.errorMessage!);

            default:
              return const Text('ınital/Loading');
          }
        }),
      ),
    );
  }
}
