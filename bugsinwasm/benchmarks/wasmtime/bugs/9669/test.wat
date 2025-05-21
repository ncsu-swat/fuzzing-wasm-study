(module
  (rec
    (type (;0;) (func (result i32)))
    (type (;1;) (array (mut i32)))
    (type $Point (;2;) (struct (field $xs (mut (ref null 1)))))
  )
  (export "main" (func $main))
  (func $main (;0;) (type 0) (result i32)
    (local $p (ref null $Point))
    i32.const 0
    array.new_fixed 1 1
    struct.new $Point
    local.set $p
    local.get $p
    struct.get $Point $xs
    i32.const 0
    i32.const 1
    array.set 1
    local.get $p
    struct.get $Point $xs
    i32.const 0
    array.get 1
  )
)
