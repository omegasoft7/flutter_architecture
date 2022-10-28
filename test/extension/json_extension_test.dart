import 'package:architecture/extension/json_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'json extension when getListValueOr rceives an object list should convert as expected',
      (tester) async {
    Map<String, Object?>? json = {
      "destinationCountries": <Object>["1", "2", "3"],
    };
    final List<String> list = json.getListValueOr(
      name: 'destinationCountries',
      defaultValue: "",
      defaultListValue: [],
    );

    expect(list, <String>["1", "2", "3"]);
  });

  testWidgets(
      'json extension when getValueOr for big number should convert as expected',
      (tester) async {
    Map<String, Object> json = {
      "amount": 4511.45,
    };
    final double amount = json.getValueOr(
      name: 'amount',
      defaultValue: 0.0,
    );

    expect(amount, 4511.45);
  });
}
