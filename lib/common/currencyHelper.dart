

String currency_Symbol(String currencyCode) {
  String symbol = "";
  if (currencyCode == "USD") {
    symbol = "\u0024";
  } else if (currencyCode == "NGN") {
    //Naira
    symbol = "\u20A6";
  } else if (currencyCode == "EUR") {
    symbol = "\u20AC";
  } else if (currencyCode == "GBP") {
    symbol = "\u00A3";
  } else if (currencyCode == "GHS") {
    symbol = "\u20A6";
  } else if (currencyCode == "JPY") {
    //japanese yen
    symbol = "\u00A5";
  } else if (currencyCode == "AFN") {
    //Afghani
    symbol = "\u060B";
  } else if (currencyCode == "CNY") {
    //chinese yuan
    symbol = "\u00A5";
  } else if (currencyCode == "ILS") {
    //	Israeli New Shekel
    symbol = "\u20AA";
  } else if (currencyCode == "INR") {
    //Australian dollar
    symbol = "\u20B9";
  } else if (currencyCode == "ZAR") {
    //S/A rand
    symbol = "\u0052";
  } else if (currencyCode == "RUB") {
    //russian rouble
    symbol = "py" + "\u0431";
  } else if (currencyCode == "CZK") {
    //Czech Koruna
    symbol = "\u004B" + "\u010D";
  } else if (currencyCode == "KRW") {
    //South-Korean Won
    symbol = "\u20A9";
  } else if (currencyCode == "PHP") {
    //Philippine Peso
    symbol = "\u20B1";
  } else if (currencyCode == "PLN") {
    //Polish Zloty
    symbol = "\u007A" + "\u0142";
  } else if (currencyCode == "THB") {
    //Thai Baht
    symbol = "\u0E3F";
  } else if (currencyCode == "VND") {
    //Vietnamese Dong
    symbol = "\u20AB";
  } else if (currencyCode == "GHC") {
    //GHANA Cedi
    symbol = "\u20B5";
  } else if (currencyCode == "AFN") {
    //Afghnai
    symbol = "\u060B";
  } else if (currencyCode == "BTC") {
    //GHANA Cedi
    symbol = "\u20BF";
  } else if (currencyCode == "AMD") {
    //ARMENIAN DRAM SIGN
    symbol = "\u058F";
  }

  return symbol;
}
