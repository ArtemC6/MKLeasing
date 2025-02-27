import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:leasing_company/features/home/presentation/bottom_nav_bar_items.dart';
import 'package:leasing_company/features/home/presentation/widgets/custom_triangle_clipper.dart';
import 'package:leasing_company/features/make_report/presentation/create_review_page/page/create_review_page.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/page/create_edit_task_page.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/bloc/tasks.dart';
import 'package:leasing_company/generated/l10n.dart';

class MenuAddWidget extends StatelessWidget {
  final HomePageState state;
  final CompanyEntity company;

  const MenuAddWidget(this.company, {Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              _createRow(
                asset: 'assets/icons/checks.svg',
                text: S.of(context).review,
                state: state,
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateReviewPage()),
                  );
                  context.read<HomePageBloc>().add(AddButtonPressedEvent());
                },
              ),
              if (company.config.canCreateArticles == true)
                _createRow(
                  state: state,
                  asset: Modules.objects.iconAsset(),
                  text: S.of(context).object,
                  onTap: () {
                    Navigator.pushNamed(context, '/articleTypes/choose');
                    context.read<HomePageBloc>().add(AddButtonPressedEvent());
                  },
                ),
              _createRow(
                state: state,
                asset: Modules.tasks.iconAsset(),
                text: S.of(context).task,
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEditTaskPage()));
                  final _refreshCompleter = Completer<void>();
                  BlocProvider.of<TasksBloc>(context).add(TasksRefreshEvent(_refreshCompleter));

                  context.read<HomePageBloc>().add(AddButtonPressedEvent());
                },
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
        ClipPath(
          clipper: CustomTriangleClipper(),
          child: Container(
            color: Colors.white,
            height: 18,
            width: 30,
          ),
        ),
      ],
    );
  }

  Widget _createRow({
    required state,
    required String asset,
    required String text,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: state is HomePageReadyState
              ? state.isAddButtonPressed
                  ? Colors.white
                  : Colors.grey
              : Colors.white,
          statusBarIconBrightness: state is HomePageReadyState
              ? state.isAddButtonPressed
                  ? Brightness.dark
                  : Brightness.light
              : Brightness.dark,
          systemNavigationBarColor: state is HomePageReadyState
              ? state.isAddButtonPressed
                  ? Colors.white
                  : Colors.grey
              : Colors.white,
        ));
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 14.0),
            SvgPicture.asset(
              asset,
              color: Colors.black,
              width: 26,
              height: 26,
            ),
            SizedBox(width: 16.0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
      ),
    );
  }
}
