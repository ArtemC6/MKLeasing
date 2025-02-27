import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_bloc.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/bloc/articles_event.dart';
import 'package:leasing_company/features/articles/presentation/passport_page/bloc/passport_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/choose_review_template/page/choose_review_template_page.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/page/create_edit_task_page.dart';
import 'package:leasing_company/generated/l10n.dart';

class ArticlePassportPage extends StatefulWidget {
  final Article article;
  final List<PropertiesArticle> properties;

  const ArticlePassportPage({
    required this.article,
    required this.properties,
  }) : super();

  @override
  _ArticlePassportPageState createState() => _ArticlePassportPageState();
}

class _ArticlePassportPageState extends State<ArticlePassportPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PassportBloc()
        ..add(
          GetPassportProperties(
            article: widget.article,
            companyUuid: widget.article.companyUuid,
          ),
        ),
      child: BlocBuilder<PassportBloc, PassportState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              bottom: PreferredSize(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
                preferredSize: Size.fromHeight(1.5),
              ),
              title: Text(
                S.of(context).articlePassportHeader,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
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
            body: state is PassportInitial
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.title,
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                              fontSize: 26.0,
                            ),
                          ),
                          SizedBox(height: 24),
                          if (widget.article.subtitle != '' && widget.article.subtitle != null)
                            Text(
                              widget.article.subtitle!,
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF222222),
                                fontSize: 16.0,
                              ),
                            ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => setState(() => isExpanded = !isExpanded),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFFC6D2CB1A).withOpacity(0.1)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1.0),
                                      spreadRadius: 0.1,
                                      blurRadius: 1.8,
                                      color: Colors.black.withOpacity(0.14),
                                    )
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                S.of(context).articlePassportBodyTitle,
                                                style: TextStyle(fontFamily: 'SF Pro Display', fontSize: 18, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                            isExpanded ? 'assets/icons/chevron_up.svg' : 'assets/icons/chevron_right.svg',
                                          ),
                                        ],
                                      ),
                                      if (isExpanded && widget.properties.where((element) => element.articleId == widget.article.id).isNotEmpty) ...[
                                        _buildExpandedCard(
                                          context: context,
                                          properties: widget.properties.where((element) => element.articleId == widget.article.id).toList(),
                                          title: (state as PassportTypesLoaded).types.first.name,
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _downloadsTile(
                            context: context,
                            article: widget.article,
                          ),
                        ],
                      ),
                    ),
                  ),
            floatingActionButton: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        height: 250,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 12,
                                bottom: 20,
                              ),
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffE0E0E0),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            Text(
                              S.of(context).selectAnAction,
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF222222),
                                fontSize: 20.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 24),
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.04),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CreateEditTaskPage(article: widget.article),
                                  ),
                                );
                                BlocProvider.of<ArticlesListBloc>(context).add(
                                  ArticlesLoadEvent(),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0, right: 8.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/checks.svg',
                                      color: Color(0xff246BFD),
                                    ),
                                  ),
                                  Text(
                                    S.of(context).createTask,
                                    style: TextStyle(
                                      color: Color(0xff246BFD),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            GestureDetector(
                              onTap: () async {
                                {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChooseReviewTemplatePage(
                                        article: widget.article,
                                      ),
                                    ),
                                  );
                                  BlocProvider.of<ArticlesListBloc>(context).add(
                                    ArticlesLoadEvent(),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0, right: 8.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/tasks.svg',
                                      color: Color(0xff246BFD),
                                    ),
                                  ),
                                  Text(
                                    S.of(context).articlesScreenCreateReviewButtonTitle,
                                    style: TextStyle(
                                      color: Color(0xff246BFD),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF246BFD)),
                child: Icon(Icons.add, color: Colors.white, size: 40),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedCard({
    required BuildContext context,
    required List<PropertiesArticle> properties,
    String? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 4),
          height: 1.5,
          decoration: BoxDecoration(
            color: Color(0xffCDDEFE),
          ),
        ),
        if (title != null && title != '') ...[
          SizedBox(height: 19),
          Text(
            S.of(context).articlePassportArticleType,
            style: TextStyle(color: Color(0xFF949494), fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
        ListView.builder(
          itemCount: properties.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (properties[index].value?.isNotEmpty ?? false)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 19),
                  Text(
                    properties[index].name!,
                    style: TextStyle(color: Color(0xFF949494), fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    properties[index].value!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            else
              return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

Widget _downloadsTile({required BuildContext context, required Article article}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        '/uploads',
        arguments: {
          'companyUuid': article.companyUuid,
          'articleRemoteId': article.remoteId,
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(color: Color(0xffF1F6FD), borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/share.svg',
            color: Color(0xff246BFD),
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 12),
          Text(
            S.of(context).articlesScreenSawDownloads,
            style: TextStyle(
              color: Color(0xff246BFD),
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
