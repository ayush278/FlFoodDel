class CategoryModel {
  String imagePath;
  String imageName;
  bool isSelected = false;
  CategoryModel(
      {required this.imagePath,
      required this.imageName,
      this.isSelected = false});
}
