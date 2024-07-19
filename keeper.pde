class Keeper{
    private int barIdx, beatStep;

    private float bpm, elapsed, barInterval, beatInterval, offset;

    private float[] beatPoints;

    public float getHeadPosition() {
        return wrapBeatPoint(this.elapsed + this.offset) / this.barInterval;
    }

    public int getBeatStep() {
        return this.beatStep;
    }

    Keeper(float bpm){
        this.elapsed = 0;
        this.barIdx = 0;

        this.offset = 0;

        this.beatStep = 0;

        refreshBpm(bpm);
    }

    public void update(int delta) {
        float now = this.elapsed + delta;
        float shifted = wrapBeatPoint(now + this.offset);
        
        int b = onBeat(this.elapsed, delta);
        if (b != -1) {
            this.beatStep = b;
        }

        if (now > this.barInterval) {
            if (logBeat) {
                println("bar " + barIdx);
            }

            this.barIdx++;

            this.elapsed = max(this.elapsed - this.barInterval, 0);
        }


        this.elapsed += delta;
    }

    private int onBeat(float prev, float delta) {
        for (int i = 0; i < this.beatPoints.length; ++i) {
            float point = this.beatPoints[i];

            if (
                (prev < point && prev + delta >= point) ||
                prev + delta > this.barInterval
            ) {
                return i;
            }
        }

        return -1;
    }

    private void setBeatPoints() {
        this.beatPoints = new float[] {
            wrapBeatPoint(0),
            wrapBeatPoint(this.beatInterval),
            wrapBeatPoint(this.beatInterval * 2),
            wrapBeatPoint(this.beatInterval * 3)
        };
    }

    private float wrapBeatPoint(float point) {
        return (point + this.barInterval) % this.barInterval;
    }

    public void refreshBpm(float bpm){
        this.bpm = bpm;

        this.barInterval = (60 * 1000) / bpm * 4;
        this.beatInterval = this.barInterval / 4;

        setBeatPoints();
    }

    public void setOffset(float ofst){
        float scaled = ofst * this.barInterval;
        this.offset = scaled;

        setBeatPoints();
    }

    public void tweakOffset(float delta){
        
    }
}
