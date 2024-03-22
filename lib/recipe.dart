class Recipe {
  final String imageUrl;
  final String title;
  final String description;
  final String nutritionalValue;
  bool isFavorite;

  Recipe({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.nutritionalValue,
    this.isFavorite = false,
  });
}