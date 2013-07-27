describe("Trie", function() {
	var trie;
	
	beforeEach(function() {
		trie = new Trie();
	});
	
	it("should be able to add a string", function() {
		trie.add("test");
    trie.add("tea");
    trie.remove("tea");
	});
});
