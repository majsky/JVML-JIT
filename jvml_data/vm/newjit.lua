TIME_SPENT_EMITTING_ASSEMBLY = 0
TIME_SPENT_COMPILING_LASM = 0

local function compile(class, method, codeAttr, cp)
    -- declarations
    local stream = makeExtendedChunkStream(class, method, codeAttr, cp)

    local oplookup = {
        function() -- 01
            -- null
            local r = stream.alloc()
            stream.LOADNIL(r, r)
        end, function() -- 02
            -- iconst_m1
            stream.asmLoadk(stream.alloc(), -1)
        end, function() -- 03
            -- iconst_0
            stream.asmLoadk(stream.alloc(), 0)
        end, function() -- 04
            -- iconst_1
            stream.asmLoadk(stream.alloc(), 1)
        end, function() -- 05
            -- iconst_2
            stream.asmLoadk(stream.alloc(), 2)
        end, function() -- 06
            -- iconst_3
            stream.asmLoadk(stream.alloc(), 3)
        end, function() -- 07
            -- iconst_4
            stream.asmLoadk(stream.alloc(), 4)
        end, function() -- 08
            -- iconst_5
            stream.asmLoadk(stream.alloc(), 5)
        end, function() -- 09
            -- lconst_0
            stream.asmGetObj(stream.alloc(), bigint(0))
        end, function() -- 0A
            -- lconst_1
            stream.asmGetObj(stream.alloc(), bigint(1))
        end, function() -- 0B
            -- fconst_0
            stream.asmLoadk(stream.alloc(), 0)
        end, function() -- 0C
            -- fconst_1
            stream.asmLoadk(stream.alloc(), 1)
        end, function() -- 0D
            -- fconst_2
            stream.asmLoadk(stream.alloc(), 2)
        end, function() -- 0E
            -- dconst_0
            stream.asmLoadk(stream.alloc(), 0)
        end, function() -- 0F
            -- dconst_1
            stream.asmLoadk(stream.alloc(), 1)
        end, function() -- 10
            -- bipush
            stream.asmLoadk(stream.alloc(), stream.u1())
        end, function() -- 11
            -- sipush
            stream.asmLoadk(stream.alloc(), stream.u2())
        end, function() -- 12
            -- ldc
            local s = cp[stream.u1()]
            local reg = stream.alloc()
            if s.bytes then
                stream.asmLoadk(reg, s.bytes)
            elseif s.tag == CONSTANT.Class then
                stream.asmGetObj(reg, getJClass(cp[s.name_index].bytes:gsub("/", ".")))
                stream.getPool(reg).nullChecked = true
            else
                stream.asmLoadJString(reg, cp[s.string_index].bytes)
                stream.getPool(reg).nullChecked = true
            end
        end, function() -- 13
            -- ldc_w
            local s = cp[stream.u2()]
            local reg = stream.alloc()
            if s.bytes then
                stream.asmLoadk(reg, s.bytes)
            elseif s.tag == CONSTANT.Class then
                stream.asmGetObj(reg, getJClass(cp[s.name_index].bytes:gsub("/", ".")))
                stream.getPool(reg).nullChecked = true
            else
                stream.asmLoadJString(reg, cp[s.string_index].bytes)
                stream.getPool(reg).nullChecked = true
            end
        end, function() -- 14
            -- ldc2_w
            local s = cp[stream.u2()]
            if s.cl == "D" then
                stream.asmLoadk(stream.alloc(), s.bytes)
            elseif s.cl == "J" then
                stream.asmGetObj(stream.alloc(), s.bytes)
            else
                error("Unknown wide constant type.")
            end
        end, function() -- 15
            -- loads
            stream.MOVE(stream.alloc(), stream.u1() + 1)
        end, function() -- 16
            -- loads
            stream.MOVE(stream.alloc(), stream.u1() + 1)
        end, function() -- 17
            -- loads
            stream.MOVE(stream.alloc(), stream.u1() + 1)
        end, function() -- 18
            -- loads
            stream.MOVE(stream.alloc(), stream.u1() + 1)
        end, function() -- 19
            -- loads
            stream.MOVE(stream.alloc(), stream.u1() + 1)
        end, function() -- 1A
            -- load_0
            stream.MOVE(stream.alloc(), 1)
        end, function() -- 1B
            -- load_1
            stream.MOVE(stream.alloc(), 2)
        end, function() -- 1C
            -- load_2
            stream.MOVE(stream.alloc(), 3)
        end, function() -- 1D
            -- load_3
            stream.MOVE(stream.alloc(), 4)
        end, function() -- 1E
            -- load_0
            stream.MOVE(stream.alloc(), 1)
        end, function() -- 1F
            -- load_1
            stream.MOVE(stream.alloc(), 2)
        end, function() -- 20
            -- load_2
            stream.MOVE(stream.alloc(), 3)
        end, function() -- 21
            -- load_3
            stream.MOVE(stream.alloc(), 4)
        end, function() -- 22
            -- load_0
            stream.MOVE(stream.alloc(), 1)
        end, function() -- 23
            -- load_1
            stream.MOVE(stream.alloc(), 2)
        end, function() -- 24
            -- load_2
            stream.MOVE(stream.alloc(), 3)
        end, function() -- 25
            -- load_3
            stream.MOVE(stream.alloc(), 4)
        end, function() -- 26
            -- load_0
            stream.MOVE(stream.alloc(), 1)
        end, function() -- 27
            -- load_1
            stream.MOVE(stream.alloc(), 2)
        end, function() -- 28
            -- load_2
            stream.MOVE(stream.alloc(), 3)
        end, function() -- 29
            -- load_3
            stream.MOVE(stream.alloc(), 4)
        end, function() -- 2A
            -- load_0
            stream.MOVE(stream.alloc(), 1)
        end, function() -- 2B
            -- load_1
            stream.MOVE(stream.alloc(), 2)
        end, function() -- 2C
            -- load_2
            stream.MOVE(stream.alloc(), 3)
        end, function() -- 2D
            -- load_3
            stream.MOVE(stream.alloc(), 4)
        end, function() -- 2E
            stream.asmAALoad()
        end, function() -- 2F
            stream.asmAALoad()
        end, function() -- 30
            stream.asmAALoad()
        end, function() -- 31
            stream.asmAALoad()
        end, function() -- 32
            stream.asmAALoad()
        end, function() -- 33
            stream.asmAALoad()
        end, function() -- 34
            stream.asmAALoad()
        end, function() -- 35
            stream.asmAALoad()
        end, function() -- 36
            -- stores
            stream.MOVE(stream.u1() + 1, stream.free())
        end, function() -- 37
            -- stores
            stream.MOVE(stream.u1() + 1, stream.free())
        end, function() -- 38
            -- stores
            stream.MOVE(stream.u1() + 1, stream.free())
        end, function() -- 39
            -- stores
            stream.MOVE(stream.u1() + 1, stream.free())
        end, function() -- 3A
            -- stores
            stream.MOVE(stream.u1() + 1, stream.free())
        end, function() -- 3B
            -- stores
            stream.MOVE(1, stream.free())
        end, function() -- 3C
            -- stores
            stream.MOVE(2, stream.free())
        end, function() -- 3D
            -- stores
            stream.MOVE(3, stream.free())
        end, function() -- 3E
            -- stores
            stream.MOVE(4, stream.free())
        end, function() -- 3F
            -- stores
            stream.MOVE(1, stream.free())
        end, function() -- 40
            -- stores
            stream.MOVE(2, stream.free())
        end, function() -- 41
            -- stores
            stream.MOVE(3, stream.free())
        end, function() -- 42
            -- stores
            stream.MOVE(4, stream.free())
        end, function() -- 43
            -- stores
            stream.MOVE(1, stream.free())
        end, function() -- 44
            -- stores
            stream.MOVE(2, stream.free())
        end, function() -- 45
            -- stores
            stream.MOVE(3, stream.free())
        end, function() -- 46
            -- stores
            stream.MOVE(4, stream.free())
        end, function() -- 47
            -- stores
            stream.MOVE(1, stream.free())
        end, function() -- 48
            -- stores
            stream.MOVE(2, stream.free())
        end, function() -- 49
            -- stores
            stream.MOVE(3, stream.free())
        end, function() -- 4A
            -- stores
            stream.MOVE(4, stream.free())
        end, function() -- 4B
            -- stores
            stream.MOVE(1, stream.free())
        end, function() -- 4C
            -- stores
            stream.MOVE(2, stream.free())
        end, function() -- 4D
            -- stores
            stream.MOVE(3, stream.free())
        end, function() -- 4E
            -- stores
            stream.MOVE(4, stream.free())
        end, function() -- 4F
            -- aastore
            stream.asmAAStore()
        end, function() -- 50
            -- aastore
            stream.asmAAStore()
        end, function() -- 51
            -- aastore
            stream.asmAAStore()
        end, function() -- 52
            -- aastore
            stream.asmAAStore()
        end, function() -- 53
            -- aastore
            stream.asmAAStore()
        end, function() -- 54
            -- aastore
            stream.asmAAStore()
        end, function() -- 55
            -- aastore
            stream.asmAAStore()
        end, function() -- 56
            -- aastore
            stream.asmAAStore()
        end, function() -- 57
            -- pop
            stream.free()
        end, function() -- 58
            error("58 not implemented")
        end, function() -- 59
            -- dup
            local r = stream.peek(0)
            stream.MOVE(stream.alloc(), r)
        end, function() -- 5A
            -- dup_x1
            local r2, r1 = stream.peek(0), stream.peek(1)
            local r3 = stream.alloc(1)
            stream.MOVE(r3, r2)
            stream.MOVE(r2, r1)
            stream.MOVE(r1, r3)
        end, function() -- 5B
            error("5B not implemented")
        end, function() -- 5C
            error("5C not implemented")
        end, function() -- 5D
            error("5D not implemented")
        end, function() -- 5E
            error("5E not implemented")
        end, function() -- 5F
            error("5F not implemented")
        end, function() -- 60
            -- add
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.ADD(r1, r1, r2)
            stream.free(1)
        end, function() -- 61
            -- ladd
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r2)
            stream.MOVE(r2, r1)
            stream.asmGetObj(r1, bigintAdd)
            stream.CALL(r1, 3, 2)
            stream.free(2)
            stream.asmFixLongOverflow(r1)
        end, function() -- 62
            -- add
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.ADD(r1, r1, r2)
            stream.free(1)
        end, function() -- 63
            -- add
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.ADD(r1, r1, r2)
            stream.free(1)
        end, function() -- 64
            -- sub
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.SUB(r1, r1, r2)
            stream.free(1)
        end, function() -- 65
            -- lsub
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r2)
            stream.MOVE(r2, r1)
            stream.asmGetObj(r1, bigintSub)
            stream.CALL(r1, 3, 2)
            stream.free(2)
            stream.asmFixLongOverflow(r1)
        end, function() -- 66
            -- sub
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.SUB(r1, r1, r2)
            stream.free(1)
        end, function() -- 67
            -- sub
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.SUB(r1, r1, r2)
            stream.free(1)
        end, function() -- 68
            -- mul
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.MUL(r1, r1, r2)
            stream.free(1)
        end, function() -- 69
            -- lmul
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r2)
            stream.MOVE(r2, r1)
            stream.asmGetObj(r1, bigintMul)
            stream.CALL(r1, 3, 2)
            stream.free(2)
            stream.asmFixLongOverflow(r1)
        end, function() -- 6A
            -- mul
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.MUL(r1, r1, r2)
            stream.free(1)
        end, function() -- 6B
            -- mul
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            stream.MUL(r1, r1, r2)
            stream.free(1)
        end, function() -- 6C
            -- div
            stream.asmIntDiv()
        end, function() -- 6D
            -- div
            stream.asmLongDiv()
        end, function() -- 6E
            -- div
            stream.asmFloatDiv()
        end, function() -- 6F
            -- div
            stream.asmFloatDiv()
        end, function() -- 70
            -- rem
            stream.asmMod()
        end, function() -- 71
            -- rem
            stream.asmLongMod()
        end, function() -- 72
            -- rem
            stream.asmMod()
        end, function() -- 73
            -- rem
            stream.asmMod()
        end, function() -- 74
            -- neg
            local r1 = stream.peek(0)
            local k = stream.allocRK(-1)
            stream.MUL(r1, r1, k)
            stream.freeRK(k)
        end, function() -- 75
            -- lneg
            local rmul, rarg, rk = stream.peek(0), stream.alloc(2)
            stream.asmGetObj(rk, bigint(-1))
            stream.MOVE(rarg, rmul)
            stream.asmGetObj(rmul, bigintMul)
            stream.CALL(rmul, 3, 2)
            stream.free(2)
        end, function() -- 76
            -- neg
            local r1 = stream.peek(0)
            local k = stream.allocRK(-1)
            stream.MUL(r1, r1, k)
            stream.freeRK(k)
        end, function() -- 77
            -- neg
            local r1 = stream.peek(0)
            local k = stream.allocRK(-1)
            stream.MUL(r1, r1, k)
            stream.freeRK(k)
        end, function() -- 78
            -- shl
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.lshift)
            stream.CALL(r1, 3, 2)
            stream.free(2)
        end, function() -- 79
            -- shl
            -- x * n^s
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            local k = stream.allocRK(2)
            stream.POW(r3, k, r1)
            stream.asmGetObj(r1, bigintMul)
            stream.CALL(r1, 3, 2)
            stream.freeRK(k)
            stream.free(2)
        end, function() -- 7A
            -- shr
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.arshift)
            stream.CALL(r1, 3, 2)
            stream.free(2)
        end, function() -- 7B
            -- shr
            -- x / n^s
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            local k2, k0 = stream.allocRK(2, 0)

            -- Check if bit shift is zero.
            stream.EQ(1, r1, zero)
            local ifZero = stream.startJump()

            stream.POW(r3, two, r1)
            stream.asmGetObj(r1, bigintDiv)
            stream.CALL(r1, 3, 2)

            -- Skip zero handling code.
            local skip = stream.startJump()

            -- Do nothing if shifting by zero.
            stream.fixJump(ifZero)
            stream.MOVE(r2, r1)

            stream.fixJump(skip)

            stream.freeRK(k2, k0)
            stream.free(2)
        end, function() -- 7C
            -- ushr
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.rshift)
            stream.CALL(r1, 3, 2)
            stream.free(2)
        end, function() -- 7D
            error("7D not implemented")
        end, function() -- 7E
            -- and
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.band)
            stream.CALL(r1, 3, 2)
            stream.free(2)
        end, function() -- 7F
            error("7F not implemented")
        end, function() -- 80
            -- or
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.bor)
            stream.CALL(r1, 3, 2)
            stream.free(2)
            error("80 not implemented")
        end, function() -- 81
            error("81 not implemented")
        end, function() -- 82
            -- xor
            local r1 = stream.peek(1)
            local r2 = stream.peek(0)
            local r3 = stream.alloc()
            stream.MOVE(r3, r1)
            stream.asmGetObj(r1, asm.bxor)
            stream.CALL(r1, 3, 2)
            stream.free(2)
        end, function() -- 83
            error("83 not implemented")
        end, function() -- 84
            -- iinc
            local r = stream.u1() + 1
            local c = u1ToSignedByte(stream.u1())
            local k = stream.allocRK(c)
            stream.ADD(r, r, k)
            stream.freeRK(k)
        end, function() -- 85
            -- i2l
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, bigint)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 86
        end, function() -- 87
        end, function() -- 88
            -- l2i
            local rconv = stream.peek(0)
            local r1, r2 = stream.alloc(2)

            stream.MOVE(r1, rconv)                  -- Over/underflow.
            stream.asmGetObj(rconv, bigintAdd)
            stream.asmGetObj(r2, bigint(2147483648))
            stream.CALL(rconv, 3, 2)                -- Align to range 0 to 2^32-1

            stream.MOVE(r1, rconv)
            stream.asmGetObj(rconv, bigintMod)
            stream.asmGetObj(r2, bigint(4294967296))
            stream.CALL(rconv, 3, 2)                -- Wrap value.

            stream.MOVE(r1, rconv)
            stream.asmGetObj(rconv, bigintSub)
            stream.asmGetObj(r2, bigint(2147483648))
            stream.CALL(rconv, 3, 2)                -- Align to range -2^31 to 2^31-1
            
            stream.MOVE(r1, rconv)
            stream.asmGetObj(rconv, bigintToDouble)
            stream.CALL(rconv, 2, 2)                -- Convert to Lua number.
            
            stream.free(2)
        end, function() -- 89
            -- l2f
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, bigintToDouble)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 8A
            -- l2d
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, bigintToDouble)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 8B
            -- f2i
            local rconv = peek(0)
            local r = alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, math.floor)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 8C
            -- f2l
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, bigint)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 8D
            -- f2d
        end, function() -- 8E
            -- d2i
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, math.floor)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 8F
            -- d2l
            local rconv = stream.peek(0)
            local r = stream.alloc()
            stream.MOVE(r, rconv)
            stream.asmGetObj(rconv, bigint)
            stream.CALL(rconv, 2, 2)
            stream.free()
        end, function() -- 90
            -- d2f
        end, function() -- 91
            -- i2b
            local r = stream.peek(0)
            local k1, k2 = stream.allocRK(128, 256)
            stream.ADD(r, r, k1)
            stream.MOD(r, r, k2)
            stream.SUB(r, r, k1)
            stream.freeRK(k1, k2)
        end, function() -- 92
            -- i2c
            local r = stream.peek(0)
            local k = stream.allocRK(65536)
            stream.MOD(r, r, k)
            stream.freeRK(k)
        end, function() -- 93
            -- i2s
            local r = stream.peek(0)
            local k1, k2 = stream.allocRK(32768, 65536)
            stream.ADD(r, r, k1)
            stream.MOD(r, r, k2)
            stream.SUB(r, r, k1)
            stream.freeRK(k1, k2)
        end, function() -- 94
            -- lcmp
            stream.asmLongCompare()
        end, function() -- 95
            -- fcmpl/g
            stream.asmNumericCompare()
        end, function() -- 96
            -- fcmpl/g
            stream.asmNumericCompare()
        end, function() -- 97
            -- fcmpl/g
            stream.asmNumericCompare()
        end, function() -- 98
            -- fcmpl/g
            stream.asmNumericCompare()
        end, function() -- 99
            --ifeq
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.EQ(1, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9A
            --ifne
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.EQ(0, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9B
            --iflt
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.LT(1, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9C
            --ifge
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.LT(0, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9D
            --ifgt
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.LE(0, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9E
            --ifle
            local joffset = u2ToSignedShort(stream.u2())
            local k = stream.allocRK(0)
            stream.LE(1, stream.free(), k)
            stream.jumpByJOffset(joffset)
            stream.freeRK(k)
        end, function() -- 9F
            --if_icmpeq
            local joffset = u2ToSignedShort(stream.u2())
            stream.EQ(1, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A0
            --if_icmpne
            local joffset = u2ToSignedShort(stream.u2())
            stream.EQ(0, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A1
            --if_icmplt
            local joffset = u2ToSignedShort(stream.u2())
            stream.LT(1, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A2
            --if_icmpge
            local joffset = u2ToSignedShort(stream.u2())
            stream.LT(0, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A3
            --if_icmpgt
            local joffset = u2ToSignedShort(stream.u2())
            stream.LE(0, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A4
            --if_icmple
            local joffset = u2ToSignedShort(stream.u2())
            stream.LE(1, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A5
            --if_acmpeq
            local joffset = u2ToSignedShort(stream.u2())
            stream.EQ(1, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A6
            --if_acmpne
            local joffset = u2ToSignedShort(stream.u2())
            stream.EQ(0, stream.free(2))
            stream.jumpByJOffset(joffset)
        end, function() -- A7
            local joffset = u2ToSignedShort(stream.u2())
            stream.jumpByJOffset(joffset)
        end, function() -- A8
            error("A8 not implemented")
        end, function() -- A9
            error("A9 not implemented")
        end, function() -- AA
            -- tableswitch
            -- Unfortunately can't do any jump table optimization here since Lua doesn't
            -- have a dynamic jump instruction...
            local rkey = stream.free()
            local pc = stream.pc()

            -- Align to 4 bytes.
            local padding = 4 - pc % 4
            stream.pc(pc + padding)

            local default = stream.s4()
            local low = stream.s4()
            local high = stream.s4()
            local noffsets = high - low + 1

            for i = 1, noffsets do
                local offset = stream.s4()      -- offset to jump to if rkey == match
                local k = stream.allocRK(low + i - 1)
                stream.EQ(1, k, rkey)
                stream.jumpByJOffset(offset)
                stream.freeRK(k)
            end

            stream.jumpByJOffset(default)
        end, function() -- AB
            -- lookupswitch
            local rkey = stream.free()
            local pc = stream.pc()

            -- Align to 4 bytes.
            local padding = 4 - pc % 4
            stream.pc(pc + padding)

            local default = stream.s4()
            local npairs = stream.s4()

            for i = 1, npairs do
                local match = s4()              -- try to match this to the key
                local offset = stream.s4()      -- offset to jump to if rkey == match
                local k = stream.allocRK(low + i - 1)
                stream.EQ(1, k, rkey)
                stream.jumpByJOffset(offset)
                stream.freeRK(k)
            end

            stream.jumpByJOffset(default)
        end, function() -- AC
            stream.asmPopStackTrace()
            stream.RETURN(stream.free(), 2)
        end, function() -- AD
            stream.asmPopStackTrace()
            stream.RETURN(stream.free(), 2)
        end, function() -- AE
            stream.asmPopStackTrace()
            stream.RETURN(stream.free(), 2)
        end, function() -- AF
            stream.asmPopStackTrace()
            stream.RETURN(stream.free(), 2)
        end, function() -- B0
            stream.asmPopStackTrace()
            stream.RETURN(stream.free(), 2)
        end, function() -- B1
            stream.asmPopStackTrace()
            stream.RETURN(0, 1)
        end, function() -- B2
            -- getstatic
            local fr = cp[stream.u2()]
            local class = stream.resolveClass(fr.class_index)
            local name = cp[cp[fr.name_and_type_index].name_index].bytes
            local fi = class.fieldIndexByName[name]
            local r = stream.alloc()
            local kfi = stream.allocRK(fi)
            stream.asmGetObj(r, class.fields)
            stream.comment(class.name.."."..name)
            stream.GETTABLE(r, r, kfi)
            stream.freeRK(kfi)
        end, function() -- B3
            -- putstatic
            local fr = cp[stream.u2()]
            local class = stream.resolveClass(fr.class_index)
            local name = cp[cp[fr.name_and_type_index].name_index].bytes
            local fi = class.fieldIndexByName[name]
            local value = stream.peek(0)
            local r = stream.alloc()
            local kfi = stream.allocRK(fi)
            stream.asmGetObj(r, class.fields)
            stream.comment(class.name.."."..name)
            stream.SETTABLE(r, kfi, value)
            stream.freeRK(kfi)
            stream.free(2)
        end, function() -- B4
            -- getfield
            local fr = cp[stream.u2()]
            local name = cp[cp[fr.name_and_type_index].name_index].bytes
            local class = stream.resolveClass(fr.class_index)
            local fi = class.fieldIndexByName[name]
            local r = stream.peek(0)
            local k2, kfi = stream.allocRK(2, fi)

            stream.asmCheckNullPointer(r)

            stream.GETTABLE(r, r, k2)
            stream.comment(class.name.."."..name)
            stream.GETTABLE(r, r, kfi)
            stream.freeRK(k2, kfi)
        end, function() -- B5
            -- putfield
            local fr = cp[stream.u2()]
            local name = cp[cp[fr.name_and_type_index].name_index].bytes
            local class = stream.resolveClass(fr.class_index)
            local fi = class.fieldIndexByName[name]
            local robj = stream.peek(1)
            local rval = stream.peek(0)
            local k2, kfi = stream.allocRK(2, fi)

            stream.asmCheckNullPointer(robj)

            local rfields = stream.alloc()
            stream.GETTABLE(rfields, robj, k2)
            stream.comment(class.name.."."..name)
            stream.SETTABLE(rfields, kfi, rval)
            stream.freeRK(k2, kfi)
            stream.free(3)
        end, function() -- B6
            -- invokevirtual
            local mr = cp[stream.u2()]
            local cl = stream.resolveClass(mr.class_index)
            local name = cp[cp[mr.name_and_type_index].name_index].bytes .. cp[cp[mr.name_and_type_index].descriptor_index].bytes
            local mt, mIndex = findMethod(cl, name)
            local argslen = #mt.desc                                -- Stack: [x, objref, args...]

            stream.asmInvoke(argslen, cl.name.."."..name, mt.desc[#mt.desc].type == "V", function(rmt)
                local robj = rmt + 1
                stream.asmCheckNullPointer(robj)

                local k1, k3, kIndex = stream.allocRK(1, 3, mIndex)
                stream.GETTABLE(rmt, robj, k3)
                stream.GETTABLE(rmt, rmt, kIndex)
                stream.GETTABLE(rmt, rmt, k1)
                stream.freeRK(k1, k3, kIndex)
            end)
        end, function() -- B7
            -- invokespecial
            local mr = cp[stream.u2()]
            local cl = stream.resolveClass(mr.class_index)
            local name = cp[cp[mr.name_and_type_index].name_index].bytes .. cp[cp[mr.name_and_type_index].descriptor_index].bytes
            local mt = findMethod(cl, name)
            local argslen = #mt.desc                                -- Stack: [x, objref, args...]

            stream.asmInvoke(argslen, cl.name.."."..name, mt.desc[#mt.desc].type == "V", function(rmt)
                local robj = rmt + 1
                stream.asmCheckNullPointer(robj)
                stream.asmGetObj(rmt, mt[1])
            end)
        end, function() -- B8
            -- invokestatic
            local mr = cp[stream.u2()]
            local cl = stream.resolveClass(mr.class_index)
            local name = cp[cp[mr.name_and_type_index].name_index].bytes .. cp[cp[mr.name_and_type_index].descriptor_index].bytes
            local mt, mIndex = findMethod(cl, name)
            local argslen = #mt.desc - 1                            -- Stack: [x, objref, args...]

            stream.asmInvoke(argslen, cl.name.."."..name, mt.desc[#mt.desc].type == "V", function(rmt)
                stream.asmGetObj(rmt, mt[1])
            end)
        end, function() -- B9
            -- invokeinterface
            local mr = cp[stream.u2()]
            stream.u2()
            local cl = stream.resolveClass(mr.class_index)
            local name = cp[cp[mr.name_and_type_index].name_index].bytes .. cp[cp[mr.name_and_type_index].descriptor_index].bytes
            local mt, mIndex = findMethod(cl, name)
            local argslen = #mt.desc                                -- Stack: [x, objref, args...]

            stream.asmInvoke(argslen, cl.name.."."..name, mt.desc[#mt.desc].type == "V", function(rmt)
                local robj = rmt + 1
                stream.asmCheckNullPointer(robj)

                local find, rcl, rname = stream.alloc(3)
                local k1 = stream.allocRK(1)
                stream.asmGetObj(find, findMethod)
                stream.GETTABLE(rcl, robj, k1)
                stream.asmGetObj(rname, name)
                stream.CALL(find, 3, 2)
                stream.MOVE(rmt, find)
                stream.free(3)
                stream.GETTABLE(rmt, rmt, k1)
                stream.freeRK(k1)
            end)
        end, function() -- BA
            error("BA not implemented")
        end, function() -- BB
            -- new
            local c = stream.resolveClass(stream.u2())
            local robj = stream.alloc()
            stream.asmNewInstance(robj, c)
        end, function() -- BC
            -- newarray
            local cn = "["..ARRAY_TYPES[stream.u1()]
            local class = getArrayClass(cn)

            local rlength = stream.peek(0)
            local robj = stream.alloc()
            stream.asmNewPrimitiveArray(robj, rlength, class)
            --put array in expected register
            stream.MOVE(rlength, robj)
            stream.free()
        end, function() -- BD
            -- anewarray
            local cn = "[L"..cp[cp[stream.u2()].name_index].bytes:gsub("/",".")..";"
            local class = getArrayClass(cn)

            local rlength = stream.peek(0)
            local robj = stream.alloc()
            stream.asmNewArray(robj, rlength, class)
            --put array in expected register
            stream.MOVE(rlength, robj)
            stream.free()
        end, function() -- BE
            -- arraylength
            local r = stream.peek(0)
            local k4 = stream.allocRK(4)
            stream.GETTABLE(r, r, k4)
            stream.freeRK(k4)
        end, function() -- BF
            -- athrow
            local rexception = stream.peek(0)
            stream.asmRefillStackTrace(rexception)
            stream.asmThrow(rexception)
        end, function() -- C0
            -- checkcast
            local c = stream.resolveClass(stream.u2())
            local r = stream.peek(0)
            local rInstanceof = stream.alloc()
            stream.MOVE(rInstanceof, r)
            stream.asmInstanceOf(rInstanceof, c)


            local k0 = stream.allocRK(0)
            stream.EQ(0, rInstanceof, k0)
            stream.freeRK(k0)
            local jid = stream.startJump()

            local ccException = classByName("java.lang.ClassCastException")
            local con = findMethod(ccException, "<init>(Ljava/lang/String;)V")

            local rexc, rcon, rpexc, rmsg = stream.alloc(4)

            stream.asmNewInstance(rexc, ccException)
            stream.asmLoadJString(rmsg, " cannot be cast to " .. c.name)
            stream.asmGetObj(rcon, con[1])
            stream.MOVE(rpexc, rexc)
            stream.CALL(rcon, 3, 3)

            stream.asmRefillStackTrace(rexc)
            stream.asmThrow(rexc)
            stream.fixJump(jid)
            stream.free(5)
        end, function() -- C1
            -- instanceof
            stream.asmInstanceOf(stream.peek(0), stream.resolveClass(stream.u2()))
        end, function() -- C2
            error("C2 not implemented")
        end, function() -- C3
            error("C3 not implemented")
        end, function() -- C4
            error("C4 not implemented")
        end, function() -- C5
            error("C5 not implemented")
        end, function() -- C6
            -- ifnull
            local joffset = u2ToSignedShort(stream.u2())
            local rvalue = stream.free()
            local knil = stream.allocNilRK()
            stream.EQ(1, rvalue, knil)
            stream.freeRK(knil)
            stream.jumpByJOffset(joffset)
        end, function() -- C7
            -- ifnonnull
            local joffset = u2ToSignedShort(stream.u2())
            local rvalue = stream.free()
            local knil = stream.allocNilRK()
            stream.EQ(0, rvalue, knil)
            stream.freeRK(knil)
            stream.jumpByJOffset(joffset)
        end, function() -- C8
            error("C8 not implemented")
        end, function() -- C9
            error("C9 not implemented")
        end, function() -- CA
            error("CA not implemented")
        end, function() -- CB
            error("CB not implemented")
        end, function() -- CC
            error("CC not implemented")
        end, function() -- CD
            error("CD not implemented")
        end, function() -- CE
            error("CE not implemented")
        end, function() -- CF
            error("CF not implemented")
        end, function() -- D0
            error("D0 not implemented")
        end, function() -- D1
            error("D1 not implemented")
        end, function() -- D2
            error("D2 not implemented")
        end, function() -- D3
            error("D3 not implemented")
        end, function() -- D4
            error("D4 not implemented")
        end, function() -- D5
            error("D5 not implemented")
        end, function() -- D6
            error("D6 not implemented")
        end, function() -- D7
            error("D7 not implemented")
        end, function() -- D8
            error("D8 not implemented")
        end, function() -- D9
            error("D9 not implemented")
        end, function() -- DA
            error("DA not implemented")
        end, function() -- DB
            error("DB not implemented")
        end, function() -- DC
            error("DC not implemented")
        end, function() -- DD
            error("DD not implemented")
        end, function() -- DE
            error("DE not implemented")
        end, function() -- DF
            error("DF not implemented")
        end, function() -- E0
            error("E0 not implemented")
        end, function() -- E1
            error("E1 not implemented")
        end, function() -- E2
            error("E2 not implemented")
        end, function() -- E3
            error("E3 not implemented")
        end, function() -- E4
            error("E4 not implemented")
        end, function() -- E5
            error("E5 not implemented")
        end, function() -- E6
            error("E6 not implemented")
        end, function() -- E7
            error("E7 not implemented")
        end, function() -- E8
            error("E8 not implemented")
        end, function() -- E9
            error("E9 not implemented")
        end, function() -- EA
            error("EA not implemented")
        end, function() -- EB
            error("EB not implemented")
        end, function() -- EC
            error("EC not implemented")
        end, function() -- ED
            error("ED not implemented")
        end, function() -- EE
            error("EE not implemented")
        end, function() -- EF
            error("EF not implemented")
        end, function() -- F0
            error("F0 not implemented")
        end, function() -- F1
            error("F1 not implemented")
        end, function() -- F2
            error("F2 not implemented")
        end, function() -- F3
            error("F3 not implemented")
        end, function() -- F4
            error("F4 not implemented")
        end, function() -- F5
            error("F5 not implemented")
        end, function() -- F6
            error("F6 not implemented")
        end, function() -- F7
            error("F7 not implemented")
        end, function() -- F8
            error("F8 not implemented")
        end, function() -- F9
            error("F9 not implemented")
        end, function() -- FA
            error("FA not implemented")
        end, function() -- FB
            error("FB not implemented")
        end, function() -- FC
            error("FC not implemented")
        end, function() -- FD
            error("FD not implemented")
        end, function() -- FE
            error("FE not implemented")
        end, function() -- FF
            error("FF not implemented")
        end
    }

    local startTime = os.time() / 0.02

    stream.asmPushStackTrace()
    local instruction = stream.u1()
    while instruction do
        checkIn()
        stream.annotate(string.format("[%d] %X:", stream.pc(), instruction))
        stream.beginJavaInstruction(instruction)
        oplookup[instruction]()
        instruction = stream.u1()
    end

    local emitAssemblyTime = os.time() / 0.02

    local compiledCode = stream.compile(asm.getDefaultPlatform(), class.name .. "." .. method.name.."/bytecode")

    local compileEndTime = os.time() / 0.02

    debugH.write(class.name .. "." .. method.name .. "\n")
    debugH.write("Length: " .. (stream.getInstructionCount() - 1) .. "\n")
    debugH.write("Locals: " .. codeAttr.max_locals .. "\n")

    debugH.write(stream.getDebugCode())

    TIME_SPENT_EMITTING_ASSEMBLY = TIME_SPENT_EMITTING_ASSEMBLY + (emitAssemblyTime - startTime)
    TIME_SPENT_COMPILING_LASM = TIME_SPENT_COMPILING_LASM + (compileEndTime - emitAssemblyTime)
    debugH.write("Emit Assembly:\t" .. (emitAssemblyTime - startTime) .. "\n")
    debugH.write("Compile LASM:\t" .. (compileEndTime - emitAssemblyTime) .. "\n\n")

    debugH.flush()

    local f = loadstring(compiledCode)
    --local fh = fs.open(fs.combine(jcd, "debug_stuff/" .. (class.name .. "." .. method.name):gsub("/", ".")), "wb")
    --for i=1,#compiledCode do
    --    fh.write(compiledCode:byte(i,i))
    --end
    --fh.close()
    return f, stream.getRTI()
end

function createCodeFunction(class, method, codeAttr, cp)
    local f
    local rti
    local isCompiling = false
    return function(...)
        if not f then
            assert(not isCompiling, "Recursively compiling " ..class.name.."."..method.name, 0)
            isCompiling = true
            f, rti = compile(class, method, codeAttr, cp)
            isCompiling = false
        end
        return f(rti, ...)
    end
end