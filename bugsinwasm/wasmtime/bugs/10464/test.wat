(module
  (type $a (struct))
  (type $b (array structref))
  (start $c)
  (func $c
    struct.new_default $a
    i32.const 536870911
    array.new $b
    drop
  )
)
