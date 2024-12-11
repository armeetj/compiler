(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((RegL Rsp) ((RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 0)
      (locals ())
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label main_conclusion)))))))))
   (Def
     (Label bluh)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp)))
          ((VarL bluh) ((RegL Rsp)))
          ((RegL Rsp) ((VarL $tmp.1) (VarL bluh))))))
     ((nparams 0)
      (locals
        (($tmp.1
           (Function
             ()
             (Function (Integer) Integer)))
         (bluh
           (Function
             ()
             (Function (Integer) Integer)))))
      (body
        (((Label bluh_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label bluh))
               (Var $tmp.1))
             (TailJmp (Var $tmp.1) 0))))))))))
