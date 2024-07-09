

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

class OffLineFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InternetConnectionFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class EmptyCachedFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}