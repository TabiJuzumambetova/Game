import 'dart:io';
import 'dart:math';

void main() {
  print("Добро пожаловать в игру!");
  print("Выберите режим игры:");
  print("1. Пользователь угадывает, компьютер загадывает");
  print("2. Компьютер угадывает, пользователь загадывает");
  print("3. Игра по очереди (по умолчанию)");
  int gameMode = int.tryParse(stdin.readLineSync() ?? "3") ?? 3;

  // ignore: unused_local_variable
  int round = 3; 
  print("Введите количество раундов (от 1 до 10):");
  round = int.tryParse(stdin.readLineSync() ?? "3") ?? 3;

  print("Выберите уровень сложности:");
  print("1. Легкий");
  print("2. Сложный");
  int difficultyLevel = int.tryParse(stdin.readLineSync() ?? "1") ?? 1;

  int userWins = 0;
  int compWins = 0;
  int draws = 0;

  for (int i = 1; i <= round; i++) {
    print("====================");
    print("Раунд №$i");
    
    if (gameMode == 1) {
      int userSteps = userGuessesTheNumber(difficultyLevel);
      int compSteps = compGuessesTheNumber(difficultyLevel);
      if (userSteps < compSteps) {
        userWins++;
        print("Пользователь победил в этом раунде!");
      } else if (compSteps < userSteps) {
        compWins++;
        print("Компьютер победил в этом раунде!");
      } else {
        draws++;
        print("Ничья в этом раунде!");
      }
    } else if (gameMode == 2) {
      int compSteps = compGuessesTheNumber(difficultyLevel);
      int userSteps = userGuessesTheNumber(difficultyLevel);
      if (compSteps < userSteps) {
        compWins++;
        print("Компьютер победил в этом раунде!");
      } else if (userSteps < compSteps) {
        userWins++;
        print("Пользователь победил в этом раунде!");
      } else {
        draws++;
        print("Ничья в этом раунде!");
      }
    } else {
      print("Этап 1: Пользователь загадывает, компьютер угадывает");
      int userSteps = userGuessesTheNumber(difficultyLevel);
      int compSteps = compGuessesTheNumber(difficultyLevel);
      if (userSteps < compSteps) {
        userWins++;
        print("Пользователь победил в этом этапе!");
      } else if (compSteps < userSteps) {
        compWins++;
        print("Компьютер победил в этом этапе!");
      } else {
        draws++;
        print("Ничья в этом этапе!");
      }

      print("Этап 2: Компьютер загадывает, пользователь отгадывает");
      compSteps = compGuessesTheNumber(difficultyLevel);
      userSteps = userGuessesTheNumber(difficultyLevel);
      if (compSteps < userSteps) {
        compWins++;
        print("Компьютер победил в этом этапе!");
      } else if (userSteps < compSteps) {
        userWins++;
        print("Пользователь победил в этом этапе!");
      } else {
        draws++;
        print("Ничья в этом этапе!");
      }
    }
  }

  print("====================");
  print("Игра завершена!");
  print("Результаты:");
  print("Пользователь: $userWins побед(ы)");
  print("Компьютер: $compWins побед(ы)");
  print("Ничьи: $draws");
}

int userGuessesTheNumber(int difficultyLevel) {
  int compNumber = Random().nextInt(100) + 1;
  int steps = 0;

  print("Компьютер загадал число от 1 до 100. Попробуйте угадать.");

  while (true) {
    int userGuess = int.tryParse(stdin.readLineSync() ?? "")??0;

    // ignore: unnecessary_null_comparison
    if (userGuess == null) {
      print("Введите число.");
    } else if (userGuess > compNumber) {
      print("less");
      steps++;
    } else if (userGuess < compNumber) {
      print("more");
      steps++;
    } else if (userGuess == compNumber) {
      print("yes");
      print("Угадано за $steps шагов!");
      return steps;
    }
  }
}

int compGuessesTheNumber(int difficultyLevel) {
  // ignore: unused_local_variable
  int userNumber = Random().nextInt(100) + 1;
  int min = 1;
  int max = 100;
  int steps = 0;

  print("Загадайте число от 1 до 100, а компьютер попробует угадать.");

  while (true) {
    int guess = (difficultyLevel == 1)
        ? Random().nextInt(max - min + 1) + min 
        : ((max - min) / 2).round() + min; 
    steps++;

    print("Это число $guess?");
    String answer = stdin.readLineSync()?.toLowerCase() ?? "";

    if (answer == "less") {
      max = guess - 1;
    } else if (answer == "more") {
      min = guess + 1;
    } else if (answer == "yes") {
      print("Угадано за $steps шагов!");
      return steps;
    } else {
      print("Введите меньше/больше/да");
    }
  }
}
