import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final String? title, image, currentPrice;

  final VoidCallback onTap;

  const DashboardTile({
    Key? key,
    required this.onTap,
    required this.currentPrice,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  handleImageAsset(image),
                  height: 30,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title!, style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$$currentPrice',
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String handleImageAsset(String? name) {
  switch (name) {
    case 'bitcoin':
      return 'assets/images/btc.png';
    case 'litecoin':
      return 'assets/images/ltc.png';
    case 'ripple':
      return 'assets/images/xrp.png';
    case 'binancecoin':
      return 'assets/images/bnb.png';
    case 'ethereum':
      return 'assets/images/ethereum.png';
    case 'cardano':
      return 'assets/images/cardano.png';
    case 'solana':
      return 'assets/images/solana.png';
    case 'tether':
      return 'assets/images/tether.png';
    case 'chainlink':
      return 'assets/images/chainlink.png';
    case 'matic-network':
      return 'assets/images/matic.png';
    default:
      return 'assets/images/btc.png';
  }
}
