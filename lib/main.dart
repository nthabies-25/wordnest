import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //var current = WordPair.random();
  


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'WordNest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light
            ),
          scaffoldBackgroundColor: Color(0xFFF6F2FF),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFF6F2FF),
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
              elevation: 4,
              margin: EdgeInsets.all(16),
            ),
          ),
        
        home: MyHomePage(),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  
  void getNext() {                //reassigns current with a new random WordPair
    current = WordPair.random();
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
}
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        
      case 1:
        page = FavoritesPage();
        
      default:
        throw UnimplementedError('no widget for $selectedIndex');
}

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,    // ← Change to this.
                  onDestinationSelected: (value){
                    setState(() {
                      selectedIndex = value;
                    });
        
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

   
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;

    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),

          SizedBox(height: 10),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),

              SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 6,
      color: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 35,
        ),
        child: Text(
          pair.asLowerCase,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}



class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 70,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 16),
            Text(
              'No favorites yet!',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 8),
            Text('Like some words to save them here.'),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'My Favorite Words',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${appState.favorites.length} saved words',
        ),
        SizedBox(height: 20),

        for (var pair in appState.favorites)
          Card(
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.deepPurple,
              ),
              title: Text(
                pair.asLowerCase,
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  appState.removeFavorite(pair);
                },
              ),
            ),
          ),
      ],
    );
  }
}
