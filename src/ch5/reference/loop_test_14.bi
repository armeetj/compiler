(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL x.1)
         (RegL Rax)
         (RegL Rflags)))
       ((RegL Rax) ((RegL Rsp)))
       ((RegL Rflags) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 42) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 0) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var x.1))
       (Movq (Imm 2) (Var x.1))
       (Movq (Var x.1) (Var $tmp.1))
       (Cmpq (Imm 2) (Var $tmp.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))))
