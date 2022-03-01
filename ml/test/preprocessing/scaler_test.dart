import 'dart:math';

import 'package:ml/src/preprocessing/scaler.dart';
import 'package:ml/src/tool/result.dart';
import 'package:test/test.dart';

void main() {
  Scaler scaler = Scaler();
  List<List<double>> fitVectors = [];
  List<List<double>> transformVectors = [];

  setUp(() {
    fitVectors = [
      [1.0, 2.0, 3.0],
      [0.0, 0.0, 1.0]
    ];

    transformVectors = [
      [1.0, 1.0, 1.0],
      [-0.1, 1.0, 3.1]
    ];

    scaler = Scaler();
  });

  test('fit', () {
    print(fitVectors);

    final result = scaler.fit(vectors: fitVectors);
    expect(result is Success, true);
    print("featureMinValue: ${scaler.featureMinValue}");
    print("featureMaxValue: ${scaler.featureMaxValue}");
  });

  test('fit with empty data', () {
    expect(scaler.fit(vectors: []) is Failure, true);
  });

  test('transform, copy = false', () {
    scaler.fit(vectors: fitVectors);
    final result = scaler.transform(vectors: transformVectors, copy: false);
    expect(result is Success, true);
    expect(
        (result as Success<List<List<double>>>).data == transformVectors, true);
    print('vectors = $transformVectors');
    print('result.data = ${result.data}');
  });

  test('transform, copy = true', () {
    scaler.fit(vectors: fitVectors);
    final result = scaler.transform(vectors: transformVectors, copy: true);
    expect(result is Success, true);
    expect(
        (result as Success<List<List<double>>>).data != transformVectors, true);
    print('vectors = $transformVectors');
    print('result.data = ${result.data}');
  });

  test('fitTransform', () {
    final result = scaler.fitTransform(vectors: fitVectors);
    expect(result is Success, true);
    print(fitVectors);
  });
}
