mixin AppValidator{
  bool isValidLength(String value, int minLength, int maxLength)
  {
    return value.trim().length >= minLength && value.length <= maxLength;
  }
}