(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL x.1) ((RegL Rsp) (RegL Rflags)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL x.1)
         (RegL Rax)
         (RegL Rflags)))
       ((RegL Rax) ((RegL Rsp)))
       ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 42) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 777) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Cmpq (Imm 42) (Var $tmp.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))
   ((Label block_4)
    (Block
      Binfo1
      ((Movq (Var x.1) (Var $tmp.1))
       (Jmp (Label block_3)))))
   ((Label block_5)
    (Block
      Binfo1
      ((Movq (Imm 20) (Var $tmp.1))
       (Jmp (Label block_3)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 42) (Var x.1))
       (Cmpq (Imm 42) (Var x.1))
       (JmpIf CC_e (Label block_4))
       (Jmp (Label block_5)))))))
