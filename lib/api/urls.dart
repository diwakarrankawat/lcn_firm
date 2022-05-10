class Urls {
  static const String base = 'https://anaajapp.com/api';

  static get categories {
    return Uri.parse("$base/categories");
  }

  static get submit {
    return Uri.parse("$base/user/submit_details");
  }
}
