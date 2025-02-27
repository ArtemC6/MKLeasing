import 'package:leasing_company/core/drift/drift.dart';



class ArticleAddState {
  final bool loading;
  final bool sending;

  final ArticleType? articleType;
  final List<ArticleTypeProperty>? articleTypeProperties;
  final Map errors;

  ArticleAddState(
      {this.loading = true,
      this.sending = false,
      this.articleType,
      this.articleTypeProperties,
      this.errors = const {}});

  ArticleAddState copyWith(
      {bool? loading,
      bool? sending,
      ArticleType? articleType,
      List<ArticleTypeProperty>? articleTypeProperties,
      Map? errors}) {
    return ArticleAddState(
      loading: loading ?? this.loading,
      sending: sending ?? this.sending,
      articleType: articleType ?? this.articleType,
      articleTypeProperties:
          articleTypeProperties ?? this.articleTypeProperties,
      errors: errors ?? this.errors,
    );
  }
}

class ArticleAddSuccessState extends ArticleAddState {}

class ArticleAddFailureState extends ArticleAddState {}
