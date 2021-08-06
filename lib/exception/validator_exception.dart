import 'application_exception.dart';

/// 検査例外
class ValidatorException extends ApplicationException {
  ValidatorException({
    String code = '0',
    String message = 'validator exception',
    List<String> errorMessages = const [],
  }) : super(
          code: code,
          message: message,
          errorMessages: errorMessages,
        );
}
