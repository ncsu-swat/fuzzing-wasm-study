(module
  (type (func))
  (type (func (param i32 i32 i32) (result i32)))
  (type (func (param i32)))
  (type (func (param i32) (result i32)))
  (import "wasi_snapshot_preview1" "sock_accept" (func $sock_shutdown (type 1)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $proc_exit (type 2)))
  (import "wasi_snapshot_preview1" "fd_close" (func $fd_close (type 3)))
  (func $_start
    (call $fd_close
      (i32.const 2)
    )
    drop
    (call $sock_shutdown
      (i32.const 2)
      (i32.const 27)
      (i32.const 1337)
    )
    call $proc_exit
  )
  (memory 2)
  (export "memory" (memory 0))
  (export "_start" (func $_start))
)
