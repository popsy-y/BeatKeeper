class Keeper{
    private int elapsed, barInterval, barIdx, bpm;

    private float offset;

    Keeper(float bpm){
        elapsed = 0;
        barIdx = 0;

        offset = 0;

        this.barInterval = round((60 * 1000) / bpm);
    }

    public boolean update(int delta) {
        elapsed += delta;

        if (elapsed > this.barInterval) {
            if (logBeat) {
                println("beat " + barIdx % bars + " " + barIdx);
            }

            this.barIdx++;

            elapsed = max(elapsed - this.barInterval, 0);

            return true;
        }

        return false;
    }

    public void setBpm(int bpm){

    }

    public void setOffset(float ofst){

    }

    public void tweakOffset(float delta){
        
    }
}
