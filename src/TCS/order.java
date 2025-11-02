//package TCS;

import java.util.*;

public class order {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = Integer.parseInt(sc.nextLine().trim());
        sc.nextLine(); // skip "shuffled"
        String[] shuffled = new String[N];
        for (int i = 0; i < N; i++) shuffled[i] = sc.nextLine().trim();
        sc.nextLine(); // skip "original"
        String[] original = new String[N];
        for (int i = 0; i < N; i++) original[i] = sc.nextLine().trim();

        // Map each original instruction to its index
        Map<String, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < N; i++) indexMap.put(original[i], i);

        // Convert shuffled to index mapping
        int[] order = new int[N];
        for (int i = 0; i < N; i++) order[i] = indexMap.get(shuffled[i]);

        // Find longest contiguous increasing subsequence
        int longest = 1, cur = 1;
        for (int i = 1; i < N; i++) {
            if (order[i] > order[i - 1]) cur++;
            else cur = 1;
            longest = Math.max(longest, cur);
        }

        System.out.println(N - longest);
    }
}
