import remixlab.tersehandling.generic.profile.*;

public enum MotionAction implements Actionable<GlobalAction> {
  CHANGE_POSITION(GlobalAction.CHANGE_POSITION), 
  CHANGE_SHAPE(GlobalAction.CHANGE_SHAPE);

  @Override
  public GlobalAction referenceAction() {
    return act;
  }

  @Override
  public String description() {
    return "A simple motion action";
  }

  @Override
  public int dofs() {
    return 2;
  }

  GlobalAction act;

  MotionAction(GlobalAction a) {
    act = a;
  }
}
