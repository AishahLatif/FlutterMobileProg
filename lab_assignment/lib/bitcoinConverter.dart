import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BITconvert extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const BitcoinConverter(),
    );
  } 
}

class BitcoinConverter extends StatefulWidget {
  const BitcoinConverter({ Key? key }) : super(key: key);

  @override
  State<BitcoinConverter> createState() => _BitcoinConverterState();
}

class _BitcoinConverterState extends State<BitcoinConverter> {
  TextEditingController valueEditingController = TextEditingController();
  String currency  = "btc", description = "Choose currency", name = ""; 
  double value = 0.0, result = 0.0;
    List<String> currencyList = [
    "btc", "eth", "ltc", "bch", "bnb", "eos", "xrp", "xlm", "link", "dot", "yfi", "usd", "aed", "ars","aud", "bdt", "bhd", "bmd", 
    "brl", "cad", "chf", "clp", "cny", "czk", "dkk", "eur", "gbp", "hkd", "huf", "idr", "ils", "inr", "jpy", "krw", "kwd", "lkr", 
    "mmk", "mxn", "myr", "ngn", "nok", "nzd", "php", "pkr", "pln", "rub", "sar", "sek", "sgd", "thb", "try", "twd", "uah", "vef",
    "vnd", "zar", "xdr", "xag", "xau", "bits", "sats"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BitCoin cryptocurrency", style: TextStyle(fontStyle: FontStyle.italic))
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(       
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bitcoin convert to", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: valueEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Enter BitCoin value",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    )
                  ),
                ),
        
                DropdownButton(
                  itemHeight: 60,
                  value: currency,
                  onChanged: (newValue) {
                    setState(() {
                      currency = newValue.toString();
                    });
                  },
                  items: currencyList.map((currency) {
                    return DropdownMenuItem(
                      child: Text(
                      currency,
                      ),
                       value:currency,
                       );
                  }).toList(),
                ),
                ElevatedButton(onPressed: _loadcurrency, child: const Text("Convert")),
                const SizedBox(height: 10),
                Text(description, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<void> _loadcurrency() async {
    var url = Uri.parse(
      'https://api.coingecko.com/api/v3/exchange_rates');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = response.body;
        var parseData = json.decode(jsonData);
        value = parseData['rates'][currency]['value'];
        name = parseData['rates'][currency]['name'];
        result = double.parse(valueEditingController.text)*value;
        setState(() {
          description = "Bitcoin value entered convert to $name is $result";
        });
      }
  }
}