import 'package:divyanga/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:scribble/scribble.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Paint_Screen extends StatefulWidget {
  const Paint_Screen({super.key});

  @override
  State<Paint_Screen> createState() => _Paint_ScreenState();
}

class _Paint_ScreenState extends State<Paint_Screen> {
  late ScribbleNotifier notifier;

  @override
  void initState() {
    notifier = ScribbleNotifier(
      widths: [7.5]
    );
    super.initState();

  }

  // void initTFLite() async{
  //   await Tflite.loadModel(
  //     model: "assets/model.tflite",
  //     labels: "assets/label.txt",
  //     numThreads: 1,
  //     isAsset: true,
  //     useGpuDelegate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Letter Tracing'),
      //   leading: IconButton(
      //     icon: const Icon(Icons.save),
      //     tooltip: "Save to Image",
      //     onPressed: () => _saveImage(context),
      //   ),
      // ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: Container(
                    decoration: curvedEdges,
                    child: Center(child: Text("e",style: letterTracingTextStyle))
                )
            ),
          ),
          Expanded(
            child: Container(
              decoration: curvedEdges,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Stack(
                  children: [
                    Scribble(
                      notifier: notifier,
                      drawPen: true,

                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Column(
                        children: [
                          _buildColorToolbar(context),
                          const Divider(
                            height: 32,
                          ),
                          //_buildStrokeToolbar(context),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
}

  Future<void> _saveImage(BuildContext context) async {
    final image = await notifier.renderImage();

    processImage();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Image"),
        content: Image.memory(image.buffer.asUint8List()),
      ),
    );


  }

  void processImage()async{
    final image = await notifier.renderImage();
    // image.buffer.
    // var recognitions = await Tflite.runModelOnFrame(bytesList: image.buffer.asUint8List(0));
    // Tflite.runModelOnImage(path: Image.memory(image.buffer.asUint8List()));

    print(image.buffer.asUint8List().toString());
    print(image.buffer.asByteData().toString());
    var response = await http.post(
      Uri.parse('http://192.168.182.162:8000/print'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'image': image.buffer.asByteData()
      }),
    );
    print(response.statusCode);


  }

  Widget _buildStrokeToolbar(BuildContext context) {
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final w in notifier.widths)
            _buildStrokeButton(
              context,
              strokeWidth: w,
              state: state,
            ),
        ],
      ),
    );
  }

  Widget _buildStrokeButton(
      BuildContext context, {
        required double strokeWidth,
        required ScribbleState state,
      }) {
    final selected = state.selectedWidth == 7.5;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        elevation: selected ? 4 : 0,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => notifier.setStrokeWidth(strokeWidth),
          customBorder: const CircleBorder(),
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            width: strokeWidth * 2,
            height: strokeWidth * 2,
            decoration: BoxDecoration(
                color: state.map(
                  drawing: (s) => Color(s.selectedColor),
                  erasing: (_) => Colors.transparent,
                ),
                border: state.map(
                  drawing: (_) => null,
                  erasing: (_) => Border.all(width: 1),
                ),
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildColorToolbar(BuildContext context) {
    notifier.setColor(Colors.orangeAccent);
    return StateNotifierBuilder<ScribbleState>(
      stateNotifier: notifier,
      builder: (context, state, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildUndoButton(context),
          const Divider(
            height: 4.0,
          ),
          _buildRedoButton(context),
          const Divider(
            height: 4.0,
          ),
          _buildClearButton(context),
          const Divider(
            height: 20.0,
          ),
          _buildPointerModeSwitcher(context,
              penMode:
              state.allowedPointersMode == ScribblePointerMode.penOnly),
          const Divider(
            height: 20.0,
          ),
          _buildEraserButton(context, isSelected: state is Erasing),
          _buildColorButton(context, color: Colors.yellow, state: state),
        ],
      ),
    );
  }

  Widget _buildPointerModeSwitcher(BuildContext context,
      {required bool penMode}) {
    return FloatingActionButton.small(
      onPressed: () => _saveImage(context),
      child: Icon(Icons.check_circle_outline)
    );
  }

  Widget _buildEraserButton(BuildContext context, {required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FloatingActionButton.small(
        tooltip: "Erase",
        backgroundColor: const Color(0xFFF7FBFF),
        elevation: isSelected ? 10 : 2,
        shape: !isSelected
            ? const CircleBorder()
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.blueGrey),
        onPressed: notifier.setEraser,
      ),
    );
  }

  Widget _buildColorButton(
      BuildContext context, {
        required Color color,
        required ScribbleState state,
      }) {
    final isSelected = state is Drawing && state.selectedColor == color.value;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FloatingActionButton.small(
          backgroundColor: color,
          elevation: isSelected ? 10 : 2,
          shape: !isSelected
              ? const CircleBorder()
              : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            child: Icon(Icons.draw),
          ),
          onPressed: () => notifier.setColor(color)),
    );
  }

  Widget _buildUndoButton(
      BuildContext context,
      ) {
    return FloatingActionButton.small(
      tooltip: "Undo",
      onPressed: notifier.canUndo ? notifier.undo : null,
      disabledElevation: 0,
      backgroundColor: notifier.canUndo ? Colors.blueGrey : Colors.grey,
      child: const Icon(
        Icons.undo_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRedoButton(
      BuildContext context,
      ) {
    return FloatingActionButton.small(
      tooltip: "Redo",
      onPressed: notifier.canRedo ? notifier.redo : null,
      disabledElevation: 0,
      backgroundColor: notifier.canRedo ? Colors.blueGrey : Colors.grey,
      child: const Icon(
        Icons.redo_rounded,
        color: Colors.white,
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return FloatingActionButton.small(
      tooltip: "Clear",
      onPressed: notifier.clear,
      disabledElevation: 0,
      backgroundColor: Colors.blueGrey,
      child: const Icon(Icons.clear),
    );
  }
}