import 'package:equatable/equatable.dart';

class PageModel<T> extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<T> results;

  PageModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PageModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    print(json);
    print("++++++++++++++++++++++++++++++++++");
    print(fromJsonT);
    return PageModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List<dynamic>).map((e) => fromJsonT(e)).toList(),
    );
  }

  PageModel<T> copyWith({
    int? count,
    String? next,
    String? previous,
    List<T>? results,
  }) {
    return PageModel<T>(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [count, next, previous, results];
}
