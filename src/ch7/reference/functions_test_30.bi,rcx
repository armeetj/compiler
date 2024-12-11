(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1)
           ((VarL $tmp.3) (RegL Rdi)))
          ((VarL $tmp.2) ((VarL $tmp.3)))
          ((VarL $tmp.3)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL id) ((RegL Rsp)))
          ((VarL id2) ((RegL Rsp)))
          ((RegL Rsp) ((VarL id) (VarL id2)))
          ((RegL Rax)
           ((VarL $tmp.3)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((VarL $tmp.3) (RegL Rax)))
          ((RegL Rdx) ((VarL $tmp.3) (RegL Rax)))
          ((RegL Rsi) ((VarL $tmp.3) (RegL Rax)))
          ((RegL Rdi)
           ((VarL $tmp.1) (VarL $tmp.3) (RegL Rax)))
          ((RegL R8) ((VarL $tmp.3) (RegL Rax)))
          ((RegL R9) ((VarL $tmp.3) (RegL Rax)))
          ((RegL R10) ((VarL $tmp.3) (RegL Rax)))
          ((RegL R11) ((VarL $tmp.3) (RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         ($tmp.3 (Function (Integer) Integer))
         (id (Function (Integer) Integer))
         (id2 (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label id2))
               (Var $tmp.3))
             (Leaq
               (GlobalArg (Label id))
               (Var $tmp.1))
             (Movq (Imm 42) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var $tmp.2))
             (Movq (Var $tmp.2) (Reg Rdi))
             (TailJmp (Var $tmp.3) 1))))))))
   (Def
     (Label id)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label id_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Jmp (Label id_conclusion)))))))))
   (Def
     (Label id2)
     (Finfo2
       (conflicts
         (((VarL y.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL y.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((y.1 Integer) (y.1 Integer)))
      (body
        (((Label id2_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var y.1))
             (Movq (Var y.1) (Reg Rax))
             (Jmp (Label id2_conclusion)))))))))))
