import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_search_widget.dart';
import 'package:leasing_company/core/presentation/widgets/missing_and_can_create.dart';
import 'package:leasing_company/core/presentation/widgets/missing_and_can_not_create.dart';
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_bloc.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_event.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_state.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/models/article_sorting.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/widgets/article_item_widget.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/widgets/review_item_status.dart';
import 'package:leasing_company/generated/l10n.dart';

import 'article_details_page.dart';

class ArticlesListPage extends StatefulWidget {
  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  ArticleSorting sorting = ArticleSorting.all;

  @override
  Widget build(BuildContext context) {
    Completer<void> refreshCompleter = Completer<void>();

    return BlocProvider<ArticlesListBloc>(
      create: (context) => ArticlesListBloc(),
      child: BlocBuilder<ArticlesListBloc, ArticlesListState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                elevation: 0,
                title: Row(
                  children: [
                    Text(
                      S.of(context).objects,
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                leading: SvgPicture.asset(
                  'assets/icons/objects.svg',
                  color: Colors.black,
                  fit: BoxFit.scaleDown,
                  width: 28,
                  height: 28,
                ),
                bottom: PreferredSize(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ArticleSorting.values
                              .map(
                                (status) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: BuildFilterItem(
                                      text: status.name(context),
                                      isEnable: sorting == status,
                                      color: Color(0xFF246BFD),
                                      onTap: (isEnable) {
                                        setState(() {
                                          sorting = status;
                                        });
                                      },
                                      height: 38,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                        ),
                      ),
                    ],
                  ),
                  preferredSize: Size(double.infinity, 50),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        context.read<ArticlesListBloc>().add(SearchShowingModeChangedEvent());
                      },
                      splashColor: Colors.black.withOpacity(0.05),
                      highlightColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        'assets/icons/search.svg',
                        color: Color(0xFF005AEA),
                        fit: BoxFit.scaleDown,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () {
                  context.read<ArticlesListBloc>().add(ArticlesRefreshEvent(refreshCompleter));
                  return refreshCompleter.future;
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      BlocBuilder<ArticlesListBloc, ArticlesListState>(
                        builder: (context, state) {
                          if (state is ArticlesLoadInProgressState) {
                            return Container(
                              alignment: Alignment.center,
                              height: 300,
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is ArticlesNeedToChooseCompanyState) {
                            return Center(
                              child: Text(S.of(context).articlesScreenNeedToChooseCompany),
                            );
                          }
                          if (state is ArticlesLoadSuccessState) {
                            if (refreshCompleter.isCompleted) {
                              refreshCompleter = Completer<void>();
                            }

                            return ArticleList(
                              sorting: sorting,
                            );
                          }
                          return OnCenterWidget(message: S.of(context).articlesScreenNetworkException);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArticleList extends StatefulWidget {
  final ArticleSorting sorting;
  const ArticleList({Key? key, required this.sorting}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
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

  Map<Article, List<Article>> protoArticles = {};
  Map<Article, List<Article>> articles = {};

  @override
  void initState() {
    final state = BlocProvider.of<ArticlesListBloc>(context).state as ArticlesLoadSuccessState;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final parentIds = state.articles
          .where((element) {
            var parentIds = jsonDecode(element.parentsIds.toString()) as List;

            return parentIds.isEmpty;
          })
          .map((e) => e)
          .toList();

      parentIds.forEach((el) {
        articles[el] = state.articles.where((element) {
          var parents = jsonDecode(element.parentsIds.toString()) as List;

          if (parents.contains(el.remoteId)) {
            return true;
          }

          return false;
        }).toList();

        if (articles[el]?.isEmpty ?? true) {
          articles.remove(el);
        }
      });

      protoArticles = articles;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesListBloc, ArticlesListState>(
      builder: (context, state) {
        if (state is ArticlesLoadSuccessState)
          return Column(
            children: [
              if (state.isSearchShowing)
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFEEEEEE),
                  ),
                  child: CustomSearchWidget(
                    initialValue: state.searchText,
                    onChanged: (searchText) {
                      if (widget.sorting != ArticleSorting.group) {
                        context.read<ArticlesListBloc>().add(SearchArticlesEvent(searchText));
                      } else {
                        var foundArticles = protoArticles.keys.where((element) => element.title.toUpperCase().contains(searchText.toUpperCase()));
                        articles = {};
                        foundArticles.forEach((element) {
                          articles[element] = protoArticles[element] ?? [];
                        });
                        setState(() {});
                      }
                    },
                  ),
                ),
              SizedBox(
                height: 12,
              ),
              context.read<ArticlesListBloc>().articles.isNotEmpty
                  ? state.articles.isNotEmpty
                      ? widget.sorting == ArticleSorting.group
                          ? articles.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(16, 8, 16, 30),
                                  itemCount: articles.keys.length,
                                  itemBuilder: (context, index) {
                                    List articleIds = [
                                      articles.keys.toList()[index].id,
                                    ];

                                    articleIds.addAll(articles[articles.keys.toList()[index]]?.map((e) => e.id).toList() ?? []);

                                    _findChilds(
                                      articles[articles.keys.toList()[index]] ?? [],
                                      index,
                                      state,
                                      articleIds,
                                    );

                                    final articleTemplatesIds = state.templatesToArticles.where((element) => articleIds.contains(element.articleId)).map(
                                          (e) => e.templateId,
                                        );

                                    final templatesToArticle = state.templates.where((template) => articleTemplatesIds.contains(template.id)).toList();

                                    return ArticleListItem(
                                      globalArticles: state.articles,
                                      articles: articles,
                                      padding: EdgeInsets.only(bottom: 16),
                                      reviews: state.reviews,
                                      templates: templatesToArticle,
                                      index: index,
                                    );
                                  })
                              : (state.isSearchShowing)
                                  ? _NotFoundSearchBanner()
                                  : _NotFoundGroupsBanner()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 30),
                              itemCount: state.articles.length,
                              itemBuilder: (context, index) {
                                final articleTemplatesIds =
                                    state.templatesToArticles.where((e) => e.articleId == state.articles[index].id).map((e) => e.templateId);
                                final templatesToArticle = state.templates.where((template) => articleTemplatesIds.contains(template.id)).toList();

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: ArticleItemWidget(
                                    article: state.articles[index],
                                    reviews: state.reviews,
                                    templates: templatesToArticle,
                                    properties: state.properties ?? [],
                                  ),
                                );
                              })
                      : _NotFoundSearchBanner()
                  : widget.sorting == ArticleSorting.group
                      ? _NotFoundGroupsBanner()
                      : Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                            // ListView(
                            //   physics: AlwaysScrollableScrollPhysics(
                            //     parent: BouncingScrollPhysics(),
                            //   ),
                            // ),
                            state.currentCompany?.config.canCreateArticles == true
                                ? MissingAndCanCreateWidget(
                                    missingItemsName: S.of(context).objects,
                                    description: S.of(context).articlesScreenAvailabledArticleNotFoundCanRegister1,
                                    onCreateButtonTap: () => Navigator.pushNamed(context, '/articleTypes/choose'),
                                  )
                                : MissingAndCanNotCreateWidget(
                                    missingItemsName: S.of(context).missingObjectsName,
                                  ),
                          ],
                        ),
            ],
          );

        return SizedBox.shrink();
      },
    );
  }
}

