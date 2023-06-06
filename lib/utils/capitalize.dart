// ignore_for_file: unnecessary_null_comparison

extension StringExtension on String {
  String capitalizeByWord() {
    if (trim().isEmpty || trim() == null) {
      return '';
    }
    return split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}
