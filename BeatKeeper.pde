int lastTickStartedAt = 0;

Keeper keeper;

void setup() {
    size(400, 400);

    keeper = new Keeper(bpm);

    frameRate(tickRate);
}

void draw() {
    int now = millis();
    
    int delta = now - lastTickStartedAt;

    keeper.update(delta);

    lastTickStartedAt = now;
}
