(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1) (VarL x.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 10) (Var $tmp.1))
       (Negq (Var $tmp.1))
       (Movq (Var $tmp.1) (Var x.1))
       (Addq (Imm 11) (Var x.1))
       (Movq (Var x.1) (Reg Rax))
       (Addq (Imm 41) (Reg Rax))
       (Jmp (Label conclusion)))))))
