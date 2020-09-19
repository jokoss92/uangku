import 'package:flutter/material.dart';
import 'package:uangku_/models/wallet.dart';
import 'package:uangku_/services/wallet.service.dart';
import 'package:uangku_/screens/input-wallet.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WalletService _walletService = WalletService();
  Future<List<Wallet>> walletLists;

  @override
  void initState() {
    super.initState();
    updateList();
  }

  void updateList() {
    setState(() {
      walletLists = _walletService.getLists();
    });
  }

  Future<Wallet> navigateToEntryForm(context, Wallet wallet) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => InputWallet(wallet)));
  }

  Card getCard(Wallet wallet) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.attach_money),
        ),
        title: Text(wallet.name),
        subtitle: Text(wallet.value.toString()),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            int result = await _walletService.delete(wallet.id);
            if (result > 0) {
              updateList();
            }
          },
        ),
        onTap: () async {
          Wallet walletUpdate = await navigateToEntryForm(context, wallet);

          if (walletUpdate != null) {
            int result = await _walletService.insert(walletUpdate);
            if (result > 0) {
              updateList();
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uangku Record'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: ListView(
            children: <Widget>[
              FutureBuilder<List<Wallet>>(
                  future: walletLists,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data
                              .map((wallet) => this.getCard(wallet))
                              .toList());
                    } else {
                      return SizedBox();
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          // TODO implement add
          Wallet wallet = await navigateToEntryForm(context, null);

          if (wallet != null) {
            int result = await _walletService.insert(wallet);
            if (result > 0) {
              updateList();
            }
          }
        },
      ),
    );
  }
}
