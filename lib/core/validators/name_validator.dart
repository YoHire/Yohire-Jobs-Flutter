String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Text cannot be empty';
  }

  final regex = RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$');
  if (!regex.hasMatch(value)) {
    return 'Only alphabets and single spaces are allowed';
  }

  return null;
}
