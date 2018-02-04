class Meal {
  final int id;
  final String name;
  final Map<String, double> prices;
  final String category;
  final List<String> notes;

  Meal(this.id, this.name, this.prices, this.category, this.notes);
}