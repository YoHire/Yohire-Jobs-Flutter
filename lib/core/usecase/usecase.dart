import 'package:fpdart/fpdart.dart';
import 'package:openbn/core/error/faliure.dart';

abstract interface class Usecase<SuccessType,Params> {
  Future<Either<Failure,SuccessType>>call(Params params);
}