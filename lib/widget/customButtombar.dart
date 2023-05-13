import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final Function? onAddButtonPressed;
  final Function? onConfirmButtonPressed;

  const CustomBottomBar({
    Key? key,
    this.onAddButtonPressed,
    this.onConfirmButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Container(
        height: 78,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (onAddButtonPressed != null) {
                    onAddButtonPressed!();
                  }
                },
                child: Container(
                  width: 170,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'เพิ่ม',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onConfirmButtonPressed != null) {
                    onConfirmButtonPressed!();
                  }
                },
                child: Container(
                  width: 170,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(121, 0, 9, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'ยืนยัน',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
