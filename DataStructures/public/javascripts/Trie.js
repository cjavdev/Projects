var Trie = function() {
  this._dictionary = {};
  this._emptyString = "";
  this._dictionary[this._emptyString] = {};
};

Trie.prototype.add = function(word) {
  var that = this;
  letters = word.split("");
  var current = this._dictionary[this._emptyString];
  letters.forEach(function(letter) {
    if(!current[letter]) {
      current[letter] = {};
    }
    current = current[letter];
  });
  current['eow'] = true;
  console.log(this._dictionary);
};

Trie.prototype.remove = function(word) {
  var that = this;
  letters = word.split("");
  var current = this._dictionary[this._emptyString];
  var branch = this._dictionary[this._emptyString];
  letters.forEach(function(letter) {
    if(Object.keys(current).length > 1) {
      (function(current) {
        branch = current;
        branch_letter = letter;
      })(current);
    }
    console.log("first");
    console.log(branch);
    current = current[letter];
    console.log("second");
    console.log(branch);
  });
  console.log("ultimate");
  console.log(branch);
  delete branch[branch_letter];
};

Trie.prototype.contains = function(word) {
  var that = this;
  var current = this._dictionary[this._emptyString];
  word.split("").forEach(function(letter) {
    if(!current[letter]) {
      return false;
    }
    current = current[letter];
  });
  return true;
};
