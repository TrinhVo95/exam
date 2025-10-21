import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric( vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
           
              children: [
                Icon(icon, size: 20, color: Colors.orange),
                const SizedBox(width: 20),
                Expanded(child: Text(title, style: TextStyle(fontSize: 14,color: Colors.black))),
                const Icon(Icons.chevron_right, size: 30, color: Color(0xFF969696)),
              ],
            ),
          ),
        ),
       Divider(color: Colors.grey, height: 1),
      ],
    );
  }
}
