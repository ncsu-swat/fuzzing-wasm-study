(module
  (memory (;0;) 0)
  (export "main" (func 0))
  (func (;0;) (result)
    block (result) ;; label = @1
      i32.const 65536
      memory.grow
      i64.load align=2
      drop
    end
  )
)
