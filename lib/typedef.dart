import 'package:fpdart/fpdart.dart';
import 'package:tiktok_clone/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
