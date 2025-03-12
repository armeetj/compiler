(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((VarL $tmp.2)))
          ((VarL $tmp.2)
           ((VarL $tmp.1) (RegL Rdi)))
          ((VarL $tmp.3) ((RegL Rdi)))
          ((VarL id) ((RegL Rsp)))
          ((VarL inc) ((RegL Rsp)))
          ((RegL Rsp) ((VarL id) (VarL inc)))
          ((RegL Rax)
           ((RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx) ((RegL Rax)))
          ((RegL Rdx) ((RegL Rax)))
          ((RegL Rsi) ((RegL Rax)))
          ((RegL Rdi)
           ((VarL $tmp.2) (VarL $tmp.3) (RegL Rax)))
          ((RegL R8) ((RegL Rax)))
          ((RegL R9) ((RegL Rax)))
          ((RegL R10) ((RegL Rax)))
          ((RegL R11) ((RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2
           (Function
             ((Function (Integer) Integer))
             (Function (Integer) Integer)))
         ($tmp.3 (Function (Integer) Integer))
         (id
           (Function
             ((Function (Integer) Integer))
             (Function (Integer) Integer)))
         (inc (Function (Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label id))
               (Var $tmp.2))
             (Leaq
               (GlobalArg (Label inc))
               (Var $tmp.1))
             (Movq (Var $tmp.1) (Reg Rdi))
             (IndirectCallq (Var $tmp.2) 1)
             (Movq (Reg Rax) (Var $tmp.3))
             (Movq (Imm 41) (Reg Rdi))
             (TailJmp (Var $tmp.3) 1))))))))
   (Def
     (Label id)
     (Finfo2
       (conflicts
         (((VarL f.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL f.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((f.1 (Function (Integer) Integer))
         (f.1 (Function (Integer) Integer))))
      (body
        (((Label id_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var f.1))
             (Movq (Var f.1) (Reg Rax))
             (Jmp (Label id_conclusion)))))))))
   (Def
     (Label inc)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label inc_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Addq (Imm 1) (Reg Rax))
             (Jmp (Label inc_conclusion)))))))))))
