(X86Program
  (Info2
    (locals_types
      ((x.1 Integer) ($tmp.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((VarL x.1) (RegL Rsp)))
       ((VarL x.1)
        ((VarL $tmp.1) (RegL Rsp) (RegL Rax)))
       ((RegL Rsp)
        ((VarL $tmp.1) (VarL x.1) (RegL Rax)))
       ((RegL Rax) ((VarL x.1) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 14) (Var x.1))
       (Movq (Var x.1) (Var $tmp.1))
       (Addq (Var x.1) (Var $tmp.1))
       (Movq (Var $tmp.1) (Reg Rax))
       (Addq (Var x.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
