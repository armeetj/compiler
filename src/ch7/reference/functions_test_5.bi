(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp) (RegL Rdi)))
          ((VarL $tmp.2) ((RegL Rsp)))
          ((VarL tailrecur) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL tailrecur)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)
            (RegL Rflags)))
          ((RegL Rax)
           ((RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((RegL Rsp) (RegL Rax)))
          ((RegL Rdx) ((RegL Rsp) (RegL Rax)))
          ((RegL Rsi) ((RegL Rsp) (RegL Rax)))
          ((RegL Rdi)
           ((VarL $tmp.1) (RegL Rsp) (RegL Rax)))
          ((RegL R8) ((RegL Rsp) (RegL Rax)))
          ((RegL R9) ((RegL Rsp) (RegL Rax)))
          ((RegL R10) ((RegL Rsp) (RegL Rax)))
          ((RegL R11) ((RegL Rsp) (RegL Rax)))
          ((RegL Rflags) ((RegL Rsp))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         (tailrecur (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 777) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label tailrecur))
               (Var $tmp.1))
             (Movq (Imm 99) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var $tmp.2))
             (Cmpq (Var $tmp.2) (Imm 0))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))
   (Def
     (Label tailrecur)
     (Finfo2
       (conflicts
         (((VarL $tmp.3)
           ((VarL $tmp.4) (VarL $tmp.5) (VarL x.1)))
          ((VarL $tmp.4)
           ((VarL $tmp.3) (VarL $tmp.5)))
          ((VarL $tmp.5)
           ((VarL $tmp.3)
            (VarL $tmp.4)
            (VarL x.1)
            (RegL Rdi)))
          ((VarL tailrecur) ((RegL Rsp)))
          ((VarL x.1)
           ((VarL $tmp.3)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL tailrecur)
            (VarL x.1)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.5)))
          ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5 (Function (Integer) Integer))
         (tailrecur (Function (Integer) Integer))
         (x.1 Integer)))
      (body
        (((Label block_3)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label tailrecur_conclusion)))))
         ((Label block_4)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label tailrecur))
               (Var $tmp.5))
             (Movq (Imm 1) (Var $tmp.3))
             (Negq (Var $tmp.3))
             (Movq (Var x.1) (Var $tmp.4))
             (Addq (Var $tmp.3) (Var $tmp.4))
             (Movq (Var $tmp.4) (Reg Rdi))
             (TailJmp (Var $tmp.5) 1))))
         ((Label tailrecur_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Cmpq (Imm 0) (Var x.1))
             (JmpIf CC_e (Label block_3))
             (Jmp (Label block_4)))))))))))