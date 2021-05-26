// import 'package:flutter/material.dart';

//TODO: Remover

// class StreamButtonWidget extends StatefulWidget {
//   final List<StateButtonOptions> states;
//   final VoidCallback onPressed;
//   final Stream stream;
//   final dynamic initialState;

//   const StreamButtonWidget({
//     Key? key,
//     required this.states,
//     required this.onPressed,
//     required this.stream,
//     required this.initialState,
//   }) : super(key: key);

//   @override
//   _StreamButtonWidgetState createState() => _StreamButtonWidgetState();
// }

// class _StreamButtonWidgetState extends State<StreamButtonWidget> {
//   late StateButtonOptions _state = widget.states.first;

//   @override
//   void initState() {
//     super.initState();
//     _state = widget.states.firstWhere((s) => s.state == widget.initialState);
//     widget.stream.listen((events) {
//       setState(() {
//         _state = widget.states.firstWhere((s) => s.state == events);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.08,
//       width: size.width * 0.8,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: _state.buttonColor,
//       ),
//       child: TextButton(
//         onPressed: widget.onPressed,
//         child: _state.child,
//       ),
//     );
//   }
// }

// class StateButtonOptions {
//   Widget child;
//   dynamic state;
//   Color buttonColor;
//   StateButtonOptions({
//     required this.child,
//     required this.state,
//     this.buttonColor = Colors.blue,
//   });
//   // Widget title;
// }
