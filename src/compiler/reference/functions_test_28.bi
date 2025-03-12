(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rdi)))
          ((VarL id) ((RegL Rsp)))
          ((RegL Rsp) ((VarL id)))
          ((RegL Rdi) ((VarL $tmp.1))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         (id (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label id))
               (Var $tmp.1))
             (Movq (Imm 0) (Reg Rdi))
             (TailJmp (Var $tmp.1) 1))))))))
   (Def
     (Label id)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL x.1) (RegL Rax) (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rflags) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label id_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label id_conclusion)))))
         ((Label id_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Cmpq (Imm 0) (Var x.1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))))
