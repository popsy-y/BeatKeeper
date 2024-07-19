int lastTickStartedAt = 0;

Keeper keeper;

GUI gui;

void setup() {
    size(400, 400);

    keeper = new Keeper(bpm);

    gui = new GUI(this, keeper);

    frameRate(tickRate);

    background(0);
}

void draw() {
    int now = millis();
    
    int delta = now - lastTickStartedAt;

    keeper.update(delta);

    gui.draw();

    if (logFrameTime) {
        println(delta + " ms");
    }
    lastTickStartedAt = now;
}
