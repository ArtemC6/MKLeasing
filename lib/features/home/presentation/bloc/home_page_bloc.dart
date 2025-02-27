import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final CompanyRepository _companyRepository = getIt();
  late final StreamSubscription<CompanyEntity> _companySubscription;
  final int _initialPageIndex;

  HomePageBloc(this._initialPageIndex) : super(HomePageInProgressState()) {
    on<LoadEvent>(_onLoadEvent);
    on<PageChangedEvent>(_onPageChangedEvent);
    on<AddButtonPressedEvent>(_onAddButtonPressedEvent);
    on<CompanyChangedEvent>(_onCompanyChangedEvent);

    _companySubscription = _companyRepository.controller.stream.listen((company) => add(CompanyChangedEvent(company)));

    add(LoadEvent());
  }

  Future<void> _onLoadEvent(LoadEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageInProgressState());

    var company = await _companyRepository.getCurrent();
    if (company == null) {
      await getIt<DataService>().syncAllData();
      company = await _companyRepository.getCurrent();
      if (company == null) {
        emit(HomePageChooseCompanyState());
      }
    }

    if (company != null) {
      emit(HomePageReadyState(
        actualPageIndex: _initialPageIndex,
        company: company,
      ));
    }
  }

  void _onAddButtonPressedEvent(_, Emitter<HomePageState> emit) {
    emit((state as HomePageReadyState).copyWith(isAddButtonPressed: !(state as HomePageReadyState).isAddButtonPressed));
  }

  void _onPageChangedEvent(
    PageChangedEvent event,
    Emitter<HomePageState> emit,
  ) {
    emit((state as HomePageReadyState).copyWith(actualPageIndex: event.newPageIndex));
  }

  void _onCompanyChangedEvent(CompanyChangedEvent event, Emitter emit) {
    if (state is HomePageReadyState) {
      emit(
        HomePageReadyState(
          actualPageIndex: (state as HomePageReadyState).actualPageIndex,
          company: event.newCompany,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _companySubscription.cancel();
    super.close();
  }
}
