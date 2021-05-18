import 'package:flutter/material.dart';

class ExpandedDropDownWidget extends StatefulWidget {
  final List<String> lista;
  final String texto;
  const ExpandedDropDownWidget({
    Key? key,
    required this.lista,
    required this.texto,
  }) : super(key: key);
  @override
  _ExpandedDropDownWidgetState createState() => _ExpandedDropDownWidgetState();
}

class _ExpandedDropDownWidgetState extends State<ExpandedDropDownWidget> {
  late String _title;
  @override
  void initState() {
    super.initState();
    _title = widget.lista.first;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: GlobalKey(), //Gambiarra
      leading: Icon(Icons.arrow_drop_down),
      title: Text(widget.texto),
      trailing: Text(_title),
      children: List.generate(widget.lista.length, (index) {
        var title = widget.lista[index];
        return ListTile(
          title: Text(title),
          onTap: () {
            setState(() {
              _title = title;
            });
          },
        );
      }),
    );
  }
}
