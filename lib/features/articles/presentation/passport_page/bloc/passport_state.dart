part of 'passport_bloc.dart';

abstract class PassportState extends Equatable {
  const PassportState();

  @override
  List<Object> get props => [];
}

class PassportInitial extends PassportState {}

class PassportTypesLoaded extends PassportState {
  final List<ArticleType> types;

  PassportTypesLoaded(this.types);

  @override
  // TODO: implement props
  List<Object> get props => [
        types,
      ];
}
