part of '../record_page.dart';

class _RecordView extends StatefulWidget {
  const _RecordView();

  @override
  State<_RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<_RecordView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _RecordGraph(),
      ],
    );
  }
}
