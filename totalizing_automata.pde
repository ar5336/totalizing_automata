int[] grid;
int cell_w = 4;
int cell_h = 4;

int NUM_STATES = 4;
int NUM_NBRS = 4;

color[] colors = new color[NUM_STATES];

int w;
int LEVEL = 0;

int[] rule = new int[NUM_STATES*NUM_NBRS];

void setup(){
  //frameRate(10);
  size(4000,1000);
  
  w = width/cell_w;
  
  grid = new int[w];
  
  noStroke();
  
  setup_random();
  randomize_rule();
  randomize_colors();
}

void randomize_colors(){
  for(int i = 0; i < colors.length; i++){
    colors[i] = color(random(255),random(255),random(255));
  }
}

color get_color_from_state(int state){
  return colors[state];
}

void setup_random(){
  clear_grid();
  int num = int(random(200));
  for(int i = 0; i < num; i++){
    grid[int(random(w))] = int(random(NUM_STATES));
  }
}

void keyPressed(){
  if( key == ' '){
    update();
  }
  if( key == 'r'){
    randomize_rule();
    setup_random();
    randomize_colors();
  }
  if( key == 'c'){
    setup_random();
    LEVEL = 0;
  }
}

void randomize_rule(){
  rule[0] = 0;
  rule[1] = 0;
  for(int i = 2; i < rule.length; i++){
    rule[i] = int(random(NUM_STATES*abs(i-rule.length/2)));
  }
}

void do_update(){
  for(int c = 0; c < w; c++){
    fill(get_color_from_state(grid[c]));
    rect(c*cell_w, LEVEL*cell_h, cell_w, cell_h);
  }
  LEVEL++;
  update();
}

void draw(){
  for(int i = 0; i < 40; i++){
    do_update();
  }

}

void clear_grid(){
  for(int c = 0; c < w; c++){
    grid[c] = 0;
    LEVEL = 0;
  }
  background(0);
}

void update(){  
  for(int c = 0; c < w; c++){
      
    int total_index = 0;
    
    for (int c_2 = max(0, c-int(NUM_NBRS/2)); c_2 <= min(w-1, c+int(NUM_NBRS/2)); c_2++){
      total_index += grid[c_2];
    }
    
    grid[c] = rule[total_index%rule.length] % NUM_STATES;
  }
}
