% Seminar 2 ex 4

% in case of a BST, inorder traversal returns numbers in non decreasing order


declare
proc {Inorder X}
   if {Number.is X} then {Browse X} end
   if X.left \= nil then {Inorder X.left} end
   if X \= nil then
      if X.root \= nil then {Browse X.root} end
      if X.right \= nil then {Inorder X.right} end
   end
end

%i. Insertion of a node in a Binary Search Tree

% Check the value to be inserted - say X with the value of the current node
% X < val - left subtree
% else - right subtree

% build a Binary Search Tree with values of root and left/right node
declare
fun {BuildTree  Root X}
   if X =< Root then node(left: X right: nil root: Root)
   else node(left: nil right: X root: Root)
   end
end

declare
fun {Insert Bst X}
	   if Bst == nil then node(left: nil right: nil root: X)
	   % our Binary Search Tree might actually be a number at first (the value of the root)
	   elseif {Number.is Bst} then {BuildTree Bst X}
	   elseif X < Bst.root then node(left: {Insert Bst.left X} right: Bst.right root:Bst.root)
	   else node(left: Bst.left right: {Insert Bst.right X} root: Bst.root)
	   end
end

% ii. Smallest element in BST (leftmost element which is a node value)

declare
fun {GetSmallest Bst}
   if Bst == nil then nil
   elseif {Number.is Bst} then Bst
   elseif Bst.left == nil then Bst.root else {GetSmallest Bst.left}
   end
end

% iii. Biggest element in BST (rightmost element which is a node value)
declare
fun {GetBiggest Bst}
   if Bst == nil then nil
   elseif {Number.is Bst} then Bst
   elseif Bst.right == nil then Bst.root else {GetBiggest Bst.right}
   end
end

% iv. Check if the tree has the sortedness property
%1.  current node is null = true
%2.  max left >= root - false
%3.  min right >= root - false
%4.  this but recursively
% else true


declare
fun {CheckSortedness Bst}
   if Bst == nil then true
   elseif {Number.is Bst} then true
   elseif {And Bst.left == nil Bst.right == nil} then true
      elseif {Or Bst.left == nil Bst.right == nil} then false
   elseif {GetBiggest Bst.left} >= Bst.root then false
      elseif {GetSmallest Bst.right} =< Bst.root then false
   else {And {CheckSortedness Bst.left} {CheckSortedness Bst.right}}
   end
end



declare
Root = node(left:X1 right:X2 root:10)
X1 = node(left:X3 right:X4 root:7)
X2 = node(left:X5 right:X6 root:13)
X3 = node(left:nil right:nil root:3)
X4 = node(left:nil right:nil root:9)
X5 = node(left:nil right:nil root:12)
X6 = node(left:nil right:nil root:14)



{Browse {Insert Root 11}}


{Inorder Root}

% i.
{Inorder {Insert Root 11}}
{Inorder {Insert nil 13}}

{Browse {BuildTree 4 7}}
{Inorder {BuildTree 4 7}}
{Inorder {Insert 4 7}}
{Browse  {Insert 4 7}}
{Browse  {Insert 7 4}}

% ii.
{Browse {GetSmallest Root}}
{Browse {GetSmallest nil}}
{Browse {GetSmallest 5}}

% iii.
{Browse {GetBiggest Root}}
{Browse {GetBiggest {Insert Root 45}}}
{Browse {GetBiggest nil}}
{Browse {GetBiggest 6}}

% iv.
{Browse {CheckSortedness Root}}
{Browse {CheckSortedness node(root: 1 left: 3 right: 0)}}
{Browse {CheckSortedness nil}}
{Browse {CheckSortedness 4}}
{Browse {CheckSortedness node(root:7 left: node(root: 6 left:nil right: 9) right:10)}}
{Browse {CheckSortedness node(root:7 left: node(root: 5 left:nil right: 6) right:10)}}
{Browse node(root:7 left: node(root: 5 left:4 right: 6) right:10)}
{Browse {CheckSortedness node(left: node(left: node(root:4 right: nil left:nil)  right: node(root:6 left:nil right: nil) root:5) root: 7 right:10)}}
{Inorder node(left: node(left: node(root:4 right: nil left:nil)  right: node(root:6 left:nil right: nil) root:5) root: 7 right:10)}