(module
  (type (func))
  (type (func (param i32 i64 i64 i32) (result i32)))
  (type (func (param i32)))
  (import "wasi_snapshot_preview1" "fd_filestat_set_times" (func $fd_filestat_set_times (type 1)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $proc_exit (type 2)))
  (func $_start
    (local $err i32)

    (call $fd_filestat_set_times
      (i32.const 3) ;; preopened dir
      (i64.const 13136941795642118959) ;; very large timestamp
      (i64.const 0)
      (i32.const 1) ;; atim
    )
    (local.set $err)
    (if
      (i32.ne (i32.const 0) (local.get $err))
      (then (call $proc_exit (local.get $err)))
    )

    (call $proc_exit (i32.load (i32.const 2048)))
  )
  (memory 2)
  (export "memory" (memory 0))
  (export "_start" (func $_start))
)
