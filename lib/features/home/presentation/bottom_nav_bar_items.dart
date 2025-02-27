import 'package:flutter/cupertino.dart';
import 'package:leasing_company/features/main/presentation/page/main_page.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/page/review_list_page.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/pages/tasks_list_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/features/articles/presentation/aricles_list/page/articles_list_page.dart';

enum Modules {
  main,
  objects,
  reviews,
  tasks,
}

extension ModulesInfo on Modules {
  int getIndex(){
    switch(this){
      case Modules.main: return 0;
      case Modules.objects: return 1;
      case Modules.reviews: return 2;
      case Modules.tasks: return 3;
    }
  }

  String iconAsset() {
    switch (this) {
      case Modules.main:
         return 'assets/icons/home.svg';
      case Modules.objects:
        return 'assets/icons/objects.svg';
        case Modules.reviews:
          return 'assets/icons/checks.svg';
      case Modules.tasks:
        return 'assets/icons/tasks.svg';
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case Modules.main:
        return S.of(context).main;
      case Modules.objects:
        return S.of(context).objects;
      case Modules.reviews:
        return S.of(context).reviews;
      case Modules.tasks:
        return S.of(context).tasks;
    }
  }

  Widget getScreen() {
    switch (this) {
      case Modules.main:
        return MainPage();
      case Modules.objects:
        return ArticlesListPage();
      case Modules.reviews:
        return ReviewListPage();
      case Modules.tasks:
        return TasksListPage();
    }
  }
}
