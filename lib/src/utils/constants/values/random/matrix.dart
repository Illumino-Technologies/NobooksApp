enum Matrix {
  zero(
  <double>[
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
  ]),
  identity(
    <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ]
  ),
  greyScale(
  <double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

  List<double> opacity(double opacity) =>(
  <double>[
    1,   0,   0,   0,   0,
    0,   1,   0,   0,   0,
    0,   0,   1,   0,   0,
    0,   0,   0,   opacity,   0,
  ]);

  final List<double> matrix;

  const Matrix(this.matrix);
}
