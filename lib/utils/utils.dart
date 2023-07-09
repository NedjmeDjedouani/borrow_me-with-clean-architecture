

class Utils{

static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  static String? namevalidator(String? name) {
    if (name == null) return "name is not valid";
    if (name.isNotEmpty) {
      return name.length > 40 ? 'more than 40 characters' : null;
    } else {
      return "this field is empty";
    }
  }

  static String? balancevalidator(String? name) {
    if (name == null) return "number is not valid";
    if (!Utils.isNumeric(name)) {
      return 'this field should be a number';
    } else if (name.length > 15) {
      return 'this number should not exceed 15 digits';
    } else {
      return null;
    }
  }

  static String? phonevalidator(String? phonenumber) {
    const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    if (phonenumber == null) return "phonenumber is not valid";
    if (phonenumber.isEmpty) {
      return null;
    } else {
      return regExp.hasMatch(phonenumber) ? null : "phone number is not valid";
    }
  }
}