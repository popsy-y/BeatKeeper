import controlP5.*;

class GUI {
    ControlP5 cp5;
    Keeper keeper;

    GUI(PApplet papplet, Keeper keeperInst) {
        cp5 = new ControlP5(papplet);

        keeper = keeperInst;

        cp5.addSlider("PhaseOffset")
        .setPosition(20, 30)
        .setSize(200, 20)
        .setRange(0, 1)
        .addCallback(new CallbackListener(){
            public void controlEvent(CallbackEvent ev){
                Controller ctlr = ev.getController();
                float val = ctlr.getValue();

                keeper.setOffset(val);
            }
        });

        cp5.addTextfield("BPM")
        .setPosition(20, 70)
        .setSize(100, 20)
        .addCallback(new CallbackListener(){
            public void controlEvent(CallbackEvent ev){
                if (ev.getAction() != ControlP5.ACTION_BROADCAST) return;

                Controller ctlr = ev.getController();
                float val = float(ctlr.getStringValue());

                keeper.setBpm(val);
            }
        });
    }

    void draw() {
        background(30);

        int st = 20;
        int end = width - 20;
        int len = end - st;
        rect(20, 100, width - 40, 10);
        line(
            st + len * keeper.getHeadPosition(),
            100,
            st + len * keeper.getHeadPosition(),
            110
        );

        text(keeper.getBeatStep(), 20, 130);
    }
}