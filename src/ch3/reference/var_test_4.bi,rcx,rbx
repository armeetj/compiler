(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)))
    (conflicts
      (((VarL $tmp.1)
        ((VarL $tmp.2) (VarL $tmp.3) (RegL Rsp)))
       ((VarL $tmp.2)
        ((VarL $tmp.1) (VarL $tmp.3) (RegL Rsp)))
       ((VarL $tmp.3)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (VarL $tmp.3)
         (RegL Rax)))
       ((RegL Rax) ((VarL $tmp.3) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 10) (Var $tmp.1))
       (Addq (Imm 11) (Var $tmp.1))
       (Movq (Imm 4) (Var $tmp.2))
       (Negq (Var $tmp.2))
       (Movq (Imm 25) (Var $tmp.3))
       (Addq (Var $tmp.2) (Var $tmp.3))
       (Movq (Var $tmp.1) (Reg Rax))
       (Addq (Var $tmp.3) (Reg Rax))
       (Jmp (Label conclusion)))))))
