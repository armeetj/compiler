(X86Program
  (Info2
    (locals_types ())
    (conflicts
      (((RegL Rsp) ((RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 20) (Reg Rax))
       (Addq (Imm 22) (Reg Rax))
       (Jmp (Label conclusion)))))))
