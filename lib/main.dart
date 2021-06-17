import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pago_app/repository/api_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_pago_app/constants.dart' as Constants;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static const platform =
      const MethodChannel('com.ksandon.niubiz/flutterNiubizSdk');

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> pagos = [];
  Map<String, String> mdd = {
    'MDD4': 'integraciones.niubiz@necomplus.com',
    'MDD21': '1',
    'MDD32': 'KS6',
    'MDD75': 'Registrado',
    'MDD77': '20'
  };

  void _responseAPI(String token, String purchaseNumber) async {
    ApiRepository apiRepository = new ApiRepository();
    final response =
        await apiRepository.getPurchaseInformation(token, purchaseNumber);
    if (response != null) {
      setState(() {
        pagos.add({
          'card': response.dataMap.card,
          'brand': response.dataMap.brand,
          'description': response.dataMap.actionDescription
        });
      });
    }
  }

  Future _callNiubizSDK() async {
    ApiRepository apiRepository = new ApiRepository();
    final token = await apiRepository.getToken();
    final pin = 'w+9oxEkAQVM2aZGzmUYiTP2L2VA0JnxqIvH2e/HPhV0='; // Get from Niubiz API

    Map<String, String> config = {
      'token': token,
      'amount': '150',
      'purchase': '202106090005',
      'merchantID': Constants.NIUBIZ_MERCHANT_ID,
      'name': 'Kevin',
      'lastname': 'Sandon',
      'email': 'sandon13496@gmail.com',
      'endpoint': Constants.NIUBIZ_ENDPOINT_BASE,
      'pin': pin
    };

    try {
      await MyApp.platform.invokeMethod('niubizBridgeSDK', <String, dynamic>{
        'config': config,
        'mdd': mdd,
      }).then((result) {
        print('Response: $result');
        _responseAPI(token, config['purchase']);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Icon getIcon(String marca) {
    switch (marca) {
      case 'visa':
        return Icon(FontAwesomeIcons.ccVisa);
      case 'mastercard':
        return Icon(FontAwesomeIcons.ccMastercard);
      case 'amex':
        return Icon(FontAwesomeIcons.ccAmex);
      case 'dinersclub':
        return Icon(FontAwesomeIcons.ccDinersClub);
      default:
        return Icon(FontAwesomeIcons.creditCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Niubiz Pago App with Flutter',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Niubiz Pago App with Flutter'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.payment), onPressed: () => _callNiubizSDK()),
            body: ListView.builder(
                itemCount: pagos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: getIcon(pagos[index]['brand']),
                        title: Text(pagos[index]['card']),
                        subtitle: Text(pagos[index]['description']),
                      ),
                      Divider()
                    ],
                  );
                })));
  }
}
