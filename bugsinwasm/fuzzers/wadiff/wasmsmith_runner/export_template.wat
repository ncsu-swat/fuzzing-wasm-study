(module
  (func (export "main")
    (result i32 i64 f32 f64 v128 v128 v128 v128)
    i32.const 0
    i64.const 0
    f32.const 0
    f64.const 0
    v128.const i32x4 0 0 0 0
    v128.const i64x2 0 0
    v128.const f32x4 0 0 0 0
    v128.const f64x2 0 0
  )
)
