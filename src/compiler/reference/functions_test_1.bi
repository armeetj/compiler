(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp) (RegL Rdi)))
          ((VarL $tmp.2) ((RegL Rsp) (RegL Rax)))
          ((VarL id) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL id)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rax)
           ((VarL $tmp.2)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((RegL Rsp) (RegL Rax)))
          ((RegL Rdx) ((RegL Rsp) (RegL Rax)))
          ((RegL Rsi) ((RegL Rsp) (RegL Rax)))
          ((RegL Rdi)
           ((VarL $tmp.1) (RegL Rsp) (RegL Rax)))
          ((RegL R8) ((RegL Rsp) (RegL Rax)))
          ((RegL R9) ((RegL Rsp) (RegL Rax)))
          ((RegL R10) ((RegL Rsp) (RegL Rax)))
          ((RegL R11) ((RegL Rsp) (RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         (id (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label id))
               (Var $tmp.1))
             (Movq (Imm 41) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var $tmp.2))
             (Movq (Imm 1) (Reg Rax))
             (Addq (Var $tmp.2) (Reg Rax))
             (Jmp (Label main_conclusion)))))))))
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
             (Jmp (Label id_conclusion)))))))))))
