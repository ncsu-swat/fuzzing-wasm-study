(module
  (type (;0;) (func))
  (global (;0;) (mut i32) i32.const 531017)
  (global (;1;) (mut v128) v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000)
  (func (;0;) (type 0)
    v128.const i32x4 0x01ffe900 0x0060010c 0x7d7e7f08 0x7d7e7f7c
    block ;; label = @1
      block (type 0) ;; label = @2
        i64.const 1
        loop (result i32) ;; label = @3
          block (type 0) ;; label = @4
            loop (type 0) ;; label = @5
              block (type 0) ;; label = @6
                loop (type 0) ;; label = @7
                end
                global.get 0
                br_table 0 (;@6;) 1 (;@5;) 2 (;@4;) 3 (;@3;) 4 (;@2;) 5 (;@1;) 6 1 (;@5;)
              end
            end
          end
          i32.const 1
        end
        global.get 0
        i32.xor
        global.set 0
        drop
      end
    end
    global.get 1
    v128.xor
    global.set 1
  )
  (export "main" (func 0))
)
