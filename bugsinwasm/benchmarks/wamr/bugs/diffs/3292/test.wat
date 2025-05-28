(module
(type $t/1 (sub (struct)))
(type $t/2 (sub (struct)))
(func $f/1 (param (ref null $t/1)))
(func $f/2 (call $f/1 (ref.null $t/2) ))
)