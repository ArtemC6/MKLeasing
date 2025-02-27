import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/page/article_passport_page.dart';

class ArticleItemWidget extends StatefulWidget {
  final Article article;
  final List<Review> reviews;
  final List<ReviewTemplate> templates;
  final List<PropertiesArticle> properties;

  ArticleItemWidget({
    required this.article,
    required this.templates,
    required this.reviews,
    required this.properties,
  });

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) => Container(
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticlePassportPage(
                article: widget.article,
                properties: widget.properties,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: _buildShortCard(context: context),
            ),
          ),
        ),
      );

  Widget _buildShortCard({required BuildContext context}) {
    final reviews = widget.reviews.where((Review review) => review.remoteArticleId == widget.article.remoteId).toList();
    final templates = widget.templates.where((template) => template.private).toList();
    final reviewsCount = reviews.length + templates.length;
    final containsSubtitle = widget.article.subtitle != null && widget.article.subtitle != '';

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6, right: 6),
                    child: SvgPicture.asset(
                      'assets/icons/objects.svg',
                      color: Color(0xFF909090),
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
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      if (containsSubtitle) ...[
                        SizedBox(height: 10),
                        Text(
                          widget.article.subtitle!,
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
        ],
      ),
    );
  }
}
