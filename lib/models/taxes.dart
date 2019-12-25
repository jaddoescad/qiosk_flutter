class Taxes {
  double taxRate;

  Taxes({this.taxRate = 0.13});

  double applyTax(subtotal) {
    subtotal = subtotal*taxRate;
    return subtotal;
  }

  double getTotal(subtotal) {
    subtotal = subtotal + subtotal*taxRate;
    return subtotal;
  }
}