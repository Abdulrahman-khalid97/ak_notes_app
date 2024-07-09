import 'package:ak_notes_app/app_local.dart';

import 'exception..dart';
import 'failure.dart';

mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      throw ServerException();
    case EmptyCachedFailure:
      throw EmptyCacheException();
    case OffLineFailure:
      throw OffLineException();
    default:
      throw Exception();
  }
}


 String errorMessage(Exception exp) {
  print(exp.runtimeType);
    switch (exp.runtimeType) {
      case ServerException:
        return AppLocal.loc.serverError;
      case EmptyCacheException:
        return AppLocal.loc.emptyCached;
      case OffLineException:
        return AppLocal.loc.offLineError;
      case InternetConnectionException:
        return AppLocal.loc.offLineError;
      default:
        return AppLocal.loc.unExpectedError;
    }
  }