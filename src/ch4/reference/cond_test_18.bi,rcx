(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL $tmp.2) ((RegL Rsp) (RegL Rax)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (RegL Rax)
         (RegL Rflags)))
       ((RegL Rax) ((VarL $tmp.2) (RegL Rsp)))
       ((RegL Rflags) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 2) (Reg Rax))
       (Addq (Var $tmp.2) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 40) (Var $tmp.2))
       (Jmp (Label block_1)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Movq (Imm 444) (Var $tmp.2))
       (Jmp (Label block_1)))))
   ((Label block_4)
    (Block
      Binfo1
      ((Movq (Imm 777) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_5)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var $tmp.1))
       (Addq (Imm 1) (Var $tmp.1))
       (Cmpq (Imm 2) (Var $tmp.1))
       (JmpIf CC_e (Label block_2))
       (Jmp (Label block_3)))))
   ((Label start)
    (Block
      Binfo1
      ((Cmpq (Imm 0) (Imm 1))
       (JmpIf CC_e (Label block_4))
       (Jmp (Label block_5)))))))
