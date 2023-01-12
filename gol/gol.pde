static final int CELL_SIZE = 3;

static final int WINDOW_WIDTH = 1300;
static final int WINDOW_HEIGHT = 700;

boolean[][] cells;
boolean[][] tmp;

int fieldWidth;
int fieldHeight;

boolean drawMode;

void setup() {
    size(1300, 700);

    drawMode = true;

    fieldWidth = (int) Math.floor(WINDOW_WIDTH / CELL_SIZE);
    fieldHeight = (int) Math.floor(WINDOW_HEIGHT / CELL_SIZE);
    cells = new boolean[fieldWidth][fieldHeight];
    tmp = new boolean[fieldWidth][fieldHeight];
}

void draw() {
    background(240);

    if (mousePressed && drawMode) {
        int targetX = (int) Math.floor(mouseX / CELL_SIZE);
        int targetY = (int) Math.floor(mouseY / CELL_SIZE);
        if (targetX >= 0 && targetX < fieldWidth && targetY >= 0 && targetY < fieldHeight) {
            cells[targetX][targetY] = true;
        }
    }

    if (!drawMode) {
        for (int i = 0; i < fieldWidth; i++) {
            for (int j = 0; j < fieldHeight; j++) {
                int leftX = Math.floorMod(i - 1, fieldWidth);
                int rightX = Math.floorMod(i + 1, fieldWidth);
                int topY = Math.floorMod(j - 1, fieldHeight);
                int downY = Math.floorMod(j + 1, fieldHeight);

                int countNeighbors = 0;
                if (cells[leftX][topY]) countNeighbors++;
                if (cells[i][topY]) countNeighbors++;
                if (cells[rightX][topY]) countNeighbors++;
                if (cells[rightX][j]) countNeighbors++;
                if (cells[rightX][downY]) countNeighbors++;
                if (cells[i][downY]) countNeighbors++;
                if (cells[leftX][downY]) countNeighbors++;
                if (cells[leftX][j]) countNeighbors++;

                if (cells[i][j]) {
                    if (countNeighbors == 2 || countNeighbors == 3) {
                        tmp[i][j] = true;
                    } else {
                        tmp[i][j] = false;
                    }
                } else {
                    if (countNeighbors == 3) {
                        tmp[i][j] = true;
                    } else {
                        tmp[i][j] = false;
                    }
                }
            }
        }

        for (int i = 0; i < fieldWidth; i++) {
            for (int j = 0; j < fieldHeight; j++) {
                cells[i][j] = tmp[i][j];
            }
        }
    }

    for (int i = 0; i < fieldWidth; i++) {
        for (int j = 0; j < fieldHeight; j++) {
            if (cells[i][j]) {
                noStroke();
                fill(color(100, 100, 255));
                rect(i * CELL_SIZE, j * CELL_SIZE, CELL_SIZE, CELL_SIZE);
            }
        }
    }
}

void keyPressed() {
    if (key == 'd' || key == 'D') {
        drawMode = drawMode ? false : true;
    }

    if (key == 'c' || key == 'C') {
        cells = new boolean[fieldWidth][fieldHeight];
        tmp = new boolean[fieldWidth][fieldHeight];
    }
}
