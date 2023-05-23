import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  final bool isToggle;
  final String cardName;
  final String cardDetails;
  final VoidCallback? onTap;

  const CreditCard({
    Key? key,
    this.isToggle = false,
    required this.cardName,
    required this.cardDetails,
    this.onTap,
  }) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Container(
        width: 352,
        height: 64.38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE5E5E5),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(width: 10), // adjust as needed
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
            const Spacer(), // pushes the next child to the end
            widget.isToggle
                ? CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (bool value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                    activeColor: Colors.green,
                  )
                : Icon(
                    Icons.more_vert, // replace with actual icon
                    color: Colors.grey[300],
                    size: 20,
                  ),
            SizedBox(
              width: 10,
            ),
            widget.isToggle
                ? GestureDetector(
                    onTap: widget.onTap,
                    child: const Icon(
                      Icons.more_vert, // replace with actual icon
                      color: Color(0xFFD9D9D9),
                      size: 20,
                    ))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
