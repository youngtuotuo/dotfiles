## Pointers    - variables that store address of another variable

### Basic Syntax

```c
    int x;                  - // Declare a variable x to be an integer.
                              // x has its own address in memory.
                              // x's value should be integer.
    int *p;                 - // p is a pointer, a pointer to an integer.
                              // p has its own address in memory.
                              // p's value should be the address of an integer variable.
    p = &x;                 - // Assign x's address to p's value.
    x = 5;                  - // Assign 5 to x'value.
    printf("p: %p\n", p);   - // Print p's value, i.e. x's address.
    printf("&x: %p\n", &x); - // Print x's address, i.e. p's value.
    printf("&p: %p\n", &p); - // Print p's address.
    printf("*p: %d\n", *p); - // Print p's dereferecing i.e. x's value.
    *p = 8;                 - // Assign 8 to p's dereferencing/indirection i.e. x's value.
```

|Variable|Address    |Value      |
|-------|-----------|-----------|
|`x`    |`p` or `&x`|`x` or `*p`|
|`p`    |`&p`       |`&x`       |

### Arithmetic

```c
    int x;
    int *p;
    p = &x;
    printf("p: %p\n", p);       - // Print p's value, i.e. x's address.
    printf("p+1: %p\n", p+1);   - // Add p's addres one unit(one int's size, i.e. 4 bytes).
    printf("*p: %d\n", *p);     - // Print p's dereferencing, here is 0 because x wasn't assigned any value. We need to take this behavior seriously.
```

### Evironment
#### MacOS Big Sur 11.5.1 M1 chip
    Apple clang version 12.0.5 (clang-1205.0.22.9)
    Target: arm64-apple-darwin20.6.0
    Thread model: posix
    InstalledDir: /Library/Developer/CommandLineTools/usr/bin

#### Ububtu1804 Intel Core i9-9900K 5.4.0-80-generic
    Target: x86_64-linux-gnu
    Thread model: posix
    gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~18.04) 

### References
[Pointers in C/C++ - FreeCodeCamp.org youtube](https://www.youtube.com/watch?v=zuegQmMdy8M&t=8s)
