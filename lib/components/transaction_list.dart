import 'package:app02expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nanhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: Text('R\$${tr.value}')),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat('d MM y').format(tr.date)),
                    trailing: MediaQuery.of(context).size.width > 480
                        ? TextButton.icon(
                            onPressed: () => onRemove(tr.id),
                            icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                            label: Text('Excluir', style: TextStyle(color: Theme.of(context).errorColor)),
                          )
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => onRemove(tr.id),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
