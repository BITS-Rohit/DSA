package Code;

import java.util.*;

public class GCode {
    static class Node {
        int data;
        Node next;

        Node(int key) {
            data = key;
            next = null;
        }
    }

    Node removeDuplicates(Node head) {
        if (head.next == null) return head;
        return head;
    }

    public static ArrayList<Integer> duplicates(int[] arr) {
        if (arr.length == 1) return new ArrayList<>(List.of(arr[0]));
        Set<Integer> set = new HashSet<>(arr.length);
        ArrayList<Integer> list = new ArrayList<>(arr.length);
        for (int n : arr) {
            if (!set.add(n)) list.add(n);
        }
        Arrays.sort(new ArrayList[]{list});
        return list.isEmpty() ? new ArrayList<>(List.of(-1)) : list;
    }

    static int isNarcissistic(int N) {
        int numDigits = countDigits(N);
        return nar(N, 0, numDigits) == N ? 1 : 0;
    }

    private static int nar(int N, int Sum, int power) {
        if (N == 0) return Sum;
        int n = N % 10;
        Sum += (int) Math.pow(n, power);
        return nar(N / 10, Sum, power);
    }

    private static int countDigits(int N) {
        return (int) Math.log10(N) + 1;
    }

    public void printNos(int N) {
        if (N > 1) {
            printNos(N - 1);
            System.out.println(N);
        }
    }

    static void printTillN(int N) {
        if (N > 1) {
            printTillN(N - 1);
            System.out.print(N + " ");
        }
    }

    static int sumOfDigits(int N) {
        return sum(N, 0);
    }

    private static int sum(int N, int sum) {
        if (N % 10 == 0) return sum;
        sum += N % 10;
        return sum(N / 10, sum);
    }

    int getMiddle(Node head) {
        if (head == null) return -1;
        Node slow = head;
        Node fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        return slow.data;
    }

    Node reverseList(Node head) {
        if (head.next == null) return head;
        Node current = head;
        Node prev = null;
        Node temp;
        while (current != null) {
            temp = current.next;
            current.next = prev;
            prev = current;
            current = temp;
        }
        return prev;
    }

    int getKthFromLast(Node head, int k) {
        int len = 0;
        Node c1 = head;
        Node c2 = head;
        while (c2 != null) {
            if (len < k) len++;
            else break;
            c2 = c2.next;
        }
        if (len != k) return -1;
        else {
            while (c2 != null) {
                c1 = c1.next;
                c2 = c2.next;
            }
            return c1.data;
        }
    }

    Node insertAtEnd(Node head, int x) {
        Node n = new Node(x);
        if (head == null) head = n;
        Node current = head;
        while (current.next != null) {
            current = current.next;
        }
        current.next = n;
        return head;
    }

    int missingNumber(int n, int[] arr) {
        Arrays.sort(arr);
        int idx = 1;
        for (int a : arr) {
            if (a == idx) idx++;
            else return idx;
        }
        return -1;
    }

    public int GetNth(Node head, int index) {
        int idx = 0;
        Node current = head;
        while (current != null) {
            if (idx + 1 == index) return current.data;
            current = current.next;
            idx++;
        }
        return -1;
    }

    public boolean isLengthEven(Node head) {
        int n = 0;
        Node current = head;
        while (current != null) {
            n++;
            current = current.next;
        }
        return n % 2 == 0;
    }

    //    public int maxLen(int[] arr) {
//        if (arr.length==1)return 0;
//        int min = Integer.MAX_VALUE;
//        for(int i = 0  ; i<arr.length ; i++){
//
//        }
//    }
    static class QQ {
        TreeNode root;
        int depth;
    }

    public TreeNode lcaDeepestLeaves(TreeNode root) {
        Queue<QQ> queue = new LinkedList<>();
        Map<Integer, TreeNode> map = new HashMap<>();  // For maximum
        int max = Integer.MIN_VALUE;
        QQ qq = new QQ();
        qq.root = root;
        qq.depth = 0;
        queue.add(qq);
        while (!queue.isEmpty()) {
            QQ q = queue.poll();
            TreeNode n = q.root;
            int dep = q.depth;
            max = Math.max(max, q.depth);

            boolean l = false, r = false;
            if (n.left != null) {
                QQ left = new QQ();
                left.root = n.left;
                left.depth = q.depth + 1;
                queue.add(left);
            } else l = true;
            if (n.right != null) {
                QQ right = new QQ();
                right.root = n.right;
                right.depth = q.depth + 1;
                queue.add(right);
            } else r = true;

            if (l && r) {
                map.put(max, q.root);
            }
        }
        return map.get(max);
    }

