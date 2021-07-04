Notes taken from <https://www.youtube.com/watch?v=zuegQmMdy8M>

Pointers    - variables that store address of another variable

### Basic Syntax

```c
    int x;      - // Declare a variable x to be an integer
                  // x has its own address in memory
                  // value should be integer
    int *p;     - // p is a pointer, a pointer to an integer
                  // p has its own address in memory
                  // value should be the address of an integer variable
    p = &x;     - // Assign x's address to p's value
    x = 5;      - // Assign 5 to x'value
    printf(p);  - // Print p's value i.e. x's address
    printf(&x); - // Print x's address i.e. p's value
    printf(&p); - // Print p's address
    printf(*p); - // Print p's dereferecing i.e. x's value
    *p = 8;     - // Assign 8 to p's dereferencing i.e. x's valuge
```

|Address    |Variable|Value      |
|-----------|--------|-----------|
|`p` or `&x`|`x`     |`x` or `*p`|
|`&p`       |`p`     |`&x`       |
