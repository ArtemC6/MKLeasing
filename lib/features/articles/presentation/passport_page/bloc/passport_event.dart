part of 'passport_bloc.dart';

abstract class PassportEvent extends Equatable {
  const PassportEvent();

  @override
  List<Object> get props => [];
}

class GetPassportProperties extends PassportEvent {
  final Article article;
  final String companyUuid;

  GetPassportProperties({
    required this.article,
    required this.companyUuid,
  });
}
