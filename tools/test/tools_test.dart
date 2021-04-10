import 'package:flutter_test/flutter_test.dart';

import 'package:tools/tools.dart';

void main() {
  test('first test', () {
    Result<int> result = Success(data: 4);

    if(result is Success<int>){
      final x = result.data;
      
    }


  });
}
