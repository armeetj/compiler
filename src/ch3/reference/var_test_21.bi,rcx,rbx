(X86Program
  (Info2
    (locals_types
      ((x.1 Integer)
       (z.1 Integer)
       (y.1 Integer)
       ($tmp.1 Integer)))
    (conflicts
      (((VarL $tmp.1)
        ((VarL z.1) (RegL Rsp) (RegL Rax)))
       ((VarL x.1) ((RegL Rsp)))
       ((VarL y.1) ((VarL z.1) (RegL Rsp)))
       ((VarL z.1)
        ((VarL $tmp.1) (VarL y.1) (RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL x.1)
         (VarL y.1)
         (VarL z.1)
         (RegL Rax)))
       ((RegL Rax) ((VarL $tmp.1) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 30) (Var x.1))
       (Movq (Var x.1) (Var z.1))
       (Addq (Imm 14) (Var z.1))
       (Movq (Imm 2) (Var y.1))
       (Movq (Var y.1) (Var $tmp.1))
       (Negq (Var $tmp.1))
       (Movq (Var z.1) (Reg Rax))
       (Addq (Var $tmp.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
