import 'package:rfc_6531/rfc_6531.dart' as rfc_6531;

void main() {
  print(rfc_6531.regExp.hasMatch('user@example.com'));
  print(rfc_6531.regExp.hasMatch('not-an-email'));

  final match = rfc_6531.regExp.allMatches('user@example.com').first;
  print(match.namedGroup(rfc_6531.GroupNames.localPart));
  print(match.namedGroup(rfc_6531.GroupNames.domain));
}
