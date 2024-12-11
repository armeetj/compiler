(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1)
           ((VarL y.1) (RegL Rsp) (RegL Rdi)))
          ((VarL f) ((RegL Rsp)))
          ((VarL y.1)
           ((VarL $tmp.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL f)
            (VarL y.1)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rax) ((VarL y.1) (RegL Rsp)))
          ((RegL Rcx) ((VarL y.1) (RegL Rsp)))
          ((RegL Rdx) ((VarL y.1) (RegL Rsp)))
          ((RegL Rsi) ((VarL y.1) (RegL Rsp)))
          ((RegL Rdi)
           ((VarL $tmp.1) (VarL y.1) (RegL Rsp)))
          ((RegL R8) ((VarL y.1) (RegL Rsp)))
          ((RegL R9) ((VarL y.1) (RegL Rsp)))
          ((RegL R10) ((VarL y.1) (RegL Rsp)))
          ((RegL R11) ((VarL y.1) (RegL Rsp))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Unit))
         (f (Function (Integer) Unit))
         (y.1 Integer)))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Movq (Imm 42) (Var y.1))
             (Leaq
               (GlobalArg (Label f))
               (Var $tmp.1))
             (Movq (Var y.1) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Var y.1) (Reg Rax))
             (Jmp (Label main_conclusion)))))))))
   (Def
     (Label f)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label f_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Imm 0) (Var x.1))
             (Movq (Imm 0) (Reg Rax))
             (Jmp (Label f_conclusion)))))))))))
