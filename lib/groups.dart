class GroupNames {
  const GroupNames._();

  static const localPart = 'LocalPart';
  static const dotString = 'DotString';
  static const quotedString = 'QuotedString';
  static const domainOrAddressLiteral = 'DomainOrAddressLiteral';
  static const addressLiteral = 'AddressLiteral';
  static const ipv4 = 'IPv4';
  static const ipv6Full = 'IPv6Full';
  static const ipv6Comp = 'IPv6Comp';
  static const ipv6v4Full = 'IPv6v4Full';
  static const ipv6v4Comp = 'IPv6v4Comp';
  static const generalAddressLiteral = 'GeneralAddressLiteral';
  static const domain = 'Domain';
}

class Groups {
  const Groups._();

  static const localPart = //
      '(?<LocalPart>$dotString|$quotedString)';

  static const dotString = //
      r'''(?<DotString>[0-9a-z!#$%&'*+\-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+(\.[0-9a-z!#$%&'*+\-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+)*)''';

  static const quotedString = //
      r'''(?<QuotedString>"([\x20-\x21\x23-\x5B\x5D-\x7E\u{80}-\u{10FFFF}]|\\[\x20-\x7E])*")''';

  static const domainOrAddressLiteral = //
      '(?<DomainOrAddressLiteral>$addressLiteral|$domain)';

  static const addressLiteral = //
      '(?<AddressLiteral>\\[($ipv4|$ipv6Full|$ipv6Comp|$ipv6v4Full|$ipv6v4Comp|$generalAddressLiteral)\\])';

  static const ipv4 = //
      r'''(?<IPv4>\d{1,3}(\.\d{1,3}){3})''';

  static const ipv6Full = //
      r'''(?<IPv6Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){7})''';

  static const ipv6Comp = //
      r'''(?<IPv6Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?)''';

  static const ipv6v4Full = //
      r'''(?<IPv6v4Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){5}:\d{1,3}(\.\d{1,3}){3})''';

  static const ipv6v4Comp = //
      r'''(?<IPv6v4Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3}:)?\d{1,3}(\.\d{1,3}){3})''';

  static const generalAddressLiteral = //
      r'''(?<GeneralAddressLiteral>[a-z0-9\-]*[[a-z0-9]:[\x21-\x5A\x5E-\x7E]+)''';

  static const domain = //
      r'''(?<Domain>(?!.{256,})(([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z\-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))(\.([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z\-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))*)''';
}
