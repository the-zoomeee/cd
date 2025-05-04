# cd

## windows commands
1) for lex file
   ```
   flex file_name.l
   gcc lex.yy.c -o output
   output.exe
   ```

2) for both lex and yacc file
   ```
   flex file_name1.l
   bison -d file_name2.y
   gcc lex.yy.c file_name.tab.c -o output
   output.exe
   ```
   run with input file
   ```
   output.exe input_file.txt
   ```
3) for java
   ```
   javac file_name.java
   java file_name
   ```

## linux commands
1) for lex file
   ```
   flex file_name.l
   gcc lex.yy.c -o output -lfl
   ./output
   ```

2) for both lex and yacc file
   ```
   flex file_name1.l
   bison -d file_name2.y
   gcc lex.yy.c file_name.tab.c -o output -lfl
   ./output
   ```
   run with input file
   ```
   ./output < input_file.txt
   ```
4) for java
   ```
   javac file_name.java
   java file_name
   ```
