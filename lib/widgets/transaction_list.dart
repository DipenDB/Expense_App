import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight *0.8,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          },) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

            child: ListTile(
              leading: CircleAvatar(
                radius: 30,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                      child: Text('\$${transactions[index].amount}', style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                ),
              ),

              title: Text(transactions[index].title, style: Theme.of(context).textTheme.headline6,),

              subtitle: Text(DateFormat.yMMMEd().format(transactions[index].date)),

              trailing: MediaQuery.of(context).size.width >360 ? FlatButton.icon(onPressed: ()=>deleteTx(transactions[index].id), icon: Icon(Icons.delete, color: Theme.of(context).primaryColor,), label: Text('Delete',style: TextStyle(color: Theme.of(context).primaryColor),))
                  : Icon(Icons.delete,color: Theme.of(context).primaryColor,) ,onTap: ()=>deleteTx(transactions[index].id),
            ),
          );



        },
        itemCount: transactions.length,
      );

  }
}
