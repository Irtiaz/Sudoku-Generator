IntList canPlace(int[][] sudoku, int i, int j) {
  IntList answer = new IntList();
  for (int value = 1; value <= 9; value ++) {
    if (canPlace(sudoku, i, j, value)) answer.append(value);
  }
  return answer;
}

int[][] generate() {
  int[][] sudoku = new int[9][9];
  
  for (int start = 0; start < 9; start += 3) {
    int[] box = shuffle(new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9});
    int index = 0;
    
    for (int i = start; i < start + 3; i ++) {
      for (int j = start; j < start + 3; j ++) {
        sudoku[i][j] = box[index];
        index ++;
      }
    }
  }
  
  sudoku = solve(sudoku);
  
  int[][] answer = new int[9][9];
  
  boolean done = false;
  while (!done) {
    int i = floor(random(9));
    int j = floor(random(9));
    
    answer[i][j] = sudoku[i][j];
    done = !hasMultipleSolutions(answer);
  }

  return answer;
}


int randomFrom(IntList list) {
  int randomIndex = floor(random(list.size()));
  return list.get(randomIndex);
}
