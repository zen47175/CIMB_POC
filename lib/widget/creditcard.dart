import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/addNewCardController.dart';

class CreditCard extends StatefulWidget {
  final String cardName;
  final String cardDetails;
  final List<Map<String, dynamic>> toggles;
  final String productId; // Add this
  const CreditCard({
    Key? key,
    required this.cardName,
    required this.cardDetails,
    required this.toggles,
    required this.productId, // And this
  }) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final AddNewCardController _controller = Get.find(); // Add this
  bool _isExpanded = false;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Row(
                children: [
                  Container(
                    width: 57.11,
                    height: 35.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Creditcard.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          height: 2.07,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.cardDetails,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          height: 2.07,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "บัตรหลัก",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                          height: 2.07,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          },
          body: _isExpanded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.toggles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final toggle = widget.toggles[index];
                    return ListTile(
                      title: Text(toggle['name']),
                      trailing: CupertinoSwitch(
                        value: toggle['value'],
                        onChanged: (bool value) {
                          _controller.updateToggle(widget.productId,
                              toggle['name'], value); // Add this
                          setState(() {
                            toggle['value'] = value;
                          });
                        },
                      ),
                    );
                  },
                )
              : Container(),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
