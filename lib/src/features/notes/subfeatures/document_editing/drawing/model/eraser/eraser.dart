import '../../drawing_barrel.dart';

part 'erase_mode.dart';

part 'region.dart';

class Eraser {
  final Region region;
  final EraseMode mode;

  const Eraser({
    required this.region,
    required this.mode,
  });

  Eraser copyWith({
    Region? region,
    EraseMode? mode,
  }) {
    return Eraser(
      region: region ?? this.region,
      mode: mode ?? this.mode,
    );
  }
}
