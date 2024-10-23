(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL $tmp.2) ((RegL Rsp) (RegL Rax)))
       ((RegL Rsp)
        ((VarL $tmp.1) (VarL $tmp.2) (RegL Rax)))
       ((RegL Rax) ((VarL $tmp.2) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 7) (Var $tmp.1))
       (Addq (Imm 3) (Var $tmp.1))
       (Movq (Var $tmp.1) (Var $tmp.2))
       (Negq (Var $tmp.2))
       (Movq (Imm 52) (Reg Rax))
       (Addq (Var $tmp.2) (Reg Rax))
       (Jmp (Label conclusion)))))))
