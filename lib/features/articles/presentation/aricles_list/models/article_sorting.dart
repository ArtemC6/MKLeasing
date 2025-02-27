import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

enum ArticleSorting {
  group,
  all,
}

extension ArticleSortingInfo on ArticleSorting {
  String name(BuildContext context) {
    switch (this) {
      case ArticleSorting.group:
        return S.of(context).articleListSortGroup;
      case ArticleSorting.all:
        return S.of(context).articleListSortAll;
    }
  }
}
