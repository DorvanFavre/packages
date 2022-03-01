import 'package:ml/src/model_selection/vectors_labels_split.dart';
import 'package:test/test.dart';

void main() {
  final dataset = [
    for (int i = 0; i < 100; i++) [1.0, 2.0, 3.0, 4.0, 5.0]
  ];

  test('VectorsLabelsSplit', () {
    final splitDataset = VectorsLabelsSplit(
        dataset: dataset, vectorIndexes: [0, 1, 2], labelIndexes: [3, 4]);

    expect(splitDataset.labels.length, 100);
    expect(splitDataset.vectors.length, 100);
    expect(splitDataset.vectors[0].length, 3);
    expect(splitDataset.labels[0].length, 2);
  });
}
