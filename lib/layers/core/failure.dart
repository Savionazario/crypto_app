abstract class Failure{
  final String failureMessage;

  Failure({required this.failureMessage});
}

class GenericFailure extends Failure{
  GenericFailure({required super.failureMessage});

}