import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CountePage extends StatefulWidget {
  const CountePage({super.key});

  @override
  State<CountePage> createState() => _CountePageState();
}

class _CountePageState extends State<CountePage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo Contador'),
      ),
      body: Column(
        children: [
          Text('${provider?.state.value}'),
          IconButton(
            onPressed: () {
              setState(
                () => provider?.state.inc(),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(
                () => provider?.state.dec(),
              );
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
