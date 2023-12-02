(module

    (memory (export "memory") 1 1)
    (table 2 anyfunc)
    (elem (i32.const 0) $get_digit $get_digit2)
    (type $func_type (func (param i32)(result i32)))
    (func $part_one (param $len i32) (result i32)
        (local $total i32)
        (local $idx i32) ;; Current index in memory
        (loop $loop
            ;; Parse the next number
            (call $parse_num (local.get $idx) (local.get $len) (i32.const 0))
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

    (func $part_two (param $len i32) (result i32)
        (local $total i32)
        (local $idx i32) ;; Current index in memory
        (loop $loop
            ;; Parse the next number
            (call $parse_num (local.get $idx) (local.get $len) (i32.const 1))
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
    (export "part_two" (func $part_two))

    (func $get_digit (param $idx i32)
        (result i32)
        (local $v0 i32)
        (local $v1 i32)
        (local $v2 i32)
        (local $v3 i32)
        (local $v4 i32)
        (local $v5 i32)
        (local $res i32)

        (local.set $res (i32.const -1))
        (local.set $v0 (i32.load8_u (local.get $idx)))


        ;; '0' <= current <= '9'
        (i32.and
            (i32.ge_u (local.get $v0) (i32.const 48))
            (i32.le_u (local.get $v0) (i32.const 57))
        )
        (if
            (then
                (local.set $res (i32.sub (local.get $v0) (i32.const 48)))
            )
        )
        (local.get $res)
    )


    (func $get_digit2 (param $idx i32)
        (result i32)
        (local $v0 i32)
        (local $v1 i32)
        (local $v2 i32)
        (local $v3 i32)
        (local $v4 i32)
        (local $v5 i32)
        (local $res i32)

        (local.set $res (i32.const -1))
        (local.set $v0 (i32.load8_u (local.get $idx)))
        (local.set $v1 (i32.load8_u (i32.add (local.get $idx) (i32.const 1))))
        (local.set $v2 (i32.load8_u (i32.add (local.get $idx) (i32.const 2))))
        (local.set $v3 (i32.load8_u (i32.add (local.get $idx) (i32.const 3))))
        (local.set $v4 (i32.load8_u (i32.add (local.get $idx) (i32.const 4))))

        ;; '0' <= current <= '9'
        (i32.and
            (i32.ge_u (local.get $v0) (i32.const 48))
            (i32.le_u (local.get $v0) (i32.const 57))
        )
        (if
            (then
                (local.set $res (i32.sub (local.get $v0) (i32.const 48)))
            )
        )

        ;; one
        (i32.and
            (i32.and
                (i32.eq (local.get $v0) (i32.const 111))
                (i32.eq (local.get $v1) (i32.const 110))
            )
            (i32.eq (local.get $v2) (i32.const 101))
        )
        (if (then (local.set $res (i32.const 1))))



        ;; two
        (i32.and
            (i32.and
                (i32.eq (local.get $v0) (i32.const 116)) ;; t
                (i32.eq (local.get $v1) (i32.const 119)) ;; w
            )
            (i32.eq (local.get $v2) (i32.const 111)) ;; o
        )
        (if (then (local.set $res (i32.const 2))))

        ;; three
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 116)) ;; t
                    (i32.eq (local.get $v1) (i32.const 104)) ;; h
                )
                (i32.eq (local.get $v2) (i32.const 114)) ;; r
            )
            (i32.and
                (i32.eq (local.get $v3) (i32.const 101)) ;; e
                (i32.eq (local.get $v4) (i32.const 101)) ;; e
            )

        )
        (if (then (local.set $res (i32.const 3))))

        ;; four
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 102)) ;; f
                    (i32.eq (local.get $v1) (i32.const 111)) ;; o
                )
                (i32.eq (local.get $v2) (i32.const 117)) ;; u
            )
            (i32.eq (local.get $v3) (i32.const 114)) ;; r
        )
        (if (then (local.set $res (i32.const 4))))

        ;; five
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 102)) ;; f
                    (i32.eq (local.get $v1) (i32.const 105)) ;; i
                )
                (i32.eq (local.get $v2) (i32.const 118)) ;; v
            )
            (i32.eq (local.get $v3) (i32.const 101)) ;; e
        )
        (if (then (local.set $res (i32.const 5))))

        ;; six
        (i32.and
            (i32.and
                (i32.eq (local.get $v0) (i32.const 115)) ;; s
                (i32.eq (local.get $v1) (i32.const 105)) ;; i
            )
            (i32.eq (local.get $v2) (i32.const 120)) ;; x
        )
        (if (then (local.set $res (i32.const 6))))

        ;; seven
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 115)) ;; s
                    (i32.eq (local.get $v1) (i32.const 101)) ;; e
                )
                (i32.eq (local.get $v2) (i32.const 118)) ;; v
            )
            (i32.and
                (i32.eq (local.get $v3) (i32.const 101)) ;; e
                (i32.eq (local.get $v4) (i32.const 110)) ;; n
            )
        )
        (if (then (local.set $res (i32.const 7))))

        ;; eight
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 101)) ;; e
                    (i32.eq (local.get $v1) (i32.const 105)) ;; i
                )
                (i32.eq (local.get $v2) (i32.const 103)) ;; g
            )
            (i32.and
                (i32.eq (local.get $v3) (i32.const 104)) ;; h
                (i32.eq (local.get $v4) (i32.const 116)) ;; t
            )
        )
        (if (then (local.set $res (i32.const 8))))

        ;; nine
        (i32.and
            (i32.and
                (i32.and
                    (i32.eq (local.get $v0) (i32.const 110)) ;; n
                    (i32.eq (local.get $v1) (i32.const 105)) ;; i
                )
                (i32.eq (local.get $v2) (i32.const 110)) ;; n
            )
            (i32.eq (local.get $v3) (i32.const 101)) ;; e
        )
        (if (then (local.set $res (i32.const 9))))

        (local.get $res)
    )

    (func $parse_num (param $idx i32) (param $len i32) (param $digit_func i32)
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
                    (local.set $current (call_indirect (type $func_type ) (local.get $idx)  (local.get $digit_func) ))
                    (i32.ge_s (local.get $current) (i32.const 0))
                    (if
                        (then
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
