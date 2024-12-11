(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rdi)))
          ((VarL sub1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL sub1)))
          ((RegL Rdi) ((VarL $tmp.1))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         (sub1 (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label sub1))
               (Var $tmp.1))
             (Movq (Imm 43) (Reg Rdi))
             (TailJmp (Var $tmp.1) 1))))))))
   (Def
     (Label sub1)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label sub1_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Subq (Imm 1) (Reg Rax))
             (Jmp (Label sub1_conclusion)))))))))))
