import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckListCreditCard extends StatefulWidget {
  final bool isToggle;
  final bool isSelectable; // Added new field to control selectability

  final String cardName; // New parameter for card name
  final String cardDetails; // New parameter for card details
  final VoidCallback? onTap;
  final ValueChanged<bool>
      onSelected; // New named parameter for selection callback
  const CheckListCreditCard({
    Key? key,
    this.isToggle = false,
    this.isSelectable = true,
    required this.cardName,
    required this.cardDetails,
    required this.onSelected,
    this.onTap, // Added onSelected parameter
  }) : super(key: key);

  @override
  _CheckListCreditCardState createState() => _CheckListCreditCardState();
}

class _CheckListCreditCardState extends State<CheckListCreditCard> {
  bool _switchValue = false;
  bool _selected = false; // to manage selected/unselected state

  void toggleSelection(bool? newValue) {
    if (widget.isSelectable) {
      setState(() {
        _selected = newValue!;
        widget.onSelected(
            _selected); // Call the onSelected callback with the selected state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Container(
        width: 352,
        height: 64.38,
        decoration: BoxDecoration(
          color: _selected
              ? Color.fromARGB(255, 249, 213, 211)
              : Colors.white, // changing color when selected
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selected
                ? Colors.red
                : const Color(
                    0xFFE5E5E5), // changing border color when selected
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CheckboxListTile(
          value: _selected,
          onChanged: widget.isSelectable ? toggleSelection : null,
          controlAffinity:
              ListTileControlAffinity.leading, // puts the checkbox at the start
          title: Row(
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      height: 2.07,
                    ),
                  ),
                  Text(
                    widget.cardDetails,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        height: 2.07,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
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
                      activeColor: Colors.black,
                    )
                  : Icon(
                      Icons.more_vert, // replace with actual icon
                      color: Colors.grey[300],
                      size: 20,
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
      ),
    );
  }
}
