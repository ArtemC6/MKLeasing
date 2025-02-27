import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_search_widget.dart';
import 'package:leasing_company/core/presentation/widgets/dotted_vertical_line.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_bloc.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_state.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/page/article_passport_page.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/page/articles_list_page.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/widgets/article_item_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class ArticleDetailsPage extends StatefulWidget {
  final List<Article> articles;
  final String firstChild;
  final Article parent;
  final String? subtitle;
  final List<Article> articleOfParent;

  const ArticleDetailsPage({
    required this.articles,
    required this.firstChild,
    required this.parent,
    this.subtitle,
    required this.articleOfParent,
  }) : super();

  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  Map<Article, List<Article>> articles = {};
  Map<Article, List<Article>> protoArticles = {};
  late ArticlesListBloc _bloc;
  @override
  void initState() {
    _bloc = ArticlesListBloc(article: widget.parent);
    super.initState();
  }

  void _searchAction(String searchValue) {
    articles = {};
    protoArticles.map((key, value) {
      if (key.title.toUpperCase().contains(searchValue.toUpperCase())) {
        articles[key] = value;
      }
      return MapEntry(key, value);
    });
    setState(() {});
  }

  bool _search = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.parent.title,
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
            ),
          ),
          preferredSize: Size.fromHeight(1.5),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            color: Colors.black,
            fit: BoxFit.scaleDown,
            width: 28,
            height: 28,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<ArticlesListBloc, ArticlesListState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ArticlesLoadSuccessState) {
            var articleOfParentIds = widget.articleOfParent.map((e) => e.remoteId).toList();

            var articleOfParents = state.articles.where((element) => articleOfParentIds.contains(element.remoteId)).toList();

            articles = {};
            articleOfParents.forEach((el) {
              articles[el] = state.articles.where((element) {
                var parents = jsonDecode(element.parentsIds.toString()) as List;

                if (parents.contains(el.remoteId)) {
                  return true;
                }

                return false;
              }).toList();
            });

            protoArticles = articles;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).popUntil(ModalRoute.withName("/home"));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/articles.svg',
                                  color: Color(0xff246BFD),
                                  fit: BoxFit.scaleDown,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  S.of(context).articleDetailsToMainArticles,
                                  style: TextStyle(
                                    color: Color(0xff246BFD),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(left: 15),
                            onPressed: () {
                              setState(() {
                                _search = !_search;
                              });
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/search.svg',
                              color: Color(0xFF005AEA),
                              fit: BoxFit.scaleDown,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                      if (_search)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFEEEEEE),
                          ),
                          child: CustomSearchWidget(
                            onChanged: _searchAction,
                          ),
                        ),
                    ],
                  ),
                  if (state is ArticlesLoadSuccessState)
                    Column(
                      children: [
                        Builder(
                          builder: (context) {
                            var parent = state.articles.where((e) => e.remoteId == widget.parent.remoteId).first;

                            final articleTemplatesIds = state.templatesToArticles.where((e) => e.articleId == parent.id).map((e) => e.templateId);
                            final templatesToArticle = state.templates.where((template) => articleTemplatesIds.contains(template.id)).toList();

                            return _SelectedArticleItem(
                              title: widget.parent.title,
                              subtitle: widget.parent.subtitle,
                              article: widget.parent,
                              properties: state.properties ?? [],
                              reviews: state.reviews,
                              templates: templatesToArticle,
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: articles.keys.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var key = articles.keys.toList()[index];

                            if ((articles[key]?.length ?? 0) > 1) {}
                            return Column(
                              children: [
                                if (articles.keys.first == key)
                                  CustomPaint(
                                    size: Size(0, 40),
                                    painter: const DottedVerticalLinePainter(),
                                  ),
                                if ((articles[key]?.length ?? 0) > 1)
                                  Builder(
                                    builder: (context) {
                                      List articleIds = [
                                        key.id,
                                      ];

                                      articleIds.addAll(articles[key]?.map((e) => e.id).toList() ?? []);

                                      _findChilds(
                                        articles[key] ?? [],
                                        index,
                                        state,
                                        articleIds,
                                      );
                                      final articleTemplatesIds = state.templatesToArticles.where((element) => articleIds.contains(element.articleId)).map(
                                            (e) => e.templateId,
                                          );

                                      final templatesToArticle = state.templates.where((template) => articleTemplatesIds.contains(template.id)).toList();
                                      return ArticleListItem(
                                        articles: articles,
                                        index: index,
                                        reviews: state.reviews,
                                        templates: templatesToArticle,
                                        globalArticles: widget.articles,
                                      );
                                    },
                                  )
                                else
                                  Builder(
                                    builder: (context) {
                                      final articleTemplatesIds = state.templatesToArticles.where((e) => e.articleId == key.id).map((e) => e.templateId);
                                      final templatesToArticle = state.templates.where((template) => articleTemplatesIds.contains(template.id)).toList();
                                      return ArticleItemWidget(
                                        article: key,
                                        reviews: state.reviews.toList(),
                                        templates: templatesToArticle,
                                        properties: state.properties ?? [],
                                      );
                                    },
                                  ),
                                if (articles.keys.last != key)
                                  CustomPaint(
                                    size: Size(0, 16),
                                    painter: const DottedVerticalLinePainter(),
                                  ),
                              ],
                            );
                          },
                        )
                      ],
                    )
                  else
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _findChilds(
    List<Article> articles,
    int index,
    ArticlesLoadSuccessState state,
    List<dynamic> articleIds,
  ) {
    articles.forEach((element) {
      articleIds.add(element.id);
      final childArticles = state.articles
          .where(
            (e) => (jsonDecode(e.parentsIds ?? '[]') as List).contains(element.remoteId),
          )
          .toList();

      _findChilds(childArticles, index, state, articleIds);
    });
  }
}

class _SelectedArticleItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Article article;
  final List<PropertiesArticle> properties;
  final List<Review> reviews;
  final List<ReviewTemplate> templates;

  const _SelectedArticleItem({
    required this.title,
    required this.subtitle,
    required this.article,
    required this.properties,
    required this.reviews,
    required this.templates,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewsList = reviews.where((Review review) => review.remoteArticleId == article.remoteId).toList();
    final templatesList = templates.where((template) => template.private).toList();
    final reviewsCount = reviewsList.length + templatesList.length;

    final containsSubtitle = article.subtitle != null && article.subtitle != '';
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticlePassportPage(
              article: article,
              properties: properties,
            ),
          ),
        )
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffBDD3FE)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
            BoxShadow(color: Colors.white),
          ],
          color: Color(0xFFF2F6FD),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6, right: 6),
                  child: SvgPicture.asset(
                    'assets/icons/objects.svg',
                    color: Color(0xFF7CA6FE),
                    height: 32,
                    width: 32,
                  ),
                ),
                if (reviewsCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: reviewsCount >= 10 ? EdgeInsets.fromLTRB(4, 2, 4, 2) : EdgeInsets.fromLTRB(5.3, 2, 4.5, 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF981F),
                        shape: reviewsCount >= 10 ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius: reviewsCount >= 10 ? BorderRadius.circular(32) : null,
                      ),
                      child: Center(
                        child: Text(
                          reviewsCount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    if (containsSubtitle) ...[
                      SizedBox(height: 10),
                      Text(
                        article.subtitle!,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
