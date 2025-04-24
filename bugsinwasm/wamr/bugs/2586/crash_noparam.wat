(module
  (type (;0;) (func (param i64) (result i32)))
  (func (;0;) (result i32)
    (local i32 i64 f32 f64)
    global.get 0
    i32.const 0
    if (result i32)  ;; label = @1
      i32.const 1
    else
      i32.const 0
      br 0 (;@1;)
      global.get 0
      i32.add
    end
    br_if 0 (;@0;)
    drop
    local.get 1
    i32.const 0
    call_indirect (type 0))
  (table (;0;) 2 funcref)
  (global (;0;) (mut i32) (i32.const 0))
  (export "main" (func 0))
)
