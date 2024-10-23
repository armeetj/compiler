(X86Program
  (Info2
    (locals_types (($tmp.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((RegL Rsp) ((VarL $tmp.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 30) (Var $tmp.1))
       (Addq (Imm 10) (Var $tmp.1))
       (Movq (Var $tmp.1) (Reg Rax))
       (Addq (Imm 2) (Reg Rax))
       (Jmp (Label conclusion)))))))
