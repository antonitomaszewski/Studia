function Node(tleft, tright, tvalue) {
  return {
    value: tvalue,
    left: tleft,
    right: tright,
    [Symbol.iterator]: function*() {
      function* it(tree) {
        if (tree != null) {
          yield* it(tree.left);
          yield tree.value;
          yield* it(tree.right);
        }
      }
      yield* it(this);
    }

  };
}

A = new Node(null, null, 1);
B = new Node(null, null, 10);
C = new Node(A, B, 5);

E = null;
F = new Node(null, null, 20);
G = new Node(E, F, 15);

H = new Node(C, G, 13);

var root = H;
for (var e of root) {
  console.log(e);
}