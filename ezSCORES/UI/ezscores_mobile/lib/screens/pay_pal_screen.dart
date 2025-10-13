import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompetitionPaymentScreen extends StatefulWidget {
  final int applicationId;
  final String competitionName;
  final int competitionFee;
  String? secret;
  String? public;
  String? sandBoxMode;

  CompetitionPaymentScreen(
    {
    super.key,
    required this.applicationId,
    required this.competitionName,
    required this.competitionFee,
    })
    {
      secret = const String.fromEnvironment("_paypalSecret", defaultValue: "");
      public = const String.fromEnvironment("_paypalPublic", defaultValue: "");
      sandBoxMode = const String.fromEnvironment("_sandBoxMode", defaultValue: "true");
    }

  @override
  State<CompetitionPaymentScreen> createState() => _CompetitionPaymentScreenState();
}

class _CompetitionPaymentScreenState extends State<CompetitionPaymentScreen> {
  late ApplicationProvider applicationProvider;
  double competitionFeeDouble = 0;

  @override
  void initState() {
    super.initState();
    applicationProvider = context.read<ApplicationProvider>();
    competitionFeeDouble = widget.competitionFee.toDouble();
  }
  void _showPaymentStatusDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: TextStyle(color: color)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var secret = dotenv.env['_paypalSecret'];
    var public = dotenv.env['_paypalPublic'];

    var valueSecret =
        (widget.secret == "" || widget.secret == null) ? secret : widget.secret;
    var valuePublic =
        (widget.public == "" || widget.public == null) ? public : widget.public;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Uplata kotizacije",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.competitionName,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Kotizacija: ${competitionFeeDouble.toStringAsFixed(2)} BAM",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Molimo Vas da pregledate detalje prije plaćanja!",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Odustani",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaypalCheckoutView(
                            sandboxMode: widget.sandBoxMode == "true"
                            ? true
                            : widget.sandBoxMode == "false"
                                ? false
                                : true,
                            clientId: valuePublic,
                            secretKey: valueSecret,
                            transactions: [
                              {
                                "amount": {
                                  "total":
                                      competitionFeeDouble.toStringAsFixed(2),
                                  "currency": "USD",
                                  "details": {
                                    "subtotal":
                                        competitionFeeDouble.toStringAsFixed(2),
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "Competition Fee for ${widget.competitionName}",
                                "item_list": {
                                  "items": [
                                    {
                                      "name":
                                          "Entry - ${widget.competitionName}",
                                      "quantity": 1,
                                      "price":
                                          competitionFeeDouble.toStringAsFixed(2),
                                      "currency": "USD"
                                    }
                                  ],
                                }
                              }
                            ],
                            note: "Thanks for registering!",
                            onSuccess: (Map params) async{
                              //Navigator.pop(context);
                              try {
                                var request = {'paidAmount':competitionFeeDouble};
                                await applicationProvider.makePayment(widget.applicationId, request);
                                if(context.mounted)
                                {
                                  showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => const SuccessPopup(message: "Kotizacija uspješno plaćena!"),
                                      );
                                  Future.delayed(const Duration(seconds: 2), () {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(true);
                                    }
                                  });
                                }
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Greška"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Ok"),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            onError: (error) {
                              debugPrint("❌ Payment Error: $error");
                              Navigator.pop(context);
                              _showPaymentStatusDialog(
                                "Greška",
                                "Došlo je do greške prilikom uplate. Pokušajte ponovno.",
                                Colors.red,
                              );
                            },
                            onCancel: () {
                              debugPrint("⚠️ Payment Cancelled");
                              Navigator.pop(context);
                              _showPaymentStatusDialog(
                                "Otkazano",
                                "Uplata je otkazana.",
                                Colors.orange,
                              );
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Plati",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
