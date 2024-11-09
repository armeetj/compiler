(X86Program
  (Info2
    (locals_types ())
    (conflicts
      (((RegL Rsp) ((RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 42) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block Binfo1 ((Jmp (Label block_2)))))))
