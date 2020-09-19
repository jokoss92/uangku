import 'package:flutter/material.dart';
import 'package:uangku_/services/wallet.service.dart';
import 'package:uangku_/models/wallet.dart';

class InputWallet extends StatefulWidget {
  Wallet _wallet;
  InputWallet(this._wallet);

  @override
  _InputWalletState createState() => _InputWalletState(this._wallet);
}

class _InputWalletState extends State<InputWallet> {
  Wallet _wallet;

  _InputWalletState(this._wallet);

  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (_wallet != null) {
      nameController.text = _wallet.name;
      valueController.text = _wallet.value.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_wallet == null ? 'Input Wallet' : 'Update Wallet'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Wallet',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: TextField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Value Wallet',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text('Save'),
                        onPressed: () {
                          if (_wallet == null) {
                            _wallet = Wallet(
                              name: nameController.text,
                              value: int.parse(valueController.text)
                            );
                          } else {
                            _wallet.name = nameController.text;
                            _wallet.value = int.parse(valueController.text);
                          }

                          Navigator.pop(context, _wallet);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
