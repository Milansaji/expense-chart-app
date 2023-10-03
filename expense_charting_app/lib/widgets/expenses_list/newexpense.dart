import 'package:expense_charting_app/widgets/expenses_list/expense.dart';
import 'package:flutter/material.dart';

class newexpense extends StatefulWidget {
  const newexpense({super.key, required this.onaddexpense});
  final void Function(Expense expense) onaddexpense;

  @override
  State<newexpense> createState() => _newexpenseState();
}

class _newexpenseState extends State<newexpense> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selecteddate;
  Category? selectedcategory;

  @override
  void dispose() {
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  void datepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      selecteddate = pickeddate;
    });
  }

  void submitexpense() async {
    final enteredamount = double.tryParse(amountcontroller.text);
    final amountinvalid = enteredamount == null || enteredamount <= 0;

    if (titlecontroller.text.trim().isEmpty ||
        amountinvalid ||
        selecteddate == null ||
        selectedcategory == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Invalid input'),
              content: Text('please check your data'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('OK'))
              ],
            );
          });
      return;
    }
    widget.onaddexpense(Expense(
        amount: enteredamount,
        category: selectedcategory!,
        date: selecteddate!,
        title: titlecontroller.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            style: Theme.of(context).textTheme.titleLarge,
            controller: titlecontroller,
            maxLength: 50,
            decoration: InputDecoration(
                label: Text(
              'Title',
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLength: 50,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixText: '\RS',
                      label: Text(
                        'Amount',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selecteddate == null
                        ? 'no select date'
                        : formatter.format(selecteddate!)),
                    IconButton(
                        onPressed: datepicker, icon: Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                dropdownColor: isDarkMode
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                style: Theme.of(context).dropdownMenuTheme.textStyle,
                value: selectedcategory,
                items: Category.values
                    .map((Category) => DropdownMenuItem(
                        value: Category,
                        child: Text(Category.name.toUpperCase())))
                    .toList(),
                onChanged: (values) {
                  setState(() {
                    selectedcategory = values;
                  });
                },
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              ElevatedButton(onPressed: submitexpense, child: Text('save'))
            ],
          )
        ],
      ),
    );
  }
}
