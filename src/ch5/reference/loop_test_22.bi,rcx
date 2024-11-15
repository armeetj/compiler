(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       (i.1 Integer)
       (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((VarL x.1) (RegL Rsp)))
       ((VarL $tmp.2) ((RegL Rsp)))
       ((VarL $tmp.3) ((RegL Rsp)))
       ((VarL i.1) ((VarL x.1) (RegL Rsp)))
       ((VarL x.1)
        ((VarL $tmp.1)
         (VarL i.1)
         (RegL Rsp)
         (RegL Rflags)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (VarL $tmp.3)
         (VarL i.1)
         (VarL x.1)
         (RegL Rax)
         (RegL Rflags)))
       ((RegL Rax) ((RegL Rsp)))
       ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Var x.1) (Var $tmp.2))
       (Movq (Var $tmp.2) (Var x.1))
       (Addq (Imm 1) (Var x.1))
       (Movq (Var x.1) (Var $tmp.3))
       (Movq (Var $tmp.3) (Var i.1))
       (Addq (Imm 1) (Var i.1))
       (Jmp (Label loop_1)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Var x.1) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label loop_1)
    (Block
      Binfo1
      ((Movq (Var i.1) (Var $tmp.1))
       (Cmpq (Imm 0) (Var $tmp.1))
       (JmpIf CC_l (Label block_1))
       (Jmp (Label block_2)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 42) (Var x.1))
       (Movq (Imm 2) (Var i.1))
       (Jmp (Label loop_1)))))))
