(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       (i.1 Integer)
       (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((VarL i.1) (RegL Rsp)))
       ((VarL i.1)
        ((VarL $tmp.1)
         (VarL x.1)
         (RegL Rsp)
         (RegL Rflags)))
       ((VarL x.1)
        ((VarL i.1) (RegL Rsp) (RegL Rflags)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL i.1)
         (VarL x.1)
         (RegL Rax)
         (RegL Rflags)))
       ((RegL Rax) ((RegL Rsp)))
       ((RegL Rflags)
        ((VarL i.1) (VarL x.1) (RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 42) (Var x.1))
       (Jmp (Label loop_1)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Var x.1) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Cmpq (Imm 0) (Var i.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))
   ((Label block_4)
    (Block
      Binfo1
      ((Cmpq (Imm 1) (Var i.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))
   ((Label loop_1)
    (Block
      Binfo1
      ((Movq (Var x.1) (Var $tmp.1))
       (Cmpq (Imm 1) (Var $tmp.1))
       (JmpIf CC_e (Label block_3))
       (Jmp (Label block_4)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var x.1))
       (Movq (Imm 0) (Var i.1))
       (Jmp (Label loop_1)))))))
