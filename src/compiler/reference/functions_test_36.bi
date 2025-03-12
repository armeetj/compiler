(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rdi)))
          ((VarL uhoh) ((RegL Rsp)))
          ((RegL Rsp) ((VarL uhoh)))
          ((RegL Rdi) ((VarL $tmp.1))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         (uhoh (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label uhoh))
               (Var $tmp.1))
             (Movq (Imm 42) (Reg Rdi))
             (TailJmp (Var $tmp.1) 1))))))))
   (Def
     (Label uhoh)
     (Finfo2
       (conflicts
         (((VarL $tmp.2) ((VarL x.1) (RegL Rdi)))
          ((VarL uhoh) ((RegL Rsp)))
          ((VarL x.1)
           ((VarL $tmp.2) (RegL Rsp) (RegL Rflags)))
          ((RegL Rsp)
           ((VarL uhoh)
            (VarL x.1)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.2)))
          ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         ($tmp.2 (Function (Integer) Integer))
         (uhoh (Function (Integer) Integer))
         (x.1 Integer)))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label uhoh))
               (Var $tmp.2))
             (Movq (Var x.1) (Reg Rdi))
             (TailJmp (Var $tmp.2) 1))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Var x.1) (Reg Rax))
             (Jmp (Label uhoh_conclusion)))))
         ((Label uhoh_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Cmpq (Imm 0) (Var x.1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))))
