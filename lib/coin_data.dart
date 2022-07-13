import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = '5A186F98-4601-473C-9620-FD9DFE4F055D';

class CoinData {
  //String coin = 'USD';

  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    //String url = 'https://rest.coinapi.io/v1/exchangerate/$coin?apikey=$apiKey';
    for (String crypto in cryptoList) {
      String requestURL = '$coinApiURL$crypto?apikey=$apiKey';
      print(requestURL);
      Response response = await get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        //print(response.body);
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rates'][0]['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        print(cryptoPrices);
      } else {
        print('Response code: ${response.statusCode}');
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
