(module
 
    (memory (export "memory") 1 1)
  
    (func $part_one (param $len i32) (result i32)        
        (local $total i32) 
        (local $idx i32) ;; Current index in memory
        (loop $loop
            ;; Parse the next number
            (call $parse_num (local.get $idx) (local.get $len))
            local.set $idx ;; parse_num returns the index after the parsed number, this is the new $idx
            ;; @0 parse_num result
            ;; $total += @0
            (local.set $total 
                (i32.add 
                    (local.get $total)
                )
            )

            ;; next line
            (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
                            
            ;; eof
            (i32.lt_u (local.get $idx) (local.get $len))
            (if
                (then br $loop )
            )
        )

        local.get $total
    )
    (export "part_one" (func $part_one))

    (func $parse_num (param $idx i32) (param $len i32)
        (result i32)
        (result i32)
        (local $left_flag i32)
        (local $left i32)
        (local $right i32)
        (local $current i32)
        (loop $loop
            ;; eol
            (i32.and
                (i32.ne (i32.load8_u (local.get $idx)) (i32.const 10))
                (i32.ne (local.get $idx) (local.get $len))
            )
            (if
                (then
                    (local.set $current (i32.load8_u (local.get $idx)))


                    ;; '0' <= current <= '9'
                    (i32.and
                        (i32.ge_u (local.get $current) (i32.const 48))
                        (i32.le_u (local.get $current) (i32.const 58))
                    )
                    (if
                        (then
                            (local.set $current (i32.sub (local.get $current) (i32.const 48)))
                            (i32.eq (local.get $left_flag) (i32.const 0))
                            (if (then 
                                    (local.set $left (local.get $current)) 
                                    (local.set $left_flag (i32.const 1))
                            ))
                            (local.set $right (local.get $current))
                        )
                    )

                    ;; Increment index
                    (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
                    br $loop
                )
            )
        )

        ;; left*10 + right
        (i32.add (i32.mul (local.get $left) (i32.const 10)) (local.get $right))
        local.get $idx
    )

)
