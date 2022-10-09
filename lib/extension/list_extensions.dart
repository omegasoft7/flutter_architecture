import 'package:flutter/material.dart';

extension ListExtensions<M> on List<M> {
  Widget toListView<V extends Widget>(
    V Function(BuildContext context, M model) builder,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) => builder(context, this[index]),
    );
  }

  Widget toColumn<V extends Widget>(
    V Function(M model) builder,
  ) {
    return Column(
      children: map((value) => builder(value)).toList(),
    );
  }
}
