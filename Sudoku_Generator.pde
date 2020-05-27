//Press space to generate new sudokus and s to solve them

import java.util.Arrays;

int[][] grid;
IntList empty;
float w;

void setup() {
  size(400, 400);
  
  grid = new int[9][9];
  grid = generate();
  empty = emptyPositions(grid);
  
  w = width / 9;
  textSize(w / 2);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  for (int i = 0; i < 9; i ++) {
    for (int j = 0; j < 9; j ++) {
      if (grid[i][j] != 0) {
        int index = i * 9 + j;
        if (empty.hasValue(index)) fill(0);
        else fill(255, 0, 0);
        text(grid[i][j], j * w + w / 2, i * w + w / 2);
      }
    }
  }
  
  for (float i = 0; i < 9; i ++) {
    float y = i * w;
    float x = y;
    if (i % 3 == 0) strokeWeight(3);
    else strokeWeight(1);
    line(0, y, width, y);
    line(x, 0, x, height);
  }
}

IntList emptyPositions(int[][] sudoku) {
  IntList emptyPos = new IntList();
  for (int i = 0; i < 9; i ++) {
    for (int j = 0; j < 9; j ++) {
      if (sudoku[i][j] == 0) emptyPos.append(9 * i + j);
    }
  }
  return emptyPos;
}

int[] shuffle(int[] arr) {
  int[] answer = arr.clone();
  for (int i = 0; i < answer.length * 4; i ++) {
    int i1 = floor(random(arr.length));
    int i2 = floor(random(arr.length));
    
    int temp = answer[i1];
    answer[i1] = answer[i2];
    answer[i2] = temp;
  }
  return answer;
}

void keyPressed() {
  if (key == 's') {
    grid = solve(grid, empty);
  }
  
  
  else if (key == ' ') {
    grid = generate();
    empty = emptyPositions(grid);
  }
}
