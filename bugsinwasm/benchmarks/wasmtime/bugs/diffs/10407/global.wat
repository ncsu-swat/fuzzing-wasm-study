(module
  (global $g (mut anyref) ;; or eqref
    ;;(i32.const 262_135) ;; OK
    (i32.const 262_136)
    (ref.i31)
  )
  (func (export "f")
    ;;(i32.const 262_135) ;; OK
    (i32.const 262_136)
    (ref.i31)
    (global.set $g)
  )
)
