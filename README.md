# cs429-mastery-assignment
# Please uninstall all AI tooling before beginning.
# You MUST Answer the following questions:

Your answers should be execedingly short. It is most efficient to answer the questions while you work. 

**Git**:
1. Paste exactly the output of `git remote -v`

**Makefile**:
1. What target compiles `orderlogs` with sufficient debug flags
2. Which target verifies your output is identical to the given reference?

**Linux CLI**:
1. At least one testcase in the testcases file fails, paste a full, single  command that runs a failing testcase:

**GDB**:
1. When running a failing testcase, give a line where the program segfault at in its given state. Paste the line.
2. What is the call stack when the program segfaults in its given state? Paste the call stack output by GDB.
3. After fixing this first issue, the program may segfault in a different place. If this is the case, paste that line and the corresponding callstack as well.

**C**:
1. Give a logic error that caused the program to segfault. Note, "dereferencing null" is not sufficient.
2. Directly following this bug, how did you resolve the error?
3. After fixing this first issue, the program may have another logic error that causes a segfault. If this is the case, explain the error and how you resolved it as well.

## [IMPORTANT] After you SSH into a lab machine: Note that
- **ALL git commands must be in the command line.**
- **ALL gdb debugging must be in the command line.**
- **ALL file system actions (eg. creating a file, navigating a file, etc) must be in the command line**

You are allowed to utilize the terminal of your choice for these actions, but they must be accomplished in-terminal.

*Note: SSHing and opening *this* repo via VS Code or another GUI is acceptable provided that the above actions are then accomplished via a terminal therein.*

# What this repo contains:
- `reorder.c` and its corresponding header files, and precompiled .o files in bin/.
- A Makefile
- Some testcases in the `testcases` folder
- a reference executable called `ref_order`

# What this code does:
The given code takes in an arbitrary number of lines of the format `C x` where `C` is either 'S' or 'N' and `x` is some integer.
The first k lines will start only with 'S', the remaining n - k lines will start with 'N'. The idea is to merge, by interleaving,
some old, stable information marked as 'S' with some new information marked with 'N'; the new information comes in reverse order. 
Therefore, to merge this information, we must reverse the new part, then merge the stable section with the now reversed new section.
This logic is done in `reorder.c`; however, this implementation may not be correct and it is up to you to fix it. You may assume
that the given object files are functional.
Some examples of reversing and interleaving are provided at the bottom of the readme. 


# Instructions:
1. ssh into your favorite UTCS lab machine
2. Clone this repository
3. Read then use the Makefile
4. Debug the test cases using gdb; you must use gdb to pass this assessment.
5. To the best of your ability, ensure your output matches the reference exactly.
6. Write the outputs of the `history` command to a file in this repo called `shell_logs.txt`
7. Commit and push your changes. Do not forget to add `shell_logs.txt` to git.
8. Delete your local copy of this repository (you will need to use the r and f flags). If this results in any errors, please notify your proctor before leaving the room.
9. Please do not leave before your proctors tell you to do so. 

reordering examples:

in1: 
```
S 1
S 2
S 3
N 4
N 5
N 6
```
out1:
```
S 1
N 6
S 2
N 5
S 3
N 4
```
explanation: S list:  `1 -> 2 -> 3`, N list: `6 -> 5 -> 4`. Merged List: `1 -> 6 -> 2 -> 5 -> 3 -> 4`.

in2:
```
S 6
N 1
N 3
```
out2:
```
S 6
N 3
N 1
```
explanation: S list:  `6`, N list: `3 -> 1`. Merged List: `6 -> 3 -> 1`.

Notice that we take one element from S an one element from N until there are no more element pairs,
then append the remainder. Use the reference output for any clarifications needed.



