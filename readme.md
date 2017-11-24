https://www.hackerrank.com/challenges/simple-text-editor/problem

A few things to keep in mind:
•               We like functional paradigms like having limited side effects, to the extent possible in Ruby
•               Make the code as clean as you would make it if you were submitting it for actual code review while working here (documentation, testing, etc.)
•               That website has some test cases, but they are not complete so please ensure your answer is accurate independently
•               Please include documentation explaining your overall approach
•               It's fine to include standard gems
•               I'm confident that you can create a solution which works – our goal with this challenge is more to understand the way you approach problems rather than to verify you are able to solve this particular one. I would much rather have you take an extra week and submit something clean than do a quick-and-dirty job, so take all the time you need.

**todo**
(((((*))))) change all procs to lambdas https://stackoverflow.com/questions/626/when-to-use-lambda-when-to-use-proc-new
* test input files in test dir
* ** testcode for test-helper
* better error message for sequence errors '1 >= position <= string length' '1 >= count <= string length'  -- what is the string??????
(*) flip all args in assert_equal assert_equal( expected, actual) see http://ruby-doc.org/stdlib-2.0.0/libdoc/test/unit/rdoc/Test/Unit/Assertions.html#method-i-assert_equal
* ************* EditorManager inst methods not pure: Sequencer should pass history to the op_proc, no more EditorManager instance
* combine Editor , EditorManager
* document that unlimited undo does not raise error