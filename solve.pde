int[][] clone2d(int[][] arr) {
  int[][] cloned = new int[arr.length][arr[0].length];
  for (int i = 0; i < arr.length; i ++) {
    cloned[i] = arr[i].clone();
  }

  return cloned;
}


int[][] solve(int[][] sudoku) {
  return solve(sudoku, emptyPositions(sudoku));
}

int[][] solve(int[][] sudoku, IntList emptyPos) {
  int[][] solved = clone2d(sudoku);

  int cursor = 0;
  while (cursor < emptyPos.size()) {

    int index = emptyPos.get(cursor);
    int i = floor(index / 9);
    int j = index % 9;

    int winner = -1;

    for (int value = solved[i][j] + 1; value <= 9; value ++) {
      if (canPlace(solved, i, j, value)) {
        winner = value;
        break;
      }
    }

    if (winner == -1) {
      solved[i][j] = 0;
      cursor --;
    } else {
      solved[i][j] = winner;
      cursor ++;
    }
  }

  return solved;
}

int[][] solveAgain(int[][] sudoku, IntList emptyPos) {
  int[][] solved = clone2d(sudoku);

  int cursor = emptyPos.size() - 1;
  while (cursor >= 0) {
    if (cursor >= emptyPos.size() || cursor < 0) break;

    int index = emptyPos.get(cursor);
    int i = floor(index / 9);
    int j = index % 9;

    int winner = -1;

    for (int value = solved[i][j] + 1; value <= 9; value ++) {
      if (canPlace(solved, i, j, value)) {
        winner = value;
        break;
      }
    }

    if (winner == -1) {
      solved[i][j] = 0;
      cursor --;
    } else {
      solved[i][j] = winner;
      cursor ++;
    }
  }

  if (cursor >= 0) return solved;
  else return null;
}


boolean hasMultipleSolutions(int[][] sudoku) {
  IntList emptyPos = emptyPositions(sudoku);
  
  int[][] solution1 = solve(sudoku, emptyPos);
  int[][] solution2 = solveAgain(solution1, emptyPos);
  
  return solution2 != null;
}


boolean canPlace(int[][] sudoku, int i, int j, int value) {
  for (int r = 0; r < 9; r ++) {
    if (r == i) continue;
    if (sudoku[r][j] == value) return false;
  }

  for (int c = 0; c < 9; c ++) {
    if (c == j) continue;
    if (sudoku[i][c] == value) return false;
  }

  int boxI = floor(i / 3) * 3;
  int boxJ = floor(j / 3) * 3;

  for (int r = boxI; r < boxI + 3; r ++) {
    for (int c = boxJ; c < boxJ + 3; c ++) {
      if (sudoku[r][c] == value) return false;
    }
  }

  return true;
}


void printSudoku(int[][] sudoku) {
  for (int i = 0; i < 9; i ++) {
    println();
    if (i % 3 == 0) print("\n\n");
    for (int j = 0; j < 9; j ++) {
      if (j % 3 == 0) print("  ");
      print(sudoku[i][j] + " ");
    }
  }
  println();
}
