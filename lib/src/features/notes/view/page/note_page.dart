import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/core/themes/color.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

QuillController _controller = QuillController.basic();

class _NotePageState extends ConsumerState<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1110,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: AppColors.mBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Container(
                  width: 800,
                  height: 80,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuillToolbar.basic(controller: _controller),
                  ),
                ),
              ),
              const SizedBox(
                height: 116,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 1110,
                  child: QuillEditor.basic(
                      controller: _controller, readOnly: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
