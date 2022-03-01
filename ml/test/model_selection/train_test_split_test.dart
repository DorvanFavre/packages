import 'package:ml/src/model_selection/train_test_split.dart';
import 'package:test/test.dart';

void main() {
  final vectors = [
    for (int i = 0; i < 100; i++) [1.0, 2.0, 3.0]
  ];

  final labels = [
    for (int i = 0; i < 100; i++) [1.0]
  ];

  test('Size of the train a test set', () {
    final splitDataset =
        TrainTestSplit(vectors: vectors, labels: labels, testFraction: 0.25);
    expect(splitDataset.trainingVectors.length,
        splitDataset.trainingLabels.length);
    expect(
        splitDataset.testingVectors.length, splitDataset.testingLabels.length);
    expect(splitDataset.trainingLabels.length, 75);
    expect(splitDataset.testingLabels.length, 25);
  });
}
