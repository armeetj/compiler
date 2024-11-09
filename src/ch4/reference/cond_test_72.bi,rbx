(X86Program
  (Info2
    (locals_types (($tmp.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((RegL Rsp) ((VarL $tmp.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Var $tmp.1) (Reg Rax))
       (Addq (Imm 1) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 41) (Var $tmp.1))
       (Jmp (Label block_1)))))))
