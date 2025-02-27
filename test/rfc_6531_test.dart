import 'package:rfc_6531/rfc_6531.dart' as rfc_6531;
import 'package:test/test.dart';

void main() {
  const originalRegExp =
      r'''^(?<LocalPart>(?<DotString>[0-9a-z!#$%&'*+\-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+(\.[0-9a-z!#$%&'*+\-\/=?^_`\{|\}~\u{80}-\u{10FFFF}]+)*)|(?<QuotedString>"([\x20-\x21\x23-\x5B\x5D-\x7E\u{80}-\u{10FFFF}]|\\[\x20-\x7E])*"))(?<!.{64,})@(?<DomainOrAddressLiteral>(?<AddressLiteral>\[((?<IPv4>\d{1,3}(\.\d{1,3}){3})|(?<IPv6Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){7})|(?<IPv6Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,5})?)|(?<IPv6v4Full>IPv6:[0-9a-f]{1,4}(:[0-9a-f]{1,4}){5}:\d{1,3}(\.\d{1,3}){3})|(?<IPv6v4Comp>IPv6:([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3})?::([0-9a-f]{1,4}(:[0-9a-f]{1,4}){0,3}:)?\d{1,3}(\.\d{1,3}){3})|(?<GeneralAddressLiteral>[a-z0-9\-]*[[a-z0-9]:[\x21-\x5A\x5E-\x7E]+))\])|(?<Domain>(?!.{256,})(([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z\-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))(\.([0-9a-z\u{80}-\u{10FFFF}]([0-9a-z\-\u{80}-\u{10FFFF}]*[0-9a-z\u{80}-\u{10FFFF}])?))*))$''';

  test('matches original RegExp', () {
    expect(rfc_6531.pattern, equals(originalRegExp));
  });

  test('validates list of valid emails', () {
    const validEmails = [
      // https://en.wikipedia.org/wiki/Email_address: Valid email addresses
      r'''simple@example.com''',
      r'''very.common@example.com''',
      r'''FirstName.LastName@EasierReading.org''',
      r'''x@example.com''',
      r'''long.email-address-with-hyphens@and.subdomains.example.com''',
      r'''user.name+tag+sorting@example.com''',
      r'''name/surname@example.com''',
      r'''admin@example''',
      r'''example@s.example''',
      r'''" "@example.org''',
      r'''"john..doe"@example.org''',
      r'''mailhost!username@example.org''',
      r'''"very.(),:;<>[]\".VERY.\"very@\\ \"very\".unusual"@strange.example.com''',
      r'''user%example.com@example.or''',
      r'''user-@example.org''',
      r'''postmaster@[123.123.123.123]''',
      r'''postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]''',
      r'''_test@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]''',
      // https://en.wikipedia.org/wiki/Email_address: Valid email addresses with SMTPUTF8
      r'''I❤️CHOCOLATE@example.com''',
    ];

    for (final validEmail in validEmails) {
      expect(validEmail, matches(rfc_6531.regExp));
    }
  });
  test('validates list of invalid emails', () {
    const invalidEmails = [
      // https://en.wikipedia.org/wiki/Email_address: Invalid email addresses
      // (no @ character)
      r'''abc.example.com''',
      // (only one @ is allowed outside quotation marks)
      r'''a@b@c@example.com''',
      // (none of the special characters in this local-part are allowed outside quotation marks)
      r'''a"b(c)d,e:f;g<h>i[j\k]l@example.com''',
      // (quoted strings must be dot separated or be the only element making up the local-part)
      r'''just"not"right@example.com''',
      // (spaces, quotes, and backslashes may only exist when within quoted strings and preceded by a backslash)
      r'''this is"not\allowed@example.com''',
      // (even if escaped (preceded by a backslash), spaces, quotes, and backslashes must still be contained by quotes)
      r'''this\ still\"not\\allowed@example.com''',
      // (local-part is longer than 64 characters)
      r'''1234567890123456789012345678901234567890123456789012345678901234+x@example.com''',
      // (underscore is not allowed in domain part)
      r'''i.like.underscores@but_they_are_not_allowed_in_this_part''',
      // https://gist.github.com/baker-ling/3b4b014ee809aa9732f9873fe060c098?permalink_comment_id=5175427#gistcomment-5175427
      r'''a.@a.com''',
    ];

    for (final invalidEmail in invalidEmails) {
      expect(invalidEmail, isNot(matches(rfc_6531.regExp)));
    }
  });
}
