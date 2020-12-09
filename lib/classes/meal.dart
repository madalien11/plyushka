class Meal {
  Meal(
      {this.id,
      this.categoryId,
      this.imageUrl,
      this.name,
      this.categoryName,
      this.subtitle,
      this.price,
      this.ingredients,
      this.description,
      this.hasCertificate,
      this.certificateImage});

  int id;
  int categoryId;
  String imageUrl;
  String name;
  String categoryName;
  String subtitle;
  int price;
  List<String> ingredients;
  String description;
  bool hasCertificate;
  String certificateImage;
}
