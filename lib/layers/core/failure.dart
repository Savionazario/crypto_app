abstract class Failure{
  final String failureMessage;

  Failure({required this.failureMessage});
}

class ServerFailure extends Failure{
  ServerFailure({required super.failureMessage});
}

class GenericFailure extends Failure{
  GenericFailure({required super.failureMessage});
}

