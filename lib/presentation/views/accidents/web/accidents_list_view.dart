import 'package:e_rose/assets/colors.dart';
import 'package:flutter/material.dart';

class AccidentsListViewWeb extends StatelessWidget {
  const AccidentsListViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 9,
          horizontal: MediaQuery.of(context).size.width / 7,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50),
            color: darkerNightBlue,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Toto",
                    ),
                    Text(
                      "Toto",
                    ),
                  ],
                ),
              ),
              const Flexible(
                flex: 4,
                child: Center(
                  child: Text(
                    "Toto",
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
