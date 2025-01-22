import 'package:flutter/material.dart';

enum OptionsMenuSelection {
  share(iconData: Icons.share_outlined, title: 'Compartir'),
  copy(iconData: Icons.copy_all_outlined, title: 'Copiar'),
  delete(iconData: Icons.delete_outline, title: 'Eliminar');

  const OptionsMenuSelection({
    required this.iconData,
    required this.title,
  });

  final IconData iconData;
  final String title;
}

enum OptionsMenuReport {
  all(iconData: Icons.share_outlined, label: 'Exportar todo'),
  summary(iconData: Icons.copy_all_outlined, label: 'Exportar resumen'),
  details(iconData: Icons.copy_all_outlined, label: 'Exportar detalles');

  const OptionsMenuReport({
    required this.iconData,
    required this.label,
  });

  final IconData iconData;
  final String label;

  Map<String, dynamic> toJson() => {
    'iconData': iconData,
    'label': label,
  };

}