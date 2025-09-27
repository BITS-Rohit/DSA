//public class example {
//    public static void main(String[] args) {
//        int[] arr = {12,3,0,2,0,10};
//        System.out.println(Arrays.toString(sortZeroOrder(arr)));
//    }
//
//    static int[] sortZeroOrder(int[] arr) {
//        // Space complexity : O(n);
//        // TIme complexity :O(n+n/2  ) = 1.5n = O(n)
//        int[] nums = new int[arr.length];
//        int j = 0 ;
//        int idx=0;
//        for (int i = 0; i < arr.length; i++) {
//            if (arr[i]==0) j++;
//            else nums[idx++]=arr[i];
//        }
//        for (int i = 0; i < j; i++) {
//            arr[idx++]=0;
//        }
//        return nums;
//    }

import java.util.Arrays;

//    static int[] sortInplace(int[] nums){
//        for (int i = 0; i < nums.length; i++) {
//            if ()
//        }
//    }
//}


class sol {
    int[] fun(int[] a) { //  [ 2 , 33 , 4 ,0 , 8 , 99, 34, 56 ]
//        System.out.println(Arrays.toString(a));
//        System.out.println("-------");
        // Key -> n/2  is mid , also n/2 is on the left side added
        // so left is 0 -> n/2
        // right is n/2 + 1 -> n

        // 0 -1 0 -1 0 -1
        // 0  1 2  3 4  5

        // int x =0
        // x-- x = -1
        // x++ x = 0

        // boolean flag based

        // 000000 , 0001
        int[] arr = new int[a.length];
        int mid = a.length / 2;
        boolean flag = false;
        for (int i = 0; i <= mid; i++) {
            if (flag) arr[i] = -1;  // print -1 only when true
            else arr[i] = 0;   // print 0 only when false
            flag = !flag;
        }
//        System.out.println(Arrays.toString(arr));

        // reverse
        int j = a.length-1;
        for(int i =mid+1; i< arr.length; i++)arr[i]= a[j--];
//        System.out.println(" _____________  ");
        return arr;
    }

    public static void main(String[] args) {
        sol s = new sol();
        System.out.println(Arrays.toString(s.fun(new int[]{2, 33, 4, 0, 8, 99, 34, 56})));
    }
}
