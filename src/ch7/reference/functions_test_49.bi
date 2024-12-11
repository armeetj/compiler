(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp)))
          ((VarL $tmp.2) ((RegL Rsp)))
          ((VarL $tmp.3) ((VarL $tmp.5)))
          ((VarL $tmp.4) ((VarL $tmp.5)))
          ((VarL $tmp.5)
           ((VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL apply_1) ((RegL Rsp)))
          ((VarL g) ((RegL Rsp)))
          ((VarL h) ((RegL Rsp)))
          ((VarL k) ((RegL Rsp)))
          ((VarL l) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL apply_1)
            (VarL g)
            (VarL h)
            (VarL k)
            (VarL l)))
          ((RegL Rax)
           ((VarL $tmp.5)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((VarL $tmp.5) (RegL Rax)))
          ((RegL Rdx) ((VarL $tmp.5) (RegL Rax)))
          ((RegL Rsi) ((VarL $tmp.5) (RegL Rax)))
          ((RegL Rdi) ((VarL $tmp.5) (RegL Rax)))
          ((RegL R8) ((VarL $tmp.5) (RegL Rax)))
          ((RegL R9) ((VarL $tmp.5) (RegL Rax)))
          ((RegL R10) ((VarL $tmp.5) (RegL Rax)))
          ((RegL R11) ((VarL $tmp.5) (RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function () Boolean))
         ($tmp.2 (Function () Integer))
         ($tmp.3 (Function () Integer))
         ($tmp.4 Integer)
         ($tmp.5 (Function (Integer) Integer))
         (apply_1 Boolean)
         (g (Function () Boolean))
         (h (Function () Integer))
         (k (Function () Integer))
         (l (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label h))
               (Var $tmp.2))
             (TailJmp (Var $tmp.2) 0))))
         ((Label block_2)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label l))
               (Var $tmp.5))
             (Leaq
               (GlobalArg (Label k))
               (Var $tmp.3))
             (IndirectCallq (Var $tmp.3) 0)
             (Movq (Reg Rax) (Var $tmp.4))
             (Movq (Var $tmp.4) (Reg Rdi))
             (TailJmp (Var $tmp.5) 1))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label g))
               (Var $tmp.1))
             (IndirectCallq (Var $tmp.1) 0)
             (Movq (Reg Rax) (Var apply_1))
             (Cmpq (Imm 1) (Var apply_1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))
   (Def
     (Label g)
     (Finfo2
       (conflicts
         (((RegL Rsp) ((RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 0)
      (locals ())
      (body
        (((Label g_start)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label g_conclusion)))))))))
   (Def
     (Label h)
     (Finfo2
       (conflicts
         (((RegL Rsp) ((RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 0)
      (locals ())
      (body
        (((Label h_start)
          (Block
            Binfo1
            ((Movq (Imm 777) (Reg Rax))
             (Jmp (Label h_conclusion)))))))))
   (Def
     (Label k)
     (Finfo2
       (conflicts
         (((RegL Rsp) ((RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 0)
      (locals ())
      (body
        (((Label k_start)
          (Block
            Binfo1
            ((Movq (Imm 41) (Reg Rax))
             (Jmp (Label k_conclusion)))))))))
   (Def
     (Label l)
     (Finfo2
       (conflicts
         (((VarL y.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL y.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((y.1 Integer) (y.1 Integer)))
      (body
        (((Label l_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var y.1))
             (Movq (Var y.1) (Reg Rax))
             (Addq (Imm 1) (Reg Rax))
             (Jmp (Label l_conclusion)))))))))))
