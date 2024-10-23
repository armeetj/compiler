(X86Program
  (Info2
    (locals_types (($tmp.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp) (RegL Rax)))
       ((RegL Rsp) ((VarL $tmp.1) (RegL Rax)))
       ((RegL Rax) ((VarL $tmp.1) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 5) (Var $tmp.1))
       (Negq (Var $tmp.1))
       (Movq (Imm 47) (Reg Rax))
       (Subq (Var $tmp.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
