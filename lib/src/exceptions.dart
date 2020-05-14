class NoAPIKeyException implements Exception {
  final String cause = "NO_API_KEY";
}

class ServerErrorException implements Exception {
  final String cause = "SERVER_ERROR";
}

class ExpiredKeyException implements Exception {
  final String cause = "ExpiredKey";
}

class DailyLimitReachedException implements Exception {
  final String cause = "DAILY_LIMIT_REACHED";
}

class MonthlyLimitReachedException implements Exception {
  final String cause = "MONTHLY_LIMIT_REACHED";
}

class MaxLimitReachedException implements Exception {
  final String cause = "MAX_LIMIT_REACHED";
}

class NoIpProvidedException implements Exception {
  final String cause = "NO_IP_PROVIDED";
}

class InvalidIpException implements Exception {
  final String cause = "INVALID_IP";
}

class InvalidKeyException implements Exception {
  final String cause = "INVALID_KEY";
}

class InactiveKeyException implements Exception {
  final String cause = "DEACTIVATED_KEY";
}

class UnknownErrorException implements Exception {
  final String cause = "UNKNOWN_ERROR";
}

class TimeLimitReachedException implements Exception {
  final String cause = "TIME_LIMIT_REACHED";
}
