class CategoryModel {
  String? name;
  String? image;
  bool? isSelected;
  int? id;

  CategoryModel({this.name, this.image, this.id, this.isSelected});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        name: json['name'],
        image: json['image'],
        id: json['id'],
        isSelected: json['isSelected']);
  }
}

// dubmmy data

List<CategoryModel> interests = [
  CategoryModel(
    name: 'Art',
    image: 'assets/images/art.png',
    id: 1,
    isSelected: true,
  ),
  CategoryModel(
    name: 'Business',
    image: 'assets/images/business.png',
    id: 2,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Education',
    image: 'assets/images/education.png',
    id: 3,
    isSelected: true,
  ),
  CategoryModel(
    name: 'Entertainment',
    image: 'assets/images/entertainment.png',
    id: 4,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Family',
    image: 'assets/images/family.png',
    id: 5,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Food',
    image: 'assets/images/food.png',
    id: 6,
    isSelected: true,
  ),
  CategoryModel(
    name: 'Health',
    image: 'assets/images/health.png',
    id: 7,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Hobbies',
    image: 'assets/images/hobbies.png',
    id: 8,
    isSelected: true,
  ),
  CategoryModel(
    name: 'Home',
    image: 'assets/images/home.png',
    id: 9,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Lifestyle',
    image: 'assets/images/lifestyle.png',
    id: 10,
    isSelected: true,
  ),
  CategoryModel(
    name: 'Music',
    image: 'assets/images/music.png',
    id: 11,
    isSelected: false,
  ),
  CategoryModel(
    name: 'News',
    image: 'assets/images/news.png',
    id: 12,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Pets',
    image: 'assets/images/pets.png',
    id: 13,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Politics',
    image: 'assets/images/politics.png',
    id: 14,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Science',
    image: 'assets/images/science.png',
    id: 15,
    isSelected: false,
  ),
  CategoryModel(
    name: 'Shopping',
    image: 'assets/images/shopping.png',
    id: 16,
    isSelected: false,
  ),
];
