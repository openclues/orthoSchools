import 'dart:convert';

import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/home_screen/data/models/pagination_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/articles_repo.dart';

part 'articales_cubit_state.dart';

class ArticalesCubitCubit extends Cubit<ArticalesCubitState> {
  ArticlesRepo articlesRepo = ArticlesRepo();
  ArticalesCubitCubit() : super(ArticalesCubitInitial());

  loadArticles({String? category, bool? following}) async {
    emit(ArticalesLoading());

    var response = await articlesRepo.getArticles(
        category: category, following: following);
    if (response.statusCode == 200) {
      PageModel<ArticlesModel> pageModel = PageModel<ArticlesModel>.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
          (json) => ArticlesModel.fromJson(json));

      emit(ArticalesLoaded(pageModel: pageModel));
    } else {
      emit(const ArticalesError(message: 'Error loading articles'));
    }
  }
}
