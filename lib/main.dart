import 'package:expense_app/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

void main() {

  //Controlling App to landscape mode ehich might not work on some devices
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.blue,
          fontFamily: 'Ubuntu',

          textTheme: ThemeData.light().textTheme.copyWith(
            headline6 : TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),

            button:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

          ),

          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart=false;

  void _addNewTransaction(String txTitle, double txAmount, DateTime pickedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: pickedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }


  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();

  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => id==element.id);
    });
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);


    final _isLandscape =mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );



    final TList =Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
        child: TransactionList(_userTransactions,deleteTransaction)
        );


    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            if(_isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(value: _showChart,
                    onChanged: (val){
                      setState(() {
                        _showChart=val;
                      });
                    }),
              ],
            ),
            if(_isLandscape)_showChart ? Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
                    child: Chart(_recentTransaction)
                      ) : TList,

            if(!_isLandscape) Container(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3,
                  child: Chart(_recentTransaction)
                  ),

            if(!_isLandscape) TList,




          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
