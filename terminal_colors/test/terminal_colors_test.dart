import 'package:test/test.dart';
import 'package:terminal_colors/terminal_colors.dart';

void main() {
  test('TerminalColor has the correct ANSI code', () {
    expect(TerminalColor.reset.code, equals('\x1B[0m'));
    expect(TerminalColor.cyan.code, equals('\x1B[36m'));
  });

  test('String can use styleSuccess', () {
    final result = 'Success'.styleSuccess;

    expect(result, contains('Success'));
    expect(result, contains('\x1B[32m'));
  });

  test('String can use styleError', () {
    final result = 'Error'.styleError;

    expect(result, contains('Error'));
    expect(result, contains('\x1B[31m'));
  });
}
