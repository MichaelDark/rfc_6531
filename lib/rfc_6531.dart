import 'groups.dart';

export 'package:rfc_6531/groups.dart' show GroupNames, Groups;

RegExp regExp = RegExp(pattern, caseSensitive: false, unicode: true);

const pattern =
    '^${Groups.localPart}(?<!.{64,})@${Groups.domainOrAddressLiteral}\$';
