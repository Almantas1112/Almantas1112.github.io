import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class FirebaseAuthErrorMessageHandler {
  final String errorCode;
  const FirebaseAuthErrorMessageHandler(this.errorCode);
  String get errorMessage {
    switch (errorCode) {
      case 'account-exists-with-different-credential':
        return LocaleKeys.account_exists.tr();
      case 'invalid-credential':
        return LocaleKeys.invalid_credentials.tr();
      case 'operation-not-allowed':
        return LocaleKeys.operation_not_allowed.tr();
      case 'user-disabled':
        return LocaleKeys.user_disabled.tr();
      case 'user-not-found':
        return LocaleKeys.user_not_found.tr();
      case 'wrong-password':
        return LocaleKeys.wrong_password.tr();
      case 'invalid-verification-code':
        return LocaleKeys.invalid_verification_code.tr();
      case 'invalid-verification-id':
        return LocaleKeys.invalid_verification_id.tr();
      case 'too-many-requests':
        return LocaleKeys.too_many_requests.tr();
      case 'session-expired':
        return LocaleKeys.session_expired.tr();
      case 'invalid-email':
        return LocaleKeys.invalid_email.tr();
      case 'network-request-failed':
        return LocaleKeys.network_request_failure.tr();
      case 'email-already-in-use':
        return LocaleKeys.email_already_in_use.tr();
      case 'requires-recent-login':
        return LocaleKeys.required_recent_login.tr();
      default:
      // log(errorCode);
        return LocaleKeys.unknown_error.tr();
    }
  }
}
