import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chartBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget{

  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);


  List< Map<String,Object> > get groupedTransactionValues{
    return List.generate(7, (index) {

      //Generate 7 days including today in recursion
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum=0.0;

      for(var i=0; i<recentTransaction.length;i++){
        if(recentTransaction[i].date.day == weekDay.day
           && recentTransaction[i].date.month==weekDay.month
           && recentTransaction[i].date.year==weekDay.year
        )
        {
          totalSum+=recentTransaction[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        //Generate Single character indicating day
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum,
      };
    }).reversed.toList();  //Generate list in reveresed manner today at last
  }


  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, element){
      return sum + element['amount'];
    }
    );
  }






  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: groupedTransactionValues.map((data){
            // return Text('${data['day']} : ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight,

              child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  //if totalspending is 0 then dividing by zero let to error so passing 0.0 as height factor
                  spendingPercentageOfTotal: totalSpending==0.0 ? 0.0: (data['amount'] as double)/totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }

}