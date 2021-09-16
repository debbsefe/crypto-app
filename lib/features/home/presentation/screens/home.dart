import 'package:crypto_app/features/home/presentation/blocs/coin_list/coin_list_bloc.dart';
import 'package:crypto_app/features/home/presentation/screens/convert_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _callBloc();
  }

  Future<void> _callBloc() async {
    final bloc = BlocProvider.of<CoinListBloc>(context, listen: false);
    bloc.add(const Started(
        ids:
            'bitcoin,binancecoin,ethereum,cardano,ripple,solana,tether,chainlink,litecoin,matic-network',
        currency: 'usd'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: RichText(
              text: TextSpan(
                  text: 'Crypto ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                        text: 'App',
                        style: TextStyle(
                          color: Colors.orange[500],
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),
                  ]),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return _callBloc();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Coin List',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text('All'),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text('Price (USD)'),
                      )
                    ]),
                    const SizedBox(
                      height: 35,
                    ),
                    BlocBuilder<CoinListBloc, CoinListState>(
                      builder: (context, state) {
                        return state.when(
                            initial: () => Container(),
                            error: (e) => Text(e),
                            loading: () => CircularProgressIndicator(),
                            loaded: (load) {
                              return Column(
                                  children: load.map((e) {
                                return DashboardTile(
                                  currentPrice: e.usd.toString(),
                                  image: e.coin,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConvertCoinScreen(
                                                    title: e.coin,
                                                    coin: e.usd)));
                                  },
                                  title: e.coin,
                                );
                              }).toList());
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

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
  //  ids: ',,ethereum,cardano,,solana',

  switch (name) {
    case 'bitcoin':
      return 'assets/images/btc.png';
    case 'litecoin':
      return 'assets/images/ltc.png';
    case 'ripple':
      return 'assets/images/xrp.png';
    case 'binancecoin':
      return 'assets/images/bnb.png';
    default:
      return 'assets/images/btc.png';
  }
}
