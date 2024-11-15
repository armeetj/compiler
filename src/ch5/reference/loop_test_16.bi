(X86Program
  (Info2
    (locals_types ((x.1 Integer)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp) ((VarL x.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Var x.1) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var x.1))
       (Movq (Imm 42) (Var x.1))
       (Jmp (Label block_1)))))))
