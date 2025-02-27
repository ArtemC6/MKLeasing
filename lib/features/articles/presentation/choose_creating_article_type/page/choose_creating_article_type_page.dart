import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/articles/presentation/article_add/page/article_add_page.dart';
import 'package:leasing_company/features/articles/presentation/choose_creating_article_type/bloc/choose_creating_article_type_bloc.dart';
import 'package:leasing_company/features/articles/presentation/choose_creating_article_type/bloc/choose_creating_article_type_event.dart';
import 'package:leasing_company/features/articles/presentation/choose_creating_article_type/bloc/choose_creating_article_type_state.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';


class ChooseCreatingArticleTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ChooseCreatingArticleTypePageState();
}

class _ChooseCreatingArticleTypePageState
    extends State<ChooseCreatingArticleTypePage> {
  final ToastService toastService = getIt();
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseCreatingArticleTypeBloc,
        ChooseCreatingArticleTypeState>(
      listener: (context, state) {
        if (state is ChooseCreatingArticleTypeChoosenState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleAddPage(state.articleTypeId),
            ),
          );
        }
        if (state is ChooseCreatingArticleTypeLoadFailureState) {
          toastService.showFailureToast(
            context,
            S.of(context).internetConnectionError,
          );
        }
      },
      // ignore: missing_return
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () {
            BlocProvider.of<ChooseCreatingArticleTypeBloc>(context)
                .add(ChooseCreatingArticleTypeRefreshEvent(_refreshCompleter));
            return _refreshCompleter.future;
          },
          child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: Text(
                S.of(context).chooseCreatingArticleType,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
            ),
            body: BlocBuilder<ChooseCreatingArticleTypeBloc,
                ChooseCreatingArticleTypeState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is ChooseCreatingArticleTypeLoadInProgressState) {
                  return  Center(child: CircularProgressIndicator());
                }

                if (state is ChooseCreatingArticleTypeLoadSuccessState) {
                  if (state.articleTypes.length > 0) {
                    return ListView.builder(
                      itemCount: state.articleTypes.length,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 8, bottom: 40),
                      itemBuilder: (BuildContext context, int index) =>
                          _makeArticleTypeRow(state.articleTypes[index]),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.center,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: S.of(context).noAvailableArticleTypes,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20.0),
                                ),
                              ])),
                        )
                      ],
                    );
                  }
                }
                return OnCenterWidget(
                    message: S
                        .of(context)
                        .choosingCreatingArticleTypeInternetException);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _makeArticleTypeRow(ArticleType articleType) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 12),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<ChooseCreatingArticleTypeBloc>(context)
              .add(ChooseCreatingArticleTypeHandleButtonEvent(articleType.id));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFE1E1E1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    articleType.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.fromLTRB(9, 8, 8, 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF246BFD).withOpacity(0.06),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xFF246BFD),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
