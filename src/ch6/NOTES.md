# Notes

## Ltup -> Lalloc (`expose_allocation`)

### overview

- New forms: Vec, VecLen, VecRef, VecSet
- Vec replaced by Collect, Allocate, GlobalVal (3 new forms), goal: reduce vector creation to lower level
- Collect (n:int) : runs gc to make sure n bytes are available
- Allocate (n:int) (ty) : allocates memory for a vector with n elements with vector type ty
- GlobalVal (v:var) : reads global variable v (this could be a GC param from runtime.c)

### transformation

(vector e_0 ... e_n-1) with type

1) first transform all vector contents
    let (x_0 e_0) ... let (x_n-1 e_n-1)
    >> we make new variables x_0 x_1 ... to correspond to the transformed expressions e_0 e_1 ...
2) then check if there is enough space
   - if there is space -> (void)
   - if no space -> (collect nbytes) which also returns void
3) (let (v (allocate len type)) ...)
    allocate space for the vector
    there should be space now, bc of 2)
4) (let (_ (vector-set! v 0 x_0)))...
    set all vector slots to default value of 0
5) then set all slots values
6) return vector v

## heap memory

- fromspace_end : marks end of program's current heap memory
- free_ptr : marks end of memory currently in use by program
- free_ptr < fromspace_end
  - as long as we can fit a new vector in the space between the two, no GC needed
  - if not enough space, trigger GC
