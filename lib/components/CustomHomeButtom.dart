import 'package:flutter/material.dart';

class CustomHomeButtom extends StatelessWidget {
  final String label;
  final String image;
  final dynamic route;
  const CustomHomeButtom(
      {super.key,
      required this.label,
      required this.image,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        child: Ink(
          height: 170,
          width: 170,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(94, 11, 69, 78),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.white,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                width: 80,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
