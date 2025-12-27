package btech.DSA;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Subset {
    //Input: Set = {3, 34, 4, 12, 5, 2}, Target Sum = 9
    static boolean SS(int[] array, int sum, int TotalSum, int idx){ // idx = 0, CurSub = Empty list, check = false
        if (idx== array.length)return false;
        TotalSum+=array[idx];
        for (int i = idx+1; i < array.length; i++) {
            if (array[i]<sum){
                if (TotalSum+array[i]==sum)return true;
                else TotalSum+=array[i];
            }
        }
        return SS(array,sum,0,idx+1);
    }

    static void PowerSet(int[] array
            , List<List<Integer>> outer
            , ArrayList<Integer> inner
            , int idx){ //idx = 0, outer = ArrayList Type
        if (idx == array.length) outer.add(new ArrayList<>(inner));
        else {
            PowerSet(array,outer,inner,idx+1 );
            inner.add(array[idx]);
            PowerSet(array,outer,inner,idx+1 );
        }
    }

    public int findKthNumber(int n, int k) {
        int curr = 1;
        k--;

        while (k > 0) {
            long steps = countSteps(n, curr, curr + 1);
            if (steps <= k) {
                k -= (int) steps;
                curr++;
            } else {
                curr *= 10;
                k--;
            }
        }
        return curr;
    }

    long countSteps(int n, long curr, long next) {
        long steps = 0;
        while (curr <= n) {
            steps += Math.min(n + 1, next) - curr;
            curr *= 10;
            next *= 10;
        }
        return steps;
    }



    public static void main(String[] args) {
        Subset s = new Subset();
        System.out.println(s.findKthNumber(10 , 3));
//        List<List<Integer>> list = new ArrayList<>(8);
//        PowerSet(new int[]{1,2,3},list,new ArrayList<>(),0);
//        System.out.println(Arrays.toString(new List[]{list}));
//        System.out.println("Test 1 (expected: true): " + SS(new int[]{3, 34, 4, 12, 5, 2}, 9, 0, 0));
//System.out.println("Test 2 (expected: false): " + SS(new int[]{1, 2, 5, 6}, 15, 0, 0));
//System.out.println("Test 3 (expected: true): " + SS(new int[]{10, 5, 3, 7, 2}, 15, 0, 0));
//System.out.println("Test 4 (expected: false): " + SS(new int[]{4, 8, 16, 32}, 7, 0, 0));
//System.out.println("Test 5 (expected: true): " + SS(new int[]{1, 2, 3, 4, 5}, 10, 0, 0));
//System.out.println("Test 6 (expected: false): " + SS(new int[]{20, 30, 40}, 25, 0, 0));
//System.out.println("Test 7 (expected: true): " + SS(new int[]{11, 3, 5, 9}, 14, 0, 0));
//System.out.println("Test 8 (expected: true): " + SS(new int[]{6, 2, 9, 8}, 8, 0, 0));
//System.out.println("Test 9 (expected: false): " + SS(new int[]{13, 17, 19, 23}, 11, 0, 0));
//System.out.println("Test 10 (expected: true): " + SS(new int[]{2, 3, 6, 8}, 11, 0, 0));

    }
}
