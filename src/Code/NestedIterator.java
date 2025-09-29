package Code;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class NestedIterator implements Iterator<Integer> {
    List<Integer> list ;
    int i ;
    public NestedIterator(List<NestedInteger> nestedList) {
        list = new ArrayList<>();
        i =0;
        rec( nestedList);
    }

    void rec( List<NestedInteger> n ){
        for(NestedInteger ni : n){
            if (ni.isInteger())list.add(ni.getInteger());
            else rec(ni.getList());
        }
    }

    @Override
    public Integer next() {
        return list.get(i++);
    }

    @Override
    public boolean hasNext() {
        return i<list.size();
    }
}
