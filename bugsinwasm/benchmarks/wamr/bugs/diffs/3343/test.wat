(module
  (type (;0;) (func))
  (type (;1;) (func (param i32)))
  (type (;2;) (func (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" (func (;0;) (type 1)))
  (import "wasi_snapshot_preview1" "fd_write" (func (;1;) (type 2)))
  (func (;2;) (type 0)
    i32.const 0
    i32.const 255
    i32.store8
    f64.const nan (;=nan;)
    i32.const 0
    f64.load
    f64.const 0x0p+0 (;=0;)
    f64.mul
    f64.mul
    global.set 0
    i32.const 0
    global.get 0
    f64.store
    i32.const 27
    global.get 0
    f64.store)
  (func (;3;) (type 0)
    call 2
    call 2
    i32.const 0
    i32.const 16
    i32.const 2
    i32.const 0
    call 1
    drop
    i32.const 0
    call 0
    unreachable)
  (memory (;0;) 8192 8192)
  (global (;0;) (mut f64) (f64.const 0x0p+0 (;=0;)))
  (export "memory" (memory 0))
  (export "_start" (func 3)))