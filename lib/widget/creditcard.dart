import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/addNewCardController.dart';

class CreditCard extends StatefulWidget {
  final String cardName;
  final String cardDetails;
  final List<Map<String, dynamic>> toggles;
  final String productId;
  final String cardImage;

  const CreditCard({
    Key? key,
    required this.cardName,
    required this.cardDetails,
    required this.toggles,
    required this.productId,
    required this.cardImage,
  }) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final AddNewCardController _controller = Get.find();
  bool _isExpanded = false;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
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
              padding:
                  const EdgeInsets.symmetric(vertical: 23.0, horizontal: 20.7),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.141,
                    height: screenHeight * 0.090,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.cardImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11.5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 2.38,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.cardDetails,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 2.38,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "บัตรหลัก",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9.2,
                          height: 2.38,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 11.5,
                  ),
                ],
              ),
            );
          },
          body: _isExpanded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.toggles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final toggle = widget.toggles[index];
                    return ListTile(
                      title: Text(toggle['name'],
                          style: const TextStyle(
                              fontSize:
                                  13.8)), // assuming the default fontSize for ListTile title is 12
                      trailing: CupertinoSwitch(
                        value: toggle['value'],
                        onChanged: (bool value) async {
                          toggle['value'] = value;

                          await _controller.updateToggle(
                            widget.productId,
                            toggle['name'],
                            value,
                          );

                          setState(() {
                            // Update the widget state
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
