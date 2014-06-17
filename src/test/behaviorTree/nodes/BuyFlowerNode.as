package test.behaviorTree.nodes
{
    import ninedays.behaviorTree.ActionNode;

    /**
     *
     * @author 9days
     */
    public class BuyFlowerNode extends ActionNode
    {
        override public function execute():void
        {
            super.execute();
            Player.instance.buyFlower();
            returnResultToParent(true);
        }
    }
}