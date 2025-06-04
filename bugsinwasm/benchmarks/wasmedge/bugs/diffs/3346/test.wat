(module
  (type (;0;) (func (result i32)))
  (func (;0;) (type 0) (result i32)
    i64.const 0xcafebabe
    i32.const 0xdeadbeef
    i64.load8_s
    i64.eq)
  (memory (;0;) 1)
  (export "mem" (memory 0))
  (export "main" (func 0)))
