(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1)
           ((VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL $tmp.2)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL $tmp.3)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rsi)
            (RegL Rdi)))
          ((VarL $tmp.4)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL $tmp.5) ((RegL Rsp) (RegL Rax)))
          ((VarL big) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL big)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rax)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rcx)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rdx)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)
            (RegL Rdi)))
          ((RegL Rsi)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdx)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdx)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R9)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R10)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R11)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer Integer Integer)
             Integer))
         ($tmp.5 Integer)
         (big
           (Function
             (Integer Integer Integer)
             Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label big))
               (Var $tmp.4))
             (Callq (Label read_int) 0)
             (Movq (Reg Rax) (Var $tmp.1))
             (Callq (Label read_int) 0)
             (Movq (Reg Rax) (Var $tmp.2))
             (Callq (Label read_int) 0)
             (Movq (Reg Rax) (Var $tmp.3))
             (Movq (Var $tmp.1) (Reg Rdi))
             (Movq (Var $tmp.2) (Reg Rsi))
             (Movq (Var $tmp.3) (Reg Rdx))
             (IndirectCallq (Var $tmp.4) 3)
             (Movq (Reg Rax) (Var $tmp.5))
             (Movq (Imm 42) (Reg Rax))
             (Addq (Var $tmp.5) (Reg Rax))
             (Jmp (Label main_conclusion)))))))))
   (Def
     (Label big)
     (Finfo2
       (conflicts
         (((VarL $tmp.10)
           ((VarL $tmp.11)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.11)
           ((VarL $tmp.10)
            (VarL $tmp.12)
            (VarL $tmp.8)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.12)
           ((VarL $tmp.11)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.17)
            (VarL $tmp.18)
            (VarL $tmp.19)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.13)
           ((VarL $tmp.12)
            (VarL $tmp.14)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.14)
           ((VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.15)
            (VarL x.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.15)
           ((VarL $tmp.12)
            (VarL $tmp.14)
            (VarL $tmp.16)
            (VarL $tmp.17)
            (VarL $tmp.18)
            (VarL x.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.16)
           ((VarL $tmp.12)
            (VarL $tmp.15)
            (VarL $tmp.17)
            (VarL x.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.17)
           ((VarL $tmp.12)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.18)
            (RegL Rsp)))
          ((VarL $tmp.18)
           ((VarL $tmp.12)
            (VarL $tmp.15)
            (VarL $tmp.17)
            (VarL $tmp.19)
            (RegL Rsp)))
          ((VarL $tmp.19)
           ((VarL $tmp.12)
            (VarL $tmp.18)
            (RegL Rsp)
            (RegL Rax)))
          ((VarL $tmp.6)
           ((VarL $tmp.7)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.7)
           ((VarL $tmp.6)
            (VarL $tmp.8)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.8)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.9)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.9)
           ((VarL $tmp.10)
            (VarL $tmp.8)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL x.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL y.1)
            (VarL z.1)
            (RegL Rsp)
            (RegL Rdx)
            (RegL Rsi)))
          ((VarL y.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL x.1)
            (VarL z.1)
            (RegL Rsp)
            (RegL Rdx)))
          ((VarL z.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL x.1)
            (VarL y.1)
            (RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.17)
            (VarL $tmp.18)
            (VarL $tmp.19)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL x.1)
            (VarL y.1)
            (VarL z.1)
            (RegL Rax)))
          ((RegL Rax) ((VarL $tmp.19) (RegL Rsp)))
          ((RegL Rdx) ((VarL x.1) (VarL y.1)))
          ((RegL Rsi) ((VarL x.1))))))
     ((nparams 3)
      (locals
        ((x.1 Integer)
         (y.1 Integer)
         (z.1 Integer)
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 Integer)
         ($tmp.16 Integer)
         ($tmp.17 Integer)
         ($tmp.18 Integer)
         ($tmp.19 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (x.1 Integer)
         (y.1 Integer)
         (z.1 Integer)))
      (body
        (((Label big_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Reg Rsi) (Var y.1))
             (Movq (Reg Rdx) (Var z.1))
             (Movq (Var x.1) (Var $tmp.6))
             (Addq (Var y.1) (Var $tmp.6))
             (Movq (Var x.1) (Var $tmp.7))
             (Addq (Var z.1) (Var $tmp.7))
             (Movq (Var $tmp.6) (Var $tmp.8))
             (Addq (Var $tmp.7) (Var $tmp.8))
             (Movq (Var z.1) (Var $tmp.9))
             (Addq (Var x.1) (Var $tmp.9))
             (Movq (Var z.1) (Var $tmp.10))
             (Addq (Var y.1) (Var $tmp.10))
             (Movq (Var $tmp.9) (Var $tmp.11))
             (Addq (Var $tmp.10) (Var $tmp.11))
             (Movq (Var $tmp.8) (Var $tmp.12))
             (Addq (Var $tmp.11) (Var $tmp.12))
             (Movq (Var y.1) (Var $tmp.13))
             (Addq (Var y.1) (Var $tmp.13))
             (Movq (Var y.1) (Var $tmp.14))
             (Addq (Var x.1) (Var $tmp.14))
             (Movq (Var $tmp.13) (Var $tmp.15))
             (Addq (Var $tmp.14) (Var $tmp.15))
             (Movq (Var z.1) (Var $tmp.16))
             (Addq (Var x.1) (Var $tmp.16))
             (Movq (Var z.1) (Var $tmp.17))
             (Addq (Var z.1) (Var $tmp.17))
             (Movq (Var $tmp.16) (Var $tmp.18))
             (Addq (Var $tmp.17) (Var $tmp.18))
             (Movq (Var $tmp.15) (Var $tmp.19))
             (Addq (Var $tmp.18) (Var $tmp.19))
             (Movq (Var $tmp.12) (Reg Rax))
             (Addq (Var $tmp.19) (Reg Rax))
             (Jmp (Label big_conclusion)))))))))))
