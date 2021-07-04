Notes taken from <https://www.youtube.com/watch?v=zuegQmMdy8M>

Pointers    - variables that store address of another variable

### Basic Syntax

    int x;      - Declare a variable x to be an integer
                  x has its own address in memory
    int *p;     - p is a pointer, a pointer to an integer
                  p has its own address in memory
    p = &x;     - Assign x's address to p's value
    printf(p);  - p's value i.e. x's address
    printf(&x); - x' address i.e. p's value
    print(&p);  - p's address
    print(*p);  - p's dereferecing i.e. x's value
