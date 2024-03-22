import 'package:flutter/material.dart';
import './recipe.dart';
void main() {
  runApp(RecipeDiscoveryApp());
}


class RecipeDiscoveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Discovery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Recipe> recipes = [
    Recipe(
      imageUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.madhuseverydayindian.com%2Fwp-content%2Fuploads%2F2021%2F01%2Fdosa-made-with-rice-flour-1024x1024.jpg&f=1&nofb=1&ipt=69634a2b0311a7687dd5ba4f4632af2afbd4dbbeb5e906a99ed96809825cfe66&ipo=images',
      title: 'Dosa',
      description:
          'Dosa is a fermented crepe made from rice batter and black lentils.',
      nutritionalValue: 'Calories: 200 | Protein: 5g | Fat: 2g | Carbs: 40g',
      isFavorite: false,
    ),
    Recipe(
      imageUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fivebeenbit.ca%2Fwp-content%2Fuploads%2F2020%2F04%2F254-Pizza-Italy-Top-10-European-Foods.jpg&f=1&nofb=1&ipt=5df7f27b8b4374c36133a30d991eaec98130aa904bc9dabdfcaece0d15d1e744&ipo=images',
      title: 'Pizza',
      description:
          'Pizza is a savory dish of Italian origin, consisting of a usually round, flattened base of leavened wheat-based dough.',
      nutritionalValue: 'Calories: 300 | Protein: 10g | Fat: 15g | Carbs: 25g',
      isFavorite: false,
    ),
    Recipe(
      imageUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthecraftingfoodie.com%2Fimages%2Fold%2F6a014e8748a9fb970d017eea5a0db4970d-pi.jpg&f=1&nofb=1&ipt=c70bfd8d211b885df569972d74a8f5d206a864a6ab85409642f7a0be3f2f5150&ipo=images',
      title: 'Cake',
      description:
          'Cake is a form of sweet food made from flour, sugar, and other ingredients, that is usually baked.',
      nutritionalValue: 'Calories: 250 | Protein: 3g | Fat: 10g | Carbs: 35g',
      isFavorite: false,
    ),
    Recipe(
      imageUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi0.wp.com%2Fcarameltintedlife.com%2Fwp-content%2Fuploads%2F2020%2F05%2FThe-best-butter-chicken-recipe-1-of-1-5-scaled.jpg%3Ffit%3D1367%252C2048%26ssl%3D1&f=1&nofb=1&ipt=bff71c38390bbba8c3808e4681da680f1de279d661e8add485e2ce47e4bd18be&ipo=images',
      title: 'Butter Chicken',
      description:
          'Butter chicken is a dish, originating in the Indian subcontinent, of chicken in a mildly spiced tomato sauce.',
      nutritionalValue: 'Calories: 350 | Protein: 20g | Fat: 15g | Carbs: 25g',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      drawer: Drawer(
        // Side Menu Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(recipes: recipes),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Shopping List'),
              onTap: () {
                // Navigate to shopping list screen
              },
            ),
          ],
        ),
      ),
      body: RecipeGrid(recipes: recipes),
      // Display recipe cards in a GridView
      bottomNavigationBar: BottomNavigationBar(
        // Bottom Navigation Bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle bottom navigation item tap
        },
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;

  RecipeGrid({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(recipes.length, (index) {
        return RecipeCard(
          recipe: recipes[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipeDetailScreen(recipe: recipes[index]),
              ),
            );
          },
        );
      }),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  RecipeCard({
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(
              recipe.imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.recipe.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.recipe.imageUrl,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.recipe.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: _isFavorite
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                            widget.recipe.isFavorite = _isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.recipe.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nutritional Value:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.recipe.nutritionalValue,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> recipes;

  FavoritesScreen({required this.recipes});

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes =
        recipes.where((recipe) => recipe.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteRecipes[index].title),
            leading: Image.network(
              favoriteRecipes[index].imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
