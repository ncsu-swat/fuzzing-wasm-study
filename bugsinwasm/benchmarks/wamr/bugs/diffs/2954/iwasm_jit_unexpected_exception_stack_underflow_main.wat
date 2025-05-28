(module
  (type (;0;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;1;) (func (param i32)))
  (type (;2;) (func))
  (type (;3;) (func (result i32)))
  (type (;4;) (func (param i32 i64 i64 i32) (result i32 i64 i64)))
  (type (;5;) (func (param i32 i64 i64) (result i32 i64 i64)))
  (func (;0;) (type 2)
    (local i32 f32 i64 f64)
    i32.const 305419896
    local.set 0
    global.get 14
    local.set 1
    i64.const -72057589709208571
    local.set 2
    f64.const 0x1.5f0b08c960a79p+109 (;=8.9e+32;)
    global.set 19
    i32.const -107562996
    i64.const 5777959071087702712
    i64.const -6994123069227352726
    i32.const 1480752386
    block (param i32 i64 i64 i32) (result i32 i64 i64)  ;; label = @1
      if (param i32 i64 i64) (result i32 i64 i64)  ;; label = @2
        loop (param i32 i64 i64) (result i32 i64 i64)  ;; label = @3
          global.set 5
          global.set 16
          global.set 8
          i64.const -6078933602712343470
          f32.convert_i64_u
          call 3
          i64.load8_s offset=8229
          f64.reinterpret_i64
          f64.neg
          memory.size
          global.set 8
          global.set 7
          global.set 9
          i32.const 1965353091
          global.set 12
          i64.const 5855724037438242200
          i32.const -2141058733
          i32.const -328024126
          i32.const -1473878584
          i32.const 149382844
          i32.const 1254
          i32.gt_s
          br_if 3 (;@0;)
          i32.le_u
          i32.le_u
          i64.extend_i32_s
          i64.div_u
          f32.const 0x1.307ca8p+90 (;=1.47241e+27;)
          global.set 14
          global.set 16
          i32.const 2101362534
          i32.const -1958014708
          i32.const -1223707223
          i64.const -2827015835958647448
          i64.const 6097956945153862903
          i64.eq
          i32.ge_s
          i32.rotr
          i32.clz
          i32.load16_s offset=12582 align=1
          i32.div_u
          i32.const -727560246
          i32.load8_u offset=15847
          i32.div_u
          i32.load16_s offset=3947 align=1
          i64.extend_i32_s
          i64.popcnt
          f64.reinterpret_i64
          global.set 11
          i32.const 20193
          i64.const -3230929273317897974
          i64.const 8216637116454018452
          br 0 (;@3;)
        end
      else
        i32.const 268695716
        br_if 1 (;@1;)
        i64.lt_u
        i64.load8_u offset=11289
        f32.convert_i64_u
        i32.trunc_sat_f32_u
        f32.load offset=8939 align=1
        global.set 3
        global.set 15
        f32.const -0x1.96669p+115 (;=-6.59423e+34;)
        i32.const -860645506
        i32.const 1917358370
        i64.const -5806589383315151890
        i32.const 22335
        i64.load8_s offset=16394
        i64.eq
        i32.rotr
        i32.ge_u
        local.set 0
        i64.trunc_f32_s
        global.set 5
        f32.const 0x1.4d34fp-3 (;=0.162699;)
        i32.const 522171735
        f64.const -0x1.04139e6f8f212p+829 (;=-3.63687e+249;)
        global.set 18
        global.set 8
        global.set 17
        i32.const -547434261
        i32.const 1156874680
        i32.const 1639470078
        nop
        i32.xor
        f64.load offset=6414 align=1
        i32.trunc_f64_s
        i32.rotr
        f32.reinterpret_i32
        global.set 3
        i32.const 5339
        i64.const 5653598632084595647
        i64.const 5329035309681682126
      end
    end
    global.set 13
    global.set 13
    global.set 8
    i32.const 2147483647
    i32.const -1
    i32.const -935656854
    table.init 2
    local.get 0
    global.set 8
    local.get 1
    global.set 9
    local.get 2
    global.set 10
    local.get 3
    global.set 11)
  (func (;1;) (type 3) (result i32)
    i32.const 1
    i32.const 3
    i32.add)
  (func (;2;) (type 3) (result i32)
    i32.const 2
    i32.const 3
    i32.add)
  (func (;3;) (type 3) (result i32)
    i32.const 3
    i32.const 3
    i32.add)
  (table (;0;) 10 20 funcref)
  (memory (export "memory") (;0;) 1 5)
  (global (;0;) i32 (i32.const 541))
  (global (;1;) (mut i32) (i32.const 191))
  (global (;2;) f32 (f32.const 0x1.0e8p+9 (;=541;)))
  (global (;3;) (mut f32) (f32.const 0x1.8p+7 (;=192;)))
  (global (;4;) i64 (i64.const 54))
  (global (;5;) (mut i64) (i64.const 19))
  (global (;6;) f64 (f64.const 0x1.bp+5 (;=54;)))
  (global (;7;) (mut f64) (f64.const 0x1.3p+4 (;=19;)))
  (global (;8;) (mut i32) (i32.const 0))
  (global (;9;) (mut f32) (f32.const 0x0p+0 (;=0;)))
  (global (;10;) (mut i64) (i64.const 0))
  (global (;11;) (mut f64) (f64.const 0x0p+0 (;=0;)))
  (global (;12;) (mut i32) (i32.const 667386033))
  (global (;13;) (mut i64) (i64.const 6761983695478452762))
  (global (;14;) (mut f32) (f32.const 0x1.59d484p-127 (;=7.93987e-39;)))
  (global (;15;) (mut i32) (i32.const 667386033))
  (global (;16;) (mut i64) (i64.const 6761983695478452762))
  (global (;17;) (mut f32) (f32.const 0x1.59d484p-127 (;=7.93987e-39;)))
  (global (;18;) (mut f64) (f64.const -0x1.449d82ffdf5d7p-725 (;=-7.18426e-219;)))
  (global (;19;) (mut f64) (f64.const -0x1.449d82ffdf5d7p-725 (;=-7.18426e-219;)))
  (export "_start" (func 0))
  (export "main" (func 0))
  (elem (;0;) (i32.const 0) func 1 2 3 0 1)
  (elem (;1;) (i32.const 5) func 3 3 2 1)
  (elem (;2;) (i32.const 9) func 0)
  (data (;0;) (i32.const 8) "\01\02\03\04\05\06\07\08")
  (data (;1;) (i32.const 16) "\01\02\03\04\05\06\07\08\ff")
  (data (;2;) (i32.const 32) "\01\02\03\04\05\06\07\08\ff"))
