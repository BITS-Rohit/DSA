package btech.class_java.example;





class Solution {
    public long countNoZeroPairs(long n) {
        String s = String.valueOf(n);
        int len = s.length();
        // digits from least significant (pos 0) to most (pos len-1)
        int[] digit = new int[len];
        for (int i = 0; i < len; i++) digit[i] = s.charAt(len - 1 - i) - '0';

        long total = 0;

        // la = number of digits of a (1..len)
        // lb = number of digits of b (1..len)
        for (int la = 1; la <= len; la++) {
            for (int lb = 1; lb <= len; lb++) {
                // dp[pos][carry] = ways to match lower pos digits (pos processed) with given carry
                long[][] dp = new long[len + 1][2];
                dp[0][0] = 1;

                for (int pos = 0; pos < len; pos++) {
                    int need = digit[pos];
                    for (int carry = 0; carry <= 1; carry++) {
                        long ways = dp[pos][carry];
                        if (ways == 0) continue;

                        // digit constraints for this pos given chosen lengths:
                        // if pos < la -> digit of a must be 1..9, else it must be 0 (leading positions)
                        int aMin = (pos < la) ? 1 : 0;
                        int aMax = (pos < la) ? 9 : 0;
                        int bMin = (pos < lb) ? 1 : 0;
                        int bMax = (pos < lb) ? 9 : 0;

                        for (int da = aMin; da <= aMax; da++) {
                            for (int db = bMin; db <= bMax; db++) {
                                int sum = da + db + carry;
                                if (sum % 10 == need) {
                                    dp[pos + 1][sum / 10] += ways;
                                }
                            }
                        }
                    }
                }

                // only valid if final carry == 0
                total += dp[len][0];
            }
        }

        return total;
    }

    // quick main to test
//    public static void main(String[] args) {
//        Solution sol = new Solution();
//        System.out.println(sol.countNoZeroPairs(2));   // 1
//        System.out.println(sol.countNoZeroPairs(3));   // 2
//        System.out.println(sol.countNoZeroPairs(11));  // 8
//        System.out.println(sol.countNoZeroPairs(100)); // 0
//    }
}
