import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String hint;
  final VoidCallback? onTapSearch;
  const SearchBarWidget({super.key, this.hint = 'Buscar...', this.onTapSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: onTapSearch != null,
      onTap: onTapSearch,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
      ),
    );
  }
}
