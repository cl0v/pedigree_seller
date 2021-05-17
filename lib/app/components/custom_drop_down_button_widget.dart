
import 'package:flutter/material.dart';

class CustomDropDownButtonWidget extends StatefulWidget {
  final List<String> list;

  const CustomDropDownButtonWidget({Key? key, required this.list}) : super(key: key);
  @override
  _CustomDropDownButtonWidgetState createState() => _CustomDropDownButtonWidgetState();
}

class _CustomDropDownButtonWidgetState extends State<CustomDropDownButtonWidget> {
  String valor = 'Selecione a especie';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Container(),
              hint: Center(
                child: Text(valor),
              ),
              onChanged: (String? newValue) {
                if (newValue != null)
                  setState(() {
                    valor = newValue;
                  });
              },
              items: widget.list
                  .map((String value) => DropdownMenuItem(
                        value: value,
                        onTap: () {},
                        child: Text(value),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
