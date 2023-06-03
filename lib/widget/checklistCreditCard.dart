import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckListCreditCard extends StatefulWidget {
  final bool isToggle;
  final bool isSelectable; // Added new field to control selectability
  final String cardImage;
  final String cardName; // New parameter for card name
  final String cardDetails; // New parameter for card details
  final VoidCallback? onTap;
  final bool isSelected; // New parameter for initial selection state
  final ValueChanged<bool>
      onSelected; // New named parameter for selection callback
  const CheckListCreditCard({
    Key? key,
    this.isToggle = false,
    this.isSelectable = true,
    required this.cardName,
    required this.cardDetails,
    required this.onSelected,
    required this.cardImage,
    this.onTap,
    required this.isSelected, // Added onSelected parameter
  }) : super(key: key);

  @override
  _CheckListCreditCardState createState() => _CheckListCreditCardState();
}

class _CheckListCreditCardState extends State<CheckListCreditCard> {
  bool _switchValue = false;
  // bool _selected = false; // to manage selected/unselected state
  late bool _selected;
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
  void initState() {
    super.initState();
    _selected = widget.isSelected; // Initialize _selected here
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.024,
        horizontal: screenWidth * 0.048,
      ),
      child: Container(
        width: screenWidth * 0.781,
        height: screenHeight * 0.100,
        decoration: BoxDecoration(
          color: _selected
              ? Color.fromARGB(255, 249, 213, 211)
              : Colors.white, // changing color when selected
          borderRadius: BorderRadius.circular(screenWidth * 0.032),
          border: Border.all(
            color: _selected
                ? Colors.red
                : const Color(
                    0xFFE5E5E5), // changing border color when selected
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.056),
        child: CheckboxListTile(
          value: _selected,
          onChanged: widget.isSelectable ? toggleSelection : null,
          controlAffinity:
              ListTileControlAffinity.leading, // puts the checkbox at the start
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.141,
                  height: screenHeight * 0.190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cardImage),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.022), // adjust as needed
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cardName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth *
                            0.021 *
                            1.15, // Increased font size by 15%
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2), // Add spacing between texts
                    Text(
                      widget.cardDetails,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth *
                            0.021 *
                            1.15, // Increased font size by 15%
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2), // Add spacing between texts
                    Text(
                      "บัตรหลัก",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth *
                            0.021 *
                            1.15, // Increased font size by 15%
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Spacer(), // pushes the next child to the end
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
                        size: screenWidth *
                            0.032 *
                            1.15, // Increased icon size by 15%
                      ),
                widget.isToggle
                    ? GestureDetector(
                        onTap: widget.onTap,
                        child: Icon(
                          Icons.more_vert, // replace with actual icon
                          color: const Color(0xFFD9D9D9),
                          size: screenWidth *
                              0.032 *
                              1.15, // Increased icon size by 15%
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
