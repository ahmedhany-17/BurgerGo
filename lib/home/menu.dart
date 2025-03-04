import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Color color;
  final String imageUrl;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.color,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 21,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: color,
                  offset: Offset(2, 2),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}