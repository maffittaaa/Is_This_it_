ghostsPos = {}
valkyriesPos = {}

function LoadAllEnmenies(world)
    --valquirias first Patroling Position
    valkyriesPos[1] = { x = 45 * 32, y = 128 * 32 }
    valkyriesPos[2] = { x = 133 * 32, y = 90 * 32 }
    valkyriesPos[3] = { x = 204 * 32, y = 50 * 32 }
    --valkyriesPos[4] = { x = 77 * 32, y = 223 * 32 }

    --valquirias final Patroling Position
    valkyriesPos[4] = { x = 56 * 32, y = 128 * 32 }
    valkyriesPos[5] = { x = 149 * 32, y = 90 * 32 }
    valkyriesPos[6] = { x = 216 * 32, y = 50 * 32 }
    --valkyriesPos[8] = { x = 145 * 32, y = 223 * 32 }


    --ghosts first Patroling Position

    -- NPCs
    ghostsPos[1] = { x = 42 * 32, y = 57 * 32 }
    ghostsPos[2] = { x = 40 * 32, y = 60 * 32 }
    ghostsPos[3] = { x = 33 * 32, y = 63 * 32 }
    ghostsPos[4] = { x = 36 * 32, y = 66 * 32 }
    
    ghostsPos[5] = {x = 113 * 32, y = 48 * 32}
    ghostsPos[6] = { x = 112 * 32, y = 52 * 32 }
    ghostsPos[7] = { x = 110 * 32, y = 55 * 32 }
    ghostsPos[8] = { x = 105 * 32, y = 58 * 32 }

    ghostsPos[9] = { x = 100 * 32, y = 84 * 32 }
    ghostsPos[10] = { x = 96 * 32, y = 86 * 32 }
    ghostsPos[11] = { x = 93 * 32, y = 89 * 32 }
    ghostsPos[12] = { x = 88 * 32, y = 93 * 32 }
    ghostsPos[13] = { x = 88 * 32, y = 97 * 32 }

    ghostsPos[14] = { x = 136 * 32, y = 30 * 32 }
    ghostsPos[15] = { x = 134 * 32, y = 33 * 32 }
    ghostsPos[16] = { x = 133 * 32, y = 36 * 32 }
    ghostsPos[17] = { x = 130 * 32, y = 39 * 32 }

    ghostsPos[18] = { x = 35 * 32, y = 85 * 32 }
    ghostsPos[19] = { x = 33 * 32, y = 91 * 32 }
    ghostsPos[20] = { x = 36 * 32, y = 96 * 32 }

    -- Enemys map
    ghostsPos[21] = { x = 23 * 32, y = 145 * 32 }
    ghostsPos[22] = { x = 35 * 32, y = 154 * 32 }
    ghostsPos[23] = { x = 23 * 32, y = 156 * 32 }

    ghostsPos[24] = { x = 77 * 32, y = 152 * 32 }
    ghostsPos[25] = { x = 97 * 32, y = 118 * 32 }

    ghostsPos[26] = { x = 193 * 32, y = 107 * 32 }

    ghostsPos[27] = { x = 191 * 32, y = 110 * 32 }
    ghostsPos[28] = { x = 187 * 32, y = 115 * 32 }
    ghostsPos[29] = { x = 209 * 32, y = 102 * 32 }

    ghostsPos[30] = { x = 186 * 32, y = 71 * 32 }

    ghostsPos[31] = { x = 157 * 32, y = 86 * 32 }

    -- Enemys Masmorra
    ghostsPos[32] = {x = 43 * 32, y = 205 * 32 }
    ghostsPos[33] = {x = 43 * 32, y = 223 * 32 }
    ghostsPos[34] = {x = 33 * 32, y = 241 * 32 }
    ghostsPos[35] = {x = 33 * 32, y = 259 * 32 }

    --ghosts final Patroling Position

    -- NPCs
    ghostsPos[36] = { x = 58 * 32, y = 57 * 32}
    ghostsPos[37] = { x = 58 * 32, y = 60 * 32}
    ghostsPos[38] = { x = 56 * 32, y = 60 * 32}
    ghostsPos[39] = { x = 52 * 32, y = 65 * 32}
    
    ghostsPos[40] = {x = 130 * 32, y = 48 * 32 }
    ghostsPos[41] = { x = 130 * 32, y = 52 * 32 }
    ghostsPos[42] = { x = 130 * 32, y = 55 * 32 }
    ghostsPos[43] = { x = 130 * 32, y = 58 * 32 }

    ghostsPos[44] = { x = 123 * 32, y = 84 * 32 }
    ghostsPos[45] = { x = 120 * 32, y = 86 * 32 }
    ghostsPos[46] = { x = 117 * 32, y = 89 * 32 }
    ghostsPos[47] = { x = 114 * 32, y = 93 * 32 }
    ghostsPos[48] = { x = 108 * 32, y = 97 * 32 }

    ghostsPos[49] = { x = 154 * 32, y = 30 * 32 }
    ghostsPos[50] = { x = 156 * 32, y = 33 * 32 }
    ghostsPos[51] = { x = 156 * 32, y = 36 * 32 }
    ghostsPos[52] = { x = 154 * 32, y = 39 * 32 }

    ghostsPos[53] = { x = 47 * 32, y = 85 * 32 }
    ghostsPos[54] = { x = 47 * 32, y = 91 * 32 }
    ghostsPos[55] = { x = 45 * 32, y = 96 * 32 }

    -- Enemys map
    ghostsPos[56] = { x = 36 * 32, y = 145 * 32 }
    ghostsPos[57] = { x = 44 * 32, y = 154 * 32 }
    ghostsPos[58] = { x = 34 * 32, y = 156 * 32 }

    ghostsPos[59] = { x = 90 * 32, y = 152 * 32 }
    ghostsPos[60] = { x = 110 * 32, y = 118 * 32 }

    ghostsPos[61] = { x = 202 * 32, y = 107 * 32 }

    ghostsPos[62] = { x = 207 * 32, y = 110 * 32 }
    ghostsPos[63] = { x = 208 * 32, y = 115 * 32 }
    ghostsPos[64] = { x = 218 * 32, y = 102 * 32 }

    ghostsPos[65] = { x = 193 * 32, y = 71 * 32 }

    ghostsPos[66] = { x = 162 * 32, y = 86 * 32 }

    -- Enemys Masmorra
    ghostsPos[67] = {x = 97 * 32, y = 205 * 32 }
    ghostsPos[68] = {x = 97 * 32, y = 223 * 32 }
    ghostsPos[69] = {x = 146 * 32, y = 241 * 32 }
    ghostsPos[70] = {x = 77 * 32, y = 259 * 32 }


    for i = 1, #ghostsPos/2, 1 do
        ghosts[i] = LoadGhost(world, ghostsPos[i].x, ghostsPos[i].y, i)
    end

    for i = 1, #valkyriesPos/2, 1 do
        valkyries[i] = LoadValquiria(world, valkyriesPos[i].x, valkyriesPos[i].y, i)
    end
    valkeries_quantity = #valkyries
end