(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp)))
          ((VarL $tmp.2) ((RegL Rdi)))
          ((VarL give_me_add1) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1) (VarL give_me_add1)))
          ((RegL Rax)
           ((RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((RegL Rax)))
          ((RegL Rdx) ((RegL Rax)))
          ((RegL Rsi) ((RegL Rax)))
          ((RegL Rdi) ((VarL $tmp.2) (RegL Rax)))
          ((RegL R8) ((RegL Rax)))
          ((RegL R9) ((RegL Rax)))
          ((RegL R10) ((RegL Rax)))
          ((RegL R11) ((RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1
           (Function
             ()
             (Function (Integer) Integer)))
         ($tmp.2 (Function (Integer) Integer))
         (give_me_add1
           (Function
             ()
             (Function (Integer) Integer)))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label give_me_add1))
               (Var $tmp.1))
             (IndirectCallq (Var $tmp.1) 0)
             (Movq (Reg Rax) (Var $tmp.2))
             (Movq (Imm 41) (Reg Rdi))
             (TailJmp (Var $tmp.2) 1))))))))
   (Def
     (Label add1)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label add1_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Addq (Imm 1) (Reg Rax))
             (Jmp (Label add1_conclusion)))))))))
   (Def
     (Label give_me_add1)
     (Finfo2
       (conflicts
         (((VarL add1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL add1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 0)
      (locals
        ((add1 (Function (Integer) Integer))))
      (body
        (((Label give_me_add1_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label add1))
               (Reg Rax))
             (Jmp (Label give_me_add1_conclusion)))))))))))
