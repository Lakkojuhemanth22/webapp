package utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class JobTrie {
    private TrieNode root;

    public JobTrie() {
        root = new TrieNode();
    }

    // Insert job title into Trie
    public void insert(String jobTitle) {
        TrieNode current = root;
        for (char ch : jobTitle.toLowerCase().toCharArray()) {
            current.children.putIfAbsent(ch, new TrieNode());
            current = current.children.get(ch);
        }
        current.isEndOfWord = true;
    }

    // Search for job titles starting with the given prefix
    public List<String> searchSuggestions(String prefix) {
        List<String> suggestions = new ArrayList<>();
        TrieNode current = root;

        for (char ch : prefix.toLowerCase().toCharArray()) {
            if (!current.children.containsKey(ch)) {
                return suggestions; // No match found
            }
            current = current.children.get(ch);
        }
        findAllWords(current, prefix, suggestions);
        return suggestions;
    }

    // Helper method to find all job titles from a given TrieNode
    private void findAllWords(TrieNode node, String prefix, List<String> suggestions) {
        if (node.isEndOfWord) {
            suggestions.add(prefix);
        }
        for (Map.Entry<Character, TrieNode> entry : node.children.entrySet()) {
            findAllWords(entry.getValue(), prefix + entry.getKey(), suggestions);
        }
    }
}
