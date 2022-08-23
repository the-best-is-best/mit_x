import '../get_utils/get_utils.dart';

extension MitXDynamicUtils on dynamic {
  @Deprecated('isNull is deprecated and cannot be used, use "==" operator')
  bool get isNull => MitXUtils.isNull(this);

  bool? get isBlank => MitXUtils.isBlank(this);

  @Deprecated(
      'isNullOrBlank is deprecated and cannot be used, use "isBlank" instead')
  bool? get isNullOrBlank => MitXUtils.isNullOrBlank(this);

  void printError(
          {String info = '', Function logFunction = MitXUtils.printFunction}) =>
      // ignore: unnecessary_this
      logFunction('Error: ${this.runtimeType}', this, info, isError: true);

  void printInfo(
          {String info = '',
          Function printFunction = MitXUtils.printFunction}) =>
      // ignore: unnecessary_this
      printFunction('Info: ${this.runtimeType}', this, info);
}
