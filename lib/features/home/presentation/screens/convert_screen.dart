import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConvertCoinScreen extends StatefulWidget {
  const ConvertCoinScreen({Key? key, required this.title, required this.coin})
      : super(key: key);
  final String? title;
  final num? coin;

  @override
  State<ConvertCoinScreen> createState() => _ConvertCoinScreenState();
}

class _ConvertCoinScreenState extends State<ConvertCoinScreen> {
  @override
  void initState() {
    super.initState();
    _usdController = TextEditingController(text: widget.coin.toString());
    _coinController = TextEditingController(text: '1');
  }

  TextEditingController? _usdController;
  TextEditingController? _coinController;

  @override
  void dispose() {
    _usdController?.dispose();
    _coinController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Amount(USD)',
              style: TextStyle(color: Colors.black),
            ),
            TextFormField(
              controller: _usdController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
              ],
              onChanged: (String value) {
                num coinValue = widget.coin!;
                if (value.isEmpty) {
                  _coinController?.text = '';
                }
                if (value.isNotEmpty && num.tryParse(value) != null) {
                  _coinController?.text =
                      (double.parse(value) / coinValue).toString();
                }
              },
              decoration: kInputDecoration,
            ),
            SizedBox(height: 10),
            Text(
              'Amount(${widget.title})',
              style: TextStyle(color: Colors.black),
            ),
            TextFormField(
              controller: _coinController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
              ],
              onChanged: (String value) {
                num coinValue = widget.coin!;
                if (value.isEmpty) {
                  _usdController?.text = '';
                }
                if (value.isNotEmpty && num.tryParse(value) != null) {
                  _usdController?.text =
                      (coinValue * double.parse(value)).toString();
                }
              },
              decoration: kInputDecoration,
            ),
          ],
        ),
      ),
    );
  }
}

final kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.red)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.red)),
);
