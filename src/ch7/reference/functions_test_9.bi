(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsi) (RegL Rdi)))
          ((VarL add) ((RegL Rsp)))
          ((RegL Rsp) ((VarL add)))
          ((RegL Rsi) ((VarL $tmp.1) (RegL Rdi)))
          ((RegL Rdi) ((VarL $tmp.1) (RegL Rsi))))))
     ((nparams 0)
      (locals
        (($tmp.1
           (Function (Integer Integer) Integer))
         (add
           (Function (Integer Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label add))
               (Var $tmp.1))
             (Movq (Imm 20) (Reg Rdi))
             (Movq (Imm 22) (Reg Rsi))
             (TailJmp (Var $tmp.1) 2))))))))
   (Def
     (Label add)
     (Finfo2
       (conflicts
         (((VarL x.1)
           ((VarL y.1) (RegL Rsp) (RegL Rsi)))
          ((VarL y.1)
           ((VarL x.1) (RegL Rsp) (RegL Rax)))
          ((RegL Rsp)
           ((VarL x.1) (VarL y.1) (RegL Rax)))
          ((RegL Rax) ((VarL y.1) (RegL Rsp)))
          ((RegL Rsi) ((VarL x.1))))))
     ((nparams 2)
      (locals
        ((x.1 Integer)
         (y.1 Integer)
         (x.1 Integer)
         (y.1 Integer)))
      (body
        (((Label add_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Reg Rsi) (Var y.1))
             (Movq (Var x.1) (Reg Rax))
             (Addq (Var y.1) (Reg Rax))
             (Jmp (Label add_conclusion)))))))))))