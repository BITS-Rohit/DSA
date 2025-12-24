package btech.DSA;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

public class Trie {

    static class Tnode {
        Tnode[] children;
        boolean isend;

        Tnode() {
            children = new Tnode[26];
            Arrays.fill(children, null);
            isend = false;
        }
    }

    static Tnode root = new Tnode();

    void insert(String s) {
        inserthelper(s, 0, root);
    }

    private void inserthelper(String s, int i, Tnode node) {
        if (i < s.length()) {
            int idx = s.charAt(i) - 'a';
            if (node.children[idx] == null) node.children[idx] = new Tnode();

            if (i + 1 == s.length()) node.children[idx].isend = true;
            else inserthelper(s, i + 1, node.children[idx]);
        }
    }

    boolean search(String s) {
        return searchhelper(s, 0, root);
    }

    private boolean searchhelper(String s, int i, Tnode node) {
        if (i == s.length()) return node.isend;

        int idx = s.charAt(i) - 'a';
        if (node.children[idx] == null) return false;

        return searchhelper(s, i + 1, node.children[idx]);
    }
}

class SSolution {

    //---------Trie -------------
    static class Tnode {
        Tnode[] child = new Tnode[26];
        boolean isEnd = false;
        String word = null;
    }

    static class Trie {
        Tnode root = new Tnode();

        void insert(String word) {
            Tnode node = root;
            for (char c : word.toCharArray()) {
                int idx = c - 'a';
                if (node.child[idx] == null) {
                    node.child[idx] = new Tnode();
                }
                node = node.child[idx];
            }
            node.isEnd = true;
            node.word = word;
        }
    }

    public List<String> findWords(char[][] board, String[] words) {
        List<String> result = new ArrayList<>();
        Trie trie = new Trie();

        // Insert all words into Trie
        for (String word : words) {
            trie.insert(word);
        }

        int m = board.length;
        int n = board[0].length;
        boolean[][] visited = new boolean[m][n];


        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (trie.root.child[board[i][j] - 'a'] != null) dfs(board, i, j, trie.root, result, visited);
            }
        }


        return result;
    }

    private void dfs(char[][] board, int i, int j, Tnode node, List<String> result, boolean[][] visited) {

        if (i < 0 || i >= board.length || j < 0 || j >= board[0].length || visited[i][j]) return;

        char c = board[i][j];
        int idx = c - 'a';

        if (node.child[idx] == null) return;

        node = node.child[idx];
        if (node.isEnd) {
            result.add(node.word);
            node.isEnd = false;
        }

        visited[i][j] = true;

        dfs(board, i + 1, j, node, result, visited);
        dfs(board, i - 1, j, node, result, visited);
        dfs(board, i, j + 1, node, result, visited);
        dfs(board, i, j - 1, node, result, visited);

        visited[i][j] = false;
    }
}


class solution {

    static List<String> list;

    static class Tnode {
        Tnode[] child = new Tnode[26];
        boolean isend = false;
    }

    static class Trie {
        Tnode root = new Tnode();
        int mlen = 0;

        void insert(String s) {
            mlen = Math.max(mlen, s.length());
            Tnode node = root;
            for (int i = 0; i < s.length(); i++) {
                int idx = s.charAt(i) - 'a';
                if (node.child[idx] == null) {
                    node.child[idx] = new Tnode();
                }
                node = node.child[idx];
            }
            node.isend = true;
        }

        void search(StringBuilder sb, String s, int i, Tnode node) {
            if (i == s.length()) {
                sb.deleteCharAt(sb.length() - 1);// extra space remove
                list.add(sb.toString());
                return;
            }

            Tnode curr = node;
            for (int j = i; j < Math.min(i + mlen, s.length()); j++) {
                int idx = s.charAt(j) - 'a';
                if (curr.child[idx] == null) break;

                curr = curr.child[idx];

                if (curr.isend) {
                    int len = sb.length();
                    sb.append(s, i, j + 1).append(" ");
                    search(sb, s, j + 1, root);
                    sb.setLength(len);
                }
            }
        }
    }


    public List<String> wordBreak(String s, List<String> wordDict) {
        list = new ArrayList<>();

        Trie t = new Trie();
        for (String x : wordDict) t.insert(x);

        t.search(new StringBuilder(), s, 0, t.root);
        return list;
    }
}

class Solution {
    static class Trie {
        Trie[] child = new Trie[26];
        boolean end = false;
        String word = "";
    }

    int total;
    Trie root;
    int len ;

    void build(String word) {
        Trie node = root;
        for (char c : word.toCharArray()) {
            if (node.child[c-'a'] == null) node.child[c-'a'] = new Trie();
            node = node.child[c-'a'];
        }
        node.end = true;
        node.word = word;
    }

    void search(Trie node, String s, int i) {
        if (node.end) {
            total++;
            System.out.println(node.word);
            node.end = false; // reset
        }

        for (int y = 0; y < 26; y++) {
            if (node.child[y] != null) {
                for (int k = i; k < len; k++) if (s.charAt(k) - 'a' == y) search(node.child[y], s, k + 1);
            }
        }
    }



    public int numMatchingSubseq(String s, String[] words) {
        total = 0;
        len = s.length();
        root = new Trie();
        var set = new HashSet<String>();
        int duplicate = 0 ;
        for(String x : words){
            if (!set.add(x))duplicate++;
            else {
                set.add(x);
                build(x);
            }
        }

        search(root, s, 0);
        return total+duplicate;
    }
}