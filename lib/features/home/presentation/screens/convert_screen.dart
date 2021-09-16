import 'package:crypto_app/features/home/presentation/screens/widgets/generic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/core/utils/extensions.dart';
import 'package:flutter/widgets.dart';

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
      appBar: AppBar(title: Text(widget.title?.capitalize ?? '')),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                '${widget.title?.capitalize} to USD',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              const Text(
                'Amount (USD)',
                style: TextStyle(color: Colors.black),
              ),
              GenericTextFormField(
                controller: _usdController,
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
              ),
              const SizedBox(height: 20),
              Text(
                'Amount (${widget.title?.capitalize})',
                style: const TextStyle(color: Colors.black),
              ),
              GenericTextFormField(
                controller: _coinController,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