    static class cq {
        TreeNode root;
        int depth;

        cq(TreeNode root, int depth) {
            this.root = root;
            this.depth = depth;
        }
    }

    public boolean isEvenOddTree(TreeNode root) {
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean oe = true;
        int depth = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();

            oe = depth % 2 == 0;
            int last = oe ? Integer.MIN_VALUE : Integer.MAX_VALUE;

            for (int i = 0; i < size; i++) {
                TreeNode n = queue.poll();
                if (oe) { // Strictly Increasing Odd values
                    if (n.val % 2 == 0) return false;
                    if (last < n.val) last = n.val;
                    else return false;

                } else { // Strictly Decreasing is allowed
                    if (n.val % 2 != 0) return false;
                    if (last > n.val) last = n.val;
                    else return false;
                }

                if (n.left != null) queue.add(n.left);
                if (n.right != null) queue.add(n.right);
            }
            depth++;
        }
        return true;
    }

    int[][] dirs = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    public void solve(char[][] board) {
        if (board.length == 0) return;
        int m = board.length, n = board[0].length;
        for (char[] b : board) {
            System.out.println(Arrays.toString(b));
        }
        System.out.println("Actual");

        for (int i = 0; i < m; i++) {
            dfs(board, i, 0);
            dfs(board, i, n - 1);
        }
        for (char[] b : board) {
            System.out.println(Arrays.toString(b));
        }
        System.out.println("Col");
        for (int j = 0; j < n; j++) {
            dfs(board, 0, j);
            dfs(board, m - 1, j);
        }
        for (char[] b : board) {
            System.out.println(Arrays.toString(b));
        }
        System.out.println("Row");

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == 'O') board[i][j] = 'X';
                if (board[i][j] == 'T') board[i][j] = 'O';
            }
        }
    }

    private void dfs(char[][] board, int x, int y) {
        int m = board.length, n = board[0].length;
        if (x < 0 || y < 0 || x >= m || y >= n || board[x][y] != 'O') return;
        board[x][y] = 'T';
        for (int[] d : dirs) dfs(board, x + d[0], y + d[1]);
    }

    public int catchThieves(char[] arr, int k) {
        int i = -1, j = -1;
        for (int x = 0; x < arr.length; x++) {
            if (arr[x] == 'P') i = x;
            if (arr[x] == 'T') j = x;
            if (i != -1 && j != -1) break;
        }

        int caught = 0;

        while (i < arr.length && j < arr.length) {
            if (Math.abs(i - j) <= k) {
                caught++;
                do i++;
                while (i < arr.length && arr[i] != 'P');
                do j++;
                while (j < arr.length && arr[j] != 'T');
            } else if (i < j) {
                do i++;
                while (i < arr.length && arr[i] != 'P');
            } else {
                do j++;
                while (j < arr.length && arr[j] != 'T');
            }
        }

        return caught;
    }

    public double fractionalKnapsack(int[] val, int[] wt, int capacity) {
        Queue<double[]> queue = new PriorityQueue<>(Comparator.comparingDouble(a -> -a[2]));
        for (int i = 0; i < val.length; i++) {
            double frac = (double) val[i] / wt[i];
            double[] n = {(double) val[i], (double) wt[i], frac};
            queue.add(n);
        }
        // Queue constrcuted
        int caps = 0;
        double profit = 0;
        while (caps < capacity && !queue.isEmpty()) {
            double[] n = queue.poll();
            if (n[1] <= capacity - caps) {
                caps += (int) n[1];
                profit += n[0];
            } else {
                int remain = capacity - caps;
                System.out.println(remain);
                profit += n[2] * remain;
            }
        }
        return profit;
    }

    public int maximumBags(int[] capacity, int[] rocks, int additionalRocks) {
        PriorityQueue<int[]> queue = new PriorityQueue<>(Comparator.comparingInt(a -> (a[0] - a[1])));
        for (int i = 0; i < capacity.length; i++) queue.add(new int[]{capacity[i], rocks[i]});

        int n = 0;
        while (!queue.isEmpty() && additionalRocks > 0) {
            int[] pair = queue.poll();
            int needRocks = pair[0] - pair[1];

            if (additionalRocks >= needRocks) {
                n++;
                additionalRocks -= needRocks;
            }
        }

        return n;
    }

    public boolean canCross(int[] stones) {
        return rec(stones, 1, 1, new boolean[stones.length]);
    }

    public boolean rec(int[] stones, int jump, int i, boolean[] dp) {
        if (i == stones.length) return true;
        if (i > stones.length) return false;

        // Stones stepping check
        if (stones[i - 1] + jump != stones[i]) return false;

        if (dp[i]) return true;

        // i is the current Fog index
        boolean c1 = rec(stones, jump - 1, i + 1, dp);
        boolean c2 = rec(stones, jump, i + 1, dp);
        boolean c3 = rec(stones, jump + 1, i + 1, dp);

        return dp[i] = c1 || c2 || c3;
    }

    public int canCompleteCircuit(int[] gas, int[] cost) {
        // We will start with the max cost is.
        // if cost becomes 0 means there is not any asnwer to that.
        // then start checking the next index assuming him as start.

        // struct : [ gas - cost ]
        Queue<int[]> queue = new PriorityQueue<>(Comparator.comparingInt(a -> -a[1]));
        for (int i = 0; i < gas.length; i++) queue.add(new int[]{gas[i], cost[i], i});
        int n = 1;
        int startCost = cost[(queue.peek()[2] - 1) % cost.length];
        int startI = queue.poll()[2] + 1;

        while (!queue.isEmpty() && n < gas.length) {
            int[] pair = queue.poll();
            if (pair[2] - 1 < cost.length && pair[2] - 1 > -1)
                startCost = startCost - cost[pair[2]] + cost[pair[2] - 1];
            if (startCost < 0) return -1;
        }
        return startCost < 0 ? -1 : startI;
    }


    public String largestNumber(int[] nums) {
        String[] arr = Arrays.stream(nums).mapToObj(String::valueOf).toArray(String[]::new);
        Arrays.sort(arr, (a, b) -> (b + a).compareTo(a + b));
        if (arr[0].equals("0")) return "0";
        StringBuilder largestNum = new StringBuilder();
        for (String s : arr) largestNum.append(s);
        return largestNum.toString();
    }

    public String removeDuplicateLetters(String s) {
        int[] letters = new int[26];
        Arrays.fill(letters, -1);
        String max = "";
        int start = -1;

        for (int i = 0; i < s.length(); i++) {
            if (start == -1) start = i;

            int idx = s.charAt(i) - 'a';
            if (letters[idx] == -1) {
                letters[idx] = i;
            } else {
                // Duplicate Found
                int lastI = letters[idx];

                // s1 candidates
                String cand1 = "";
                if (lastI > start && lastI <= s.length()) cand1 = s.substring(start, lastI);

                String cand2 = "";
                if (i > start) cand2 = s.substring(start, i);

                String s1 = cand1.compareTo(cand2) > 0 ? cand1 : cand2;

                // s2 candidates
                String cand3 = "";
                if (lastI < i && lastI >= 0) cand3 = s.substring(lastI, i);

                String cand4 = "";
                if (lastI + 1 <= i && i + 1 <= s.length()) cand4 = s.substring(lastI + 1, i + 1);

                String s2 = cand3.compareTo(cand4) > 0 ? cand3 : cand4;

                // pick maxz
                String s3 = s1.compareTo(s2) > 0 ? s1 : s2;
                max = max.compareTo(s3) > 0 ? max : s3;

                start = i;
                letters[idx] = i;
            }
        }
        return max;
    }

    public int canBeTypedWords(String text, String brokenLetters) {

        int count = 0;
        for (String word : text.split(" ")) {
            boolean valid = true;
            for (char c : word.toCharArray()) {
                if (brokenLetters.contains(String.valueOf(c))) {
                    valid = false;
                    break;
                }
            }
            if (valid) count++;
        }
        return count;
    }



    public static void main(String[] args) {
        GCode g = new GCode();
        System.out.println(g.canBeTypedWords("leet code ", "lt"));
//        System.out.println(g.removeDuplicateLetters("bcabc"));

//        int[] gas = {1, 2, 3, 4, 5};
//        int[] cost = {3, 4, 5, 1, 2};
//        System.out.println(g.canCompleteCircuit(gas, cost));
//        int[] val = {60,100,120};
//        int[] wt = {10,20,30};
//        System.out.println(g.fractionalKnapsack(val, wt, 50));

//        char[][] b = {{'O', 'O', 'O' }, {'O', 'O', 'O' }, {'O', 'O', 'O' }};
////        char[][] b = {{'X', 'X' ,'X','X'}, {'X', 'O','O','X' },{'X', 'X','O','X'},{'X', 'O','X','X'}};
//        g.solve(b);
//        System.out.println(Arrays.deepToString(b));
    }
}
