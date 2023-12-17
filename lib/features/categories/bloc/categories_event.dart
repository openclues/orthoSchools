part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesData extends CategoriesEvent {
  final List<CategoryModel>? categories;
  LoadCategoriesData({
    this.categories,
  });
}
