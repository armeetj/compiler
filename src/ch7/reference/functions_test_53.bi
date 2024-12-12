(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1)
           ((VarL $tmp.2)
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
          ((VarL $tmp.2)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rdi)))
          ((VarL $tmp.3)
           ((VarL $tmp.1)
            (VarL $tmp.2)
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
          ((VarL $tmp.4) ((RegL Rsp)))
          ((VarL ack) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL ack)
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
            (VarL $tmp.3)
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
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rdx)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rsi)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R9)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R10)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R11)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL Rax))))))
     ((nparams 0)
      (locals
        (($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3
           (Function (Integer Integer) Integer))
         ($tmp.4 Integer)
         (ack
           (Function (Integer Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label ack))
               (Var $tmp.3))
             (Callq (Label read_int) 0)
             (Movq (Reg Rax) (Var $tmp.1))
             (Callq (Label read_int) 0)
             (Movq (Reg Rax) (Var $tmp.2))
             (Movq (Var $tmp.1) (Reg Rdi))
             (Movq (Var $tmp.2) (Reg Rsi))
             (IndirectCallq (Var $tmp.3) 2)
             (Movq (Reg Rax) (Var $tmp.4))
             (Movq (Var $tmp.4) (Reg Rax))
             (Addq (Imm 41) (Reg Rax))
             (Jmp (Label main_conclusion)))))))))
   (Def
     (Label ack)
     (Finfo2
       (conflicts
         (((VarL $tmp.10)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rdi)))
          ((VarL $tmp.11)
           ((VarL $tmp.10)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL m.1)
            (VarL n.1)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL $tmp.5) ((VarL $tmp.6)))
          ((VarL $tmp.6)
           ((VarL $tmp.5)
            (VarL m.1)
            (RegL Rsi)
            (RegL Rdi)))
          ((VarL $tmp.7)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL m.1)
            (VarL n.1)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((VarL $tmp.8)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.9)
            (VarL m.1)
            (RegL Rdi)))
          ((VarL $tmp.9)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL m.1)
            (VarL n.1)
            (RegL Rsi)
            (RegL Rdi)))
          ((VarL ack) ((RegL Rsp)))
          ((VarL m.1)
           ((VarL $tmp.11)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL n.1)
            (RegL Rsp)
            (RegL Rsi)
            (RegL Rflags)))
          ((VarL n.1)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.9)
            (VarL m.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL ack)
            (VarL m.1)
            (VarL n.1)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (VarL n.1)
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
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL Rdx)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL Rsi)
           ((VarL $tmp.11)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.9)
            (VarL m.1)
            (RegL Rax)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (RegL Rax)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL R9)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL R10)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL R11)
           ((VarL $tmp.11)
            (VarL $tmp.7)
            (RegL Rax)))
          ((RegL Rflags)
           ((VarL m.1) (VarL n.1) (RegL Rsp))))))
     ((nparams 2)
      (locals
        ((m.1 Integer)
         (n.1 Integer)
         ($tmp.10 Integer)
         ($tmp.11
           (Function (Integer Integer) Integer))
         ($tmp.5 Integer)
         ($tmp.6
           (Function (Integer Integer) Integer))
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9
           (Function (Integer Integer) Integer))
         (ack
           (Function (Integer Integer) Integer))
         (m.1 Integer)
         (n.1 Integer)))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label ack))
               (Var $tmp.6))
             (Movq (Var m.1) (Var $tmp.5))
             (Subq (Imm 1) (Var $tmp.5))
             (Movq (Var $tmp.5) (Reg Rdi))
             (Movq (Imm 1) (Reg Rsi))
             (TailJmp (Var $tmp.6) 2))))
         ((Label block_2)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label ack))
               (Var $tmp.11))
             (Movq (Var m.1) (Var $tmp.7))
             (Subq (Imm 1) (Var $tmp.7))
             (Leaq
               (GlobalArg (Label ack))
               (Var $tmp.9))
             (Movq (Var n.1) (Var $tmp.8))
             (Subq (Imm 1) (Var $tmp.8))
             (Movq (Var m.1) (Reg Rdi))
             (Movq (Var $tmp.8) (Reg Rsi))
             (IndirectCallq (Var $tmp.9) 2)
             (Movq (Reg Rax) (Var $tmp.10))
             (Movq (Var $tmp.7) (Reg Rdi))
             (Movq (Var $tmp.10) (Reg Rsi))
             (TailJmp (Var $tmp.11) 2))))
         ((Label block_3)
          (Block
            Binfo1
            ((Movq (Imm 1) (Reg Rax))
             (Addq (Var n.1) (Reg Rax))
             (Jmp (Label ack_conclusion)))))
         ((Label block_4)
          (Block
            Binfo1
            ((Cmpq (Imm 0) (Var n.1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))
         ((Label ack_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var m.1))
             (Movq (Reg Rsi) (Var n.1))
             (Cmpq (Imm 0) (Var m.1))
             (JmpIf CC_e (Label block_3))
             (Jmp (Label block_4)))))))))))