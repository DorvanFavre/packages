import 'dart:math';
import 'package:csv/csv.dart';
import 'package:ml/src/linear_model/linear_regression.dart';
import 'package:ml/src/model_selection/train_test_split.dart';
import 'package:ml/src/model_selection/vectors_labels_split.dart';
import 'package:ml/src/preprocessing/scaler.dart';
import 'package:ml/src/tool/result.dart';

import '';
import 'package:test/test.dart';
import 'dart:io' as io;

void main() {
  group('Linear regression with gradient zero', () {
// Create the model
    final model = LinearRegression();
    late List<double> trainingVectors;
    late List<double> trainingLabels;
    late List<double> testingVectors;
    late List<double> testingLabels;

    setUp(() async {
      // Get the dataset
      final file = await io.File('assets/Salary_Data.csv').readAsString();
      var dataset = CsvToListConverter().convert(file);
      // Data preprocessing
      dataset.removeAt(0);

      final vectorsAndLabels = VectorsLabelsSplit(
          dataset: dataset, vectorIndexes: [0], labelIndexes: [1]);

      Scaler().fitTransform(vectors: vectorsAndLabels.labels);

      final trainingAndTest = TrainTestSplit(
          vectors: vectorsAndLabels.vectors, labels: vectorsAndLabels.labels);
      trainingVectors =
          trainingAndTest.trainingVectors.map((e) => e[0]).toList();
      trainingLabels = trainingAndTest.trainingLabels.map((e) => e[0]).toList();
      testingVectors = trainingAndTest.testingVectors.map((e) => e[0]).toList();
      testingLabels = trainingAndTest.testingLabels.map((e) => e[0]).toList();
    });

    test('Train model with wrong training set', () {
      trainingLabels.removeLast();
      print(trainingLabels.length);

      final result = model.trainWithGradientZero(
          trainingVectors: trainingVectors, trainingLabels: trainingLabels);
      expect(result is Failure, true);
    });

    test('Train the model with right training set', () {
      print(trainingLabels.length);
      final result = model.trainWithGradientZero(
          trainingVectors: trainingVectors, trainingLabels: trainingLabels);
      expect(result is Success, true);
      print('y-intercept =${model.a}');
      print('slope = ${model.b}');
    });

    test("Predict", () {
      final result = model.predict(vector: testingVectors[0]);
      expect(result is Success, true);
      print('prediction = ${(result as Success).data}');
      print('label = ${testingLabels[0]}');
    });

    test("SSR around the fit", () {
      final sSR = model.sSRFit(vectors: testingVectors, labels: testingLabels);
      expect(sSR is Success, true);
      print("SSR around the fit = ${(sSR as Success).data}");
    });

    test("Calculate mean", () {
      final mean = model.mean(labels: testingLabels);
      expect(mean is Success, true);
      print("Mean = ${(mean as Success).data}");
    });

    test("SSR around the mean", () {
      final sSRMean = model.sSRMean(labels: testingLabels);
      expect(sSRMean is Success, true);
      print("SSR around the mean = ${(sSRMean as Success).data}");
    });

    test("R Squared", () {
      final rSquared =
          model.rSquared(vectors: testingVectors, labels: testingLabels);
      expect(rSquared is Success, true);
      print("R Squared = ${(rSquared as Success).data}");
    });
  });
/*
  group('Linear regression with gradient descente', () {
// Create the model
    final model = LinearRegression();
    late List<double> trainingVectors;
    late List<double> trainingLabels;
    late List<double> testingVectors;
    late List<double> testingLabels;

    setUp(() async {
      // Get the dataset
      final file = await io.File('assets/Salary_Data.csv').readAsString();
      var dataset = CsvToListConverter().convert(file);
      // Data preprocessing
      dataset.removeAt(0);

      final vectorsAndLabels = pre.SplitDatasetIntoVectorsAndLabels(
          dataset: dataset, vectorIndexes: [0], labelIndexes: [1]);

      final normalizedLabels =
          pre.Normalize(vectors: vectorsAndLabels.labels).normalizedDataset;
      final trainingAndTest = pre.SplitDatasetIntoTrainingsetAndTestset(
          vectors: vectorsAndLabels.vectors, labels: normalizedLabels);
      trainingVectors =
          trainingAndTest.trainingVectors.map((e) => e[0]).toList();
      trainingLabels = trainingAndTest.trainingLabels.map((e) => e[0]).toList();
      testingVectors = trainingAndTest.testingVectors.map((e) => e[0]).toList();
      testingLabels = trainingAndTest.testingLabels.map((e) => e[0]).toList();
    });

    test('Train model with wrong training set', () {
      trainingLabels.removeLast();
      print(trainingLabels.length);

      final result = model.trainWithGradientDescente(
        trainingVectors: trainingVectors,
        trainingLabels: trainingLabels,
        intermediateState: (epoch) {},
      );
      expect(result is Failure, true);
    });

    test('Train the model with right training set', () {
      print(trainingLabels.length);
      final result = model.trainWithGradientDescente(
        trainingVectors: trainingVectors,
        trainingLabels: trainingLabels,
        epoch: 100,
        learningRate: 0.05,
        intermediateState: (epoch) {
          print("------------\nEpoch : $epoch");
          print('y-intercept =${model.a}');
          print('slope = ${model.b}');
          print(
              'R squared: ${(model.rSquared(vectors: testingVectors, labels: testingLabels) as Success).data}\n');
        },
      );
      expect(result is Success, true);
      print('y-intercept =${model.a}');
      print('slope = ${model.b}');
    });
  });
  */
}
