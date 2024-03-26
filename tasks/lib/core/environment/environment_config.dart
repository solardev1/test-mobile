import 'package:flutter/foundation.dart';

enum Environment { dev, qa, prod, mock}

enum LetterCase { upperCase, lowerCase, capitalize }

extension EnvironmentLable on Environment {
  String get environmentString {
    switch (this) {
      case Environment.dev:
        return 'DEV';
      case Environment.qa:
        return 'QA';
      case Environment.prod:
        return 'PROD';
      case Environment.mock:
        return 'MOCK';
    }
  }
}

class EnvironmentConfig {
  static const _environment = String.fromEnvironment(
    'TASKS_ENVIRONMENT',
    defaultValue: 'dev',
  );

  static bool get useDevicePreview {
    return (environment == Environment.qa && kIsWeb) || kIsWeb;
  }

  static const useMocks = bool.fromEnvironment('TASKS_USE_MOCKS');

  static Environment get environment {
    switch (_environment.toLowerCase()) {
      case 'dev':
        return Environment.dev;
      case 'qa':
        return Environment.qa;
      case 'prod':
        return Environment.prod;
      case 'mock':
        return Environment.mock;
      default:
        return Environment.dev;
    }
  }

  static String environmentToString({
    LetterCase letterCase = LetterCase.upperCase,
  }) {
    switch (environment) {
      case Environment.dev:
        return _formatString('DEV', letterCase);
      case Environment.qa:
        return _formatString('QA', letterCase);
      case Environment.prod:
        return _formatString('PROD', letterCase);
      case Environment.mock:
        return _formatString('MOCK', letterCase);
    }
  }

  static String get apiUrl {
    switch (environment) {
      case Environment.dev:
        return 'http://';
      case Environment.qa:
        return 'http://';
      case Environment.prod:
        return 'https://';
      case Environment.mock:
        return '';
    }
  }

  static String _formatString(String s, LetterCase letterCase) {
    switch (letterCase) {
      case LetterCase.upperCase:
        return s.toUpperCase();
      case LetterCase.lowerCase:
        return s.toLowerCase();
      case LetterCase.capitalize:
        return s[0].toUpperCase() + s.substring(1).toLowerCase();
    }
  }

 

}