class _NotFoundSearchBanner extends StatelessWidget {
  const _NotFoundSearchBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Text(
              S.of(context).objectsWithThisNameNotFound,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        Container(
          height: 200,
        )
      ],
    );
  }
}

class _NotFoundGroupsBanner extends StatelessWidget {
  const _NotFoundGroupsBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 7,
        horizontal: 40,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Группы объектов отсутствуют',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF246BFD),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'Перейдите ',
                style: TextStyle(color: Colors.black87, fontSize: 17.0),
              ),
              TextSpan(
                text: 'в список Объектов ',
                style: TextStyle(color: Colors.blue, fontSize: 17.0),
                // recognizer: TapGestureRecognizer()..onTap = Navigator.pushNamed(context, '/articleTypes/choose'),
              ),
              TextSpan(
                text: 'по вкладке "Все" ',
                style: TextStyle(color: Colors.black87, fontSize: 17.0),
                // recognizer: TapGestureRecognizer()..onTap = Navigator.pushNamed(context, '/articleTypes/choose'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class ArticleListItem extends StatelessWidget {
  final List<Review> reviews;
  final List<ReviewTemplate> templates;
  final List<Article> globalArticles;
  final EdgeInsets padding;

  const ArticleListItem({
    Key? key,
    required this.articles,
    required this.index,
    required this.reviews,
    required this.templates,
    required this.globalArticles,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Map<Article, List<Article>> articles;
  final int index;

  @override
  Widget build(BuildContext context) {
    final articleItem = articles.keys.toList()[index];
    List<int> articlesIds = [
      articleItem.remoteId,
    ];
    final reviewsList = reviews.where(
      (Review review) {
        articles[articles.keys.toList()[index]]?.forEach((element) {
          articlesIds.add(element.remoteId);
        });

        globalArticles.forEach((element) {
          if (!articlesIds.contains(element.remoteId)) {
            final parentIds = jsonDecode(element.parentsIds ?? '[]');
            if ((parentIds as List).isNotEmpty) {
              (parentIds).forEach((e) {
                if (articlesIds.contains(e)) {
                  articlesIds.add(element.remoteId);
                }
              });
            }
          }
        });

        return articlesIds.contains(review.remoteArticleId);
      },
    ).toList();
    final templatesList = templates.where((template) {
      return template.private;
    }).toList();

    final reviewsCount = reviewsList.length + templatesList.length;

    final bool containsSubtitle = articleItem.subtitle != null && articleItem.subtitle != '';

    return Container(
      padding: padding,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            height: containsSubtitle ? 165 : 120,
            margin: EdgeInsets.symmetric(horizontal: 30),
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
            ),
          ),
          Container(
            height: containsSubtitle ? 150 : 108,
            margin: EdgeInsets.symmetric(horizontal: 15),
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
            ),
          ),
          Container(
            height: containsSubtitle ? 135 : 95,
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
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailsPage(
                      articles: globalArticles,
                      firstChild: articles[articles.keys.toList()[index]]?.first.title ?? '',
                      parent: articles.keys.toList()[index],
                      articleOfParent: articles[articles.keys.toList()[index]] ?? [],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 6, right: 6),
                                          child: SvgPicture.asset(
                                            'assets/icons/articles.svg',
                                            color: Color(0xFF909090),
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                        if (reviewsCount > 0)
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFF981F),
                                                shape: BoxShape.circle,
                                                borderRadius: null,
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
                                          ),
                                      ],
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${articleItem.title}',
                                                maxLines: 1,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              if (containsSubtitle)
                                                Container(
                                                  padding: EdgeInsets.only(top: 5, bottom: 8),
                                                  // width: 180,
                                                  child: Text(
                                                    '${articleItem.subtitle}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              Text(
                                                S.of(context).articleDetailsContainsObjects('${articles[articles.keys.toList()[index]]?.length ?? 0}'),
                                                style: TextStyle(fontSize: 14, color: Color(0xff949494)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Color(0xFF246BFD),
                                size: 36,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
