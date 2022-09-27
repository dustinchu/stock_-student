class Logger {
  const Logger();
  void log(String label, DateTime dateTime) {
    print('PRESSED: $label at ${dateTime.hour}:${dateTime.minute}');
    // TODO: complete the logger
  }
}

mixin LoggerMixin {
  static const _logger = Logger();
  void log(String label) => _logger.log(
      runtimeType.toString() + "------$label--------", DateTime.now());
}
