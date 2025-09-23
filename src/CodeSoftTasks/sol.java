package CodeSoftTasks;


import java.util.*;

class abc {
    void ab(Object o ){
        System.out.println("Object");
        System.out.println(o);
    }

    void ab(String o ){
        System.out.println("String");
        System.out.println(o);
    }

    void ab (int o){
        System.out.println("Integer");
        System.out.println(o);
    }

    public static void main(String[] args) {
        abc  i = new abc();
        i.ab(null);
        Queue<Integer> q = new ArrayDeque<>();
        Queue<int[]> q2 = new LinkedList<>();
        Queue<List<Integer>> queue = new LinkedList<>();

        Boolean[] dp = new Boolean[2];
        Integer[] dp2 = new Integer[2];
        System.out.println(dp[0]);
        System.out.println(Arrays.toString(dp));
    }
}