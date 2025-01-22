
enum EnumTypePage {
  normal,
  selection,
}

extension TypePage on EnumTypePage{
  bool isNormal() => this == EnumTypePage.normal;
  bool isSelection() => this == EnumTypePage.selection;
}