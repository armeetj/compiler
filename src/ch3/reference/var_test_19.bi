(X86Program
  (Info2
    (locals_types ())
    (conflicts
      (((RegL Rsp) ((RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 52) (Reg Rax))
       (Subq (Imm 10) (Reg Rax))
       (Jmp (Label conclusion)))))))
