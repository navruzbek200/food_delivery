enum CardType {
  visa,
  mastercard,
  amex,
  discover,
  jcb,
  other,
  unknown
}

class CreditCardInfo {
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cvv;
  CardType cardType;

  CreditCardInfo({
    this.cardNumber = '',
    this.cardHolderName = '',
    this.expiryDate = '',
    this.cvv = '',
    this.cardType = CardType.unknown,
  });

  static CardType detectCardType(String cardNumber) {
    String cleanCardNumber = cardNumber.replaceAll(' ', '');
    if (cleanCardNumber.isEmpty) return CardType.unknown;
    if (RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(cleanCardNumber)) return CardType.visa;
    if (RegExp(r'^5[1-5][0-9]{14}$').hasMatch(cleanCardNumber)) return CardType.mastercard;
    if (RegExp(r'^3[47][0-9]{13}$').hasMatch(cleanCardNumber)) return CardType.amex;
    if (RegExp(r'^6(?:011|5[0-9]{2})[0-9]{12}$').hasMatch(cleanCardNumber)) return CardType.discover;
    if (RegExp(r'^(?:2131|1800|35\d{3})\d{11}$').hasMatch(cleanCardNumber)) return CardType.jcb;
    return CardType.other;
  }
}