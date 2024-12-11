(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rdi)))
          ((VarL $tmp.2) ((RegL Rdi)))
          ((VarL $tmp.3) ((RegL Rdi)))
          ((VarL $tmp.4) ((RegL Rdi)))
          ((VarL rrrid) ((RegL Rsp)))
          ((RegL Rsp) ((VarL rrrid)))
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
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rax)))
          ((RegL R8) ((RegL Rax)))
          ((RegL R9) ((RegL Rax)))
          ((RegL R10) ((RegL Rax)))
          ((RegL R11) ((RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1
           (Function
             (Integer)
             (Function
               (Integer)
               (Function
                 (Integer)
                 (Function (Integer) Integer)))))
         ($tmp.2
           (Function
             (Integer)
             (Function
               (Integer)
               (Function (Integer) Integer))))
         ($tmp.3
           (Function
             (Integer)
             (Function (Integer) Integer)))
         ($tmp.4 (Function (Integer) Integer))
         (rrrid
           (Function
             (Integer)
             (Function
               (Integer)
               (Function
                 (Integer)
                 (Function (Integer) Integer)))))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label rrrid))
               (Var $tmp.1))
             (Movq (Imm 0) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var $tmp.2))
             (Movq (Imm 0) (Reg Rdi))
             (IndirectCallq (Var $tmp.2) 1)
             (Movq (Reg Rax) (Var $tmp.3))
             (Movq (Imm 0) (Reg Rdi))
             (IndirectCallq (Var $tmp.3) 1)
             (Movq (Reg Rax) (Var $tmp.4))
             (Movq (Imm 42) (Reg Rdi))
             (TailJmp (Var $tmp.4) 1))))))))
   (Def
     (Label id)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label id_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Jmp (Label id_conclusion)))))))))
   (Def
     (Label rid)
     (Finfo2
       (conflicts
         (((VarL id) ((RegL Rsp)))
          ((VarL x.2) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL id) (VarL x.2) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.2 Integer)
         (id (Function (Integer) Integer))))
      (body
        (((Label rid_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.2))
             (Leaq (GlobalArg (Label id)) (Reg Rax))
             (Jmp (Label rid_conclusion)))))))))
   (Def
     (Label rrid)
     (Finfo2
       (conflicts
         (((VarL rid) ((RegL Rsp)))
          ((VarL x.3) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL rid) (VarL x.3) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.3 Integer)
         (rid
           (Function
             (Integer)
             (Function (Integer) Integer)))))
      (body
        (((Label rrid_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.3))
             (Leaq (GlobalArg (Label rid)) (Reg Rax))
             (Jmp (Label rrid_conclusion)))))))))
   (Def
     (Label rrrid)
     (Finfo2
       (conflicts
         (((VarL rrid) ((RegL Rsp)))
          ((VarL x.4) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL rrid) (VarL x.4) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.4 Integer)
         (rrid
           (Function
             (Integer)
             (Function
               (Integer)
               (Function (Integer) Integer))))))
      (body
        (((Label rrrid_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.4))
             (Leaq
               (GlobalArg (Label rrid))
               (Reg Rax))
             (Jmp (Label rrrid_conclusion)))))))))))
