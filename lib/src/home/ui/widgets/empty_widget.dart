import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {

  final String title;

  const EmptyWidget({
    super.key,
    this.title = 'No se encontró registros',
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title),
    );
  }
}