import 'package:utils/utils.dart';

ValidateResult validateRequired({
  required String label,
  required dynamic value,
}) =>
    validateText(text: value, label: label, rules: {
      RuleValidator.isRequired: true,
    });

ValidateResult validatePhone({
  required String label,
  required dynamic value,
}) =>
    validateText(text: value, label: label, rules: {
      RuleValidator.isRequired: true,
      RuleValidator.minLength: 9,
      RuleValidator.maxLength: 9,
    });
