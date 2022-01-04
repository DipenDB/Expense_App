
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{

  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //Constraint has total max height = 1,
      return Column(
        children: [
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          // Text('45'),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(
            height: constraints.maxHeight *0.6,
            width: 10,
            // color: Colors.blue,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey,width: 1.4),
                  ),
                ),

                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,   //0=0% to 1=100%
                  // heightFactor: 0.8,   //0=0% to 1=100%
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )


              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text(label))
          ),
          // Text('S'),
        ],
      );
    },);
      
      
  }

}