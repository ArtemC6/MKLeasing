import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:leasing_company/features/home/presentation/bottom_nav_bar_items.dart';
import 'package:leasing_company/features/home/services/reviews_count_service.dart';
import 'package:leasing_company/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int initialPageIndex;

  const BottomNavBarWidget({
    Key? key,
    required this.initialPageIndex,
  }) : super(key: key);

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late int selectedItemIndex = widget.initialPageIndex;
  final ReviewsCountService _reviewsCountService = getIt();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 65),
        child: BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          if (state is HomePageReadyState) {
            selectedItemIndex = state.actualPageIndex;
          }
          return Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _createBottomNavBarItem(
                    module: Modules.main,
                    context: context,
                    onTap: () {
                      context.read<HomePageBloc>().add(PageChangedEvent(Modules.main.index));
                    },
                  ),
                  _createBottomNavBarItem(
                    module: Modules.objects,
                    context: context,
                    onTap: () {
                      context.read<HomePageBloc>().add(PageChangedEvent(Modules.objects.index));
                    },
                  ),

                  /// place for add button
                  Expanded(child: SizedBox.shrink()),

                  _createBottomNavBarItem(
                    module: Modules.reviews,
                    context: context,
                    onTap: () {
                      context.read<HomePageBloc>().add(PageChangedEvent(Modules.reviews.index));
                    },
                  ),
                  _createBottomNavBarItem(
                    module: Modules.tasks,
                    context: context,
                    onTap: () {
                      context.read<HomePageBloc>().add(PageChangedEvent(Modules.tasks.index));
                    },
                  ),
                ],
              ),
              state is HomePageReadyState
                  ? AnimatedOpacity(
                      opacity: state.isAddButtonPressed ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Visibility(
                        visible: state.isAddButtonPressed,
                        child: GestureDetector(
                          onTap: () {
                            onButtonPressed(state, context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            // color: Colors.black38,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onButtonPressed(state, context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF246BFD)),
                        child: AnimatedRotation(
                          turns: state is HomePageReadyState && state.isAddButtonPressed ? 1 / 8 : 0,
                          duration: Duration(milliseconds: 300),
                          child: Icon(Icons.add, color: Colors.white, size: 32),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'v: ' + getIt<PackageInfo>().version.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void onButtonPressed(state, BuildContext context) {
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
    context.read<HomePageBloc>().add(AddButtonPressedEvent());
  }

  Widget _createBottomNavBarItem({
    required Modules module,
    required Function() onTap,
    required BuildContext context,
  }) {
    final iconSize = selectedItemIndex == module.index ? 26.0 : 24.0;
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Ink(
          height: double.infinity,
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 6, 7, 2),
                  child: SvgPicture.asset(
                    module.iconAsset(),
                    width: iconSize,
                    height: iconSize,
                    color: selectedItemIndex == module.index ? Color(0xFF5D92FF) : Color(0xFF9E9E9E),
                  ),
                ),
                if (module == Modules.reviews)
                  StreamBuilder<int>(
                      stream: _reviewsCountService.reviewsCountStream,
                      builder: (context, snapshot) {
                        final reviewsCount = snapshot.data ?? 0;
                        return reviewsCount > 0
                            ? Positioned(
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
                            : SizedBox.shrink();
                      }),
              ],
            ),
            SizedBox(height: 2),
            Text(
              module.title(context),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: selectedItemIndex == module.index ? 12 : 11,
                fontWeight: selectedItemIndex == module.index ? FontWeight.w700 : FontWeight.w500,
                color: selectedItemIndex == module.index ? Color(0xFF5D92FF) : Color(0xFF9E9E9E),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
