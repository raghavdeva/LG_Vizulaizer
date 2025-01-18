import 'package:flutter/material.dart';

class Connectionflag extends StatelessWidget {
  Connectionflag({required this.status});
  final bool status;

  @override
  Widget build(BuildContext context) {
    Color color = status ? Colors.green : Colors.red;
    String label = status ? 'CONNECTED' : 'DISCONNECTED';
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.circle,
            color: color,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 32),
          )
        ],
      ),
    );
  }
}
