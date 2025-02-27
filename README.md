# [RFC 6531](https://datatracker.ietf.org/doc/html/rfc6531) Email address regular expression.

Email address regular expression as close as possible to the specification in RFC 6531.

For more information on current limitations and detailed overview of used Named Capture Groups refer to the [original GitHub Gist](https://gist.github.com/baker-ling/3b4b014ee809aa9732f9873fe060c098#background).

## ⚠️ Found a bug?

If you find a bug, please [submit a PR containing a fix](https://github.com/MichaelDark/rfc_6531/pulls) or [file an issue](https://github.com/MichaelDark/rfc_6531/issues) with the problematic email and justification for why it should be compliant or non-compliant.  


## Validating email

```dart
import 'package:rfc_6531/rfc_6531.dart' as rfc_6531;

void main() {
  print(rfc_6531.regExp.hasMatch('user@example.com'));
  print(rfc_6531.regExp.hasMatch('not-an-email'));
}
```

## Named Capture Groups

Used Named Capture Groups used are accessible via `Groups` class, with their names being accesing via `GroupNames`.  


```dart
import 'package:rfc_6531/rfc_6531.dart' as rfc_6531;

void main() {
  final match = rfc_6531.regExp.allMatches('user@example.com').first;
  print(match.namedGroup(rfc_6531.GroupNames.localPart));
  print(match.namedGroup(rfc_6531.GroupNames.domain));
}
```

## Support

<a href="https://www.buymeacoffee.com/michaeldark" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
