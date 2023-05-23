import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_cimb/widget/settingItem.dart';

class SettingListItem extends StatelessWidget {
  final SettingItem setting;
  final ValueChanged<bool> onChanged;

  const SettingListItem({
    Key? key,
    required this.setting,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(setting.label),
      trailing: CupertinoSwitch(
        value: setting.value,
        onChanged: onChanged,
      ),
    );
  }
}
