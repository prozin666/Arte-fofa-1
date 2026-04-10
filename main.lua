-- ======================
-- PIXEL PAINTER CENTRAL (DELTA) - Versão Melhorada
-- GUI mais bonita + Scroll corrigido + Anti-Morte
-- ======================

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:FindFirstChild("UpdateBoard")
    or game.Workspace:FindFirstChild("UpdateBoard", true)

local GRID = 32
local TOTAL = GRID * GRID

-- ======================
-- UTIL: índice lógico -> board (espelho X)
-- ======================
local function logicalToBoardIndex(pixel)
    local zero = pixel - 1
    local y = math.floor(zero / GRID)
    local x = zero % GRID
    local flippedX = (GRID - 1) - x
    return y * GRID + flippedX + 1
end

-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇
local ARTS = {
    {
        name = "Sucubu",
        map = [[
Pixel 1 (0,0) = D7C7B5 | Pixel 2 (1,0) = D8C9B7 | Pixel 3 (2,0) = DCCCBA | Pixel 4 (3,0) = E2D2BE | Pixel 5 (4,0) = E6D5C1 | Pixel 6 (5,0) = EBD9C3 | Pixel 7 (6,0) = EEDCC7 | Pixel 8 (7,0) = B5362F | Pixel 9 (8,0) = 83191A | Pixel 10 (9,0) = 351413 | Pixel 11 (10,0) = 2C0D11 | Pixel 12 (11,0) = 23080E | Pixel 13 (12,0) = 24060F | Pixel 14 (13,0) = 69121A | Pixel 15 (14,0) = AC252C | Pixel 16 (15,0) = BA3138 | Pixel 17 (16,0) = 8A1522 | Pixel 18 (17,0) = 83141E | Pixel 19 (18,0) = 391316 | Pixel 20 (19,0) = 3A1715 | Pixel 21 (20,0) = 3E1B16 | Pixel 22 (21,0) = 421D18 | Pixel 23 (22,0) = 442016 | Pixel 24 (23,0) = 4A2216 | Pixel 25 (24,0) = EFDFCA | Pixel 26 (25,0) = EDDCC8 | Pixel 27 (26,0) = E9D8C5 | Pixel 28 (27,0) = E4D5C1 | Pixel 29 (28,0) = E0D0BE | Pixel 30 (29,0) = DCCDBB | Pixel 31 (30,0) = D8CAB7 | Pixel 32 (31,0) = D2C7B4
Pixel 33 (0,1) = D8C9B6 | Pixel 34 (1,1) = DDCDB9 | Pixel 35 (2,1) = E2D1BD | Pixel 36 (3,1) = E7D6C1 | Pixel 37 (4,1) = EBD9C5 | Pixel 38 (5,1) = F0DEC8 | Pixel 39 (6,1) = C9433A | Pixel 40 (7,1) = BE3A35 | Pixel 41 (8,1) = 8A1C1E | Pixel 42 (9,1) = 450D0C | Pixel 43 (10,1) = 280A0D | Pixel 44 (11,1) = 4D191C | Pixel 45 (12,1) = 2D0911 | Pixel 46 (13,1) = 340A14 | Pixel 47 (14,1) = 971426 | Pixel 48 (15,1) = B4292F | Pixel 49 (16,1) = B82D33 | Pixel 50 (17,1) = BA2E31 | Pixel 51 (18,1) = 3E1019 | Pixel 52 (19,1) = 3F1718 | Pixel 53 (20,1) = 3F1818 | Pixel 54 (21,1) = 411B17 | Pixel 55 (22,1) = 51201D | Pixel 56 (23,1) = 482218 | Pixel 57 (24,1) = 53251B | Pixel 58 (25,1) = F2E1CC | Pixel 59 (26,1) = EEDDC9 | Pixel 60 (27,1) = EBD9C6 | Pixel 61 (28,1) = E7D6C3 | Pixel 62 (29,1) = E2D1BE | Pixel 63 (30,1) = DCCCBA | Pixel 64 (31,1) = D6C8B6
Pixel 65 (0,2) = DDCCB9 | Pixel 66 (1,2) = E1D0BD | Pixel 67 (2,2) = E6D5C0 | Pixel 68 (3,2) = ECDAC4 | Pixel 69 (4,2) = F0DDC8 | Pixel 70 (5,2) = F3E0CB | Pixel 71 (6,2) = BA382E | Pixel 72 (7,2) = D64D43 | Pixel 73 (8,2) = B6302C | Pixel 74 (9,2) = 901922 | Pixel 75 (10,2) = 4D181B | Pixel 76 (11,2) = 50191E | Pixel 77 (12,2) = 50161E | Pixel 78 (13,2) = 4C141D | Pixel 79 (14,2) = 931427 | Pixel 80 (15,2) = A0162A | Pixel 81 (16,2) = B11F31 | Pixel 82 (17,2) = AF1F30 | Pixel 83 (18,2) = A31D2E | Pixel 84 (19,2) = 421318 | Pixel 85 (20,2) = 4E1F1E | Pixel 86 (21,2) = 421516 | Pixel 87 (22,2) = 581F1E | Pixel 88 (23,2) = 4D2019 | Pixel 89 (24,2) = 54231B | Pixel 90 (25,2) = 662E22 | Pixel 91 (26,2) = F3E0CC | Pixel 92 (27,2) = EFDDC8 | Pixel 93 (28,2) = EBD8C5 | Pixel 94 (29,2) = E5D5C1 | Pixel 95 (30,2) = E1D0BD | Pixel 96 (31,2) = DCCBB9
Pixel 97 (0,3) = E0CFBC | Pixel 98 (1,3) = E7D5C0 | Pixel 99 (2,3) = EBD9C3 | Pixel 100 (3,3) = F6F7E5 | Pixel 101 (4,3) = F3E0CA | Pixel 102 (5,3) = F7E3CD | Pixel 103 (6,3) = B23128 | Pixel 104 (7,3) = 941F1E | Pixel 105 (8,3) = B12A2A | Pixel 106 (9,3) = 8B2E33 | Pixel 107 (10,3) = 5A1A1E | Pixel 108 (11,3) = 5A181F | Pixel 109 (12,3) = 59151E | Pixel 110 (13,3) = 5B151F | Pixel 111 (14,3) = 5A131F | Pixel 112 (15,3) = 9E192D | Pixel 113 (16,3) = A41C30 | Pixel 114 (17,3) = A61E31 | Pixel 115 (18,3) = A4202F | Pixel 116 (19,3) = 461019 | Pixel 117 (20,3) = 591D1F | Pixel 118 (21,3) = 5E2322 | Pixel 119 (22,3) = 5C1D1F | Pixel 120 (23,3) = 461A17 | Pixel 121 (24,3) = 4A1F18 | Pixel 122 (25,3) = 53271C | Pixel 123 (26,3) = F5E2CE | Pixel 124 (27,3) = F3E0CC | Pixel 125 (28,3) = EEDDC8 | Pixel 126 (29,3) = EBD7C3 | Pixel 127 (30,3) = E5D4C0 | Pixel 128 (31,3) = E0CEBC
Pixel 129 (0,4) = E4D3BE | Pixel 130 (1,4) = E8D7C2 | Pixel 131 (2,4) = EDDBC5 | Pixel 132 (3,4) = F8F7E5 | Pixel 133 (4,4) = F6E3CE | Pixel 134 (5,4) = F9E5CF | Pixel 135 (6,4) = 451809 | Pixel 136 (7,4) = A82227 | Pixel 137 (8,4) = A22028 | Pixel 138 (9,4) = 5C1A1B | Pixel 139 (10,4) = 661A21 | Pixel 140 (11,4) = 661821 | Pixel 141 (12,4) = 711925 | Pixel 142 (13,4) = 811E2B | Pixel 143 (14,4) = 922334 | Pixel 144 (15,4) = 490416 | Pixel 145 (16,4) = A71F2F | Pixel 146 (17,4) = A82032 | Pixel 147 (18,4) = A81F31 | Pixel 148 (19,4) = 7F0B22 | Pixel 149 (20,4) = 751B2C | Pixel 150 (21,4) = 7F2A30 | Pixel 151 (22,4) = 863435 | Pixel 152 (23,4) = 5A1C1E | Pixel 153 (24,4) = 481C18 | Pixel 154 (25,4) = 482018 | Pixel 155 (26,4) = 5D271E | Pixel 156 (27,4) = F7E2CE | Pixel 157 (28,4) = F2DFCB | Pixel 158 (29,4) = EFDAC7 | Pixel 159 (30,4) = EAD7C4 | Pixel 160 (31,4) = E3D1BD
Pixel 161 (0,5) = E8D4C0 | Pixel 162 (1,5) = EEDAC4 | Pixel 163 (2,5) = F1DEC8 | Pixel 164 (3,5) = F5E2CC | Pixel 165 (4,5) = F9E4CF | Pixel 166 (5,5) = FBE7D1 | Pixel 167 (6,5) = 431507 | Pixel 168 (7,5) = A12427 | Pixel 169 (8,5) = A3232B | Pixel 170 (9,5) = 6E1D20 | Pixel 171 (10,5) = A62E3A | Pixel 172 (11,5) = A82A3A | Pixel 173 (12,5) = A62938 | Pixel 174 (13,5) = AA293B | Pixel 175 (14,5) = AB2A3C | Pixel 176 (15,5) = 4C0515 | Pixel 177 (16,5) = 400713 | Pixel 178 (17,5) = AB2033 | Pixel 179 (18,5) = AA1F32 | Pixel 180 (19,5) = A71F31 | Pixel 181 (20,5) = 260308 | Pixel 182 (21,5) = 9C3136 | Pixel 183 (22,5) = 5E1C20 | Pixel 184 (23,5) = 4B1319 | Pixel 185 (24,5) = A92A27 | Pixel 186 (25,5) = 491A17 | Pixel 187 (26,5) = 50261C | Pixel 188 (27,5) = F8E4CF | Pixel 189 (28,5) = F6E1CD | Pixel 190 (29,5) = F1DEC9 | Pixel 191 (30,5) = EDD9C4 | Pixel 192 (31,5) = E7D4C1
Pixel 193 (0,6) = ECD9C3 | Pixel 194 (1,6) = F0DDC7 | Pixel 195 (2,6) = F9F8E2 | Pixel 196 (3,6) = F9E3CF | Pixel 197 (4,6) = FBE5D2 | Pixel 198 (5,6) = FCE7D2 | Pixel 199 (6,6) = 661F1A | Pixel 200 (7,6) = 5A1513 | Pixel 201 (8,6) = A7252D | Pixel 202 (9,6) = 901D2E | Pixel 203 (10,6) = AC2B39 | Pixel 204 (11,6) = AE283A | Pixel 205 (12,6) = 8A1B2C | Pixel 206 (13,6) = 4C0515 | Pixel 207 (14,6) = 450313 | Pixel 208 (15,6) = 450512 | Pixel 209 (16,6) = 580A1A | Pixel 210 (17,6) = A31C30 | Pixel 211 (18,6) = 830D23 | Pixel 212 (19,6) = 941629 | Pixel 213 (20,6) = 6D071D | Pixel 214 (21,6) = 500D19 | Pixel 215 (22,6) = 631821 | Pixel 216 (23,6) = 72131A | Pixel 217 (24,6) = 840F1A | Pixel 218 (25,6) = 4A1918 | Pixel 219 (26,6) = 50231A | Pixel 220 (27,6) = F9E4D0 | Pixel 221 (28,6) = F8E2CF | Pixel 222 (29,6) = F3DFCB | Pixel 223 (30,6) = F0DCC8 | Pixel 224 (31,6) = EBD7C3
Pixel 225 (0,7) = EFDAC4 | Pixel 226 (1,7) = F4E0C9 | Pixel 227 (2,7) = F6E3CC | Pixel 228 (3,7) = FAE5D0 | Pixel 229 (4,7) = FCE7D1 | Pixel 230 (5,7) = FBE7D3 | Pixel 231 (6,7) = 7B2620 | Pixel 232 (7,7) = 822323 | Pixel 233 (8,7) = AC272E | Pixel 234 (9,7) = 741422 | Pixel 235 (10,7) = 5D0D19 | Pixel 236 (11,7) = 5B0B1A | Pixel 237 (12,7) = 620D1D | Pixel 238 (13,7) = 680E20 | Pixel 239 (14,7) = 660E1F | Pixel 240 (15,7) = 520C16 | Pixel 241 (16,7) = 660D20 | Pixel 242 (17,7) = 931524 | Pixel 243 (18,7) = 5E1107 | Pixel 244 (19,7) = DF6118 | Pixel 245 (20,7) = 78415A | Pixel 246 (21,7) = 5F121E | Pixel 247 (22,7) = 591D20 | Pixel 248 (23,7) = 450813 | Pixel 249 (24,7) = 4A0F15 | Pixel 250 (25,7) = 441213 | Pixel 251 (26,7) = 431512 | Pixel 252 (27,7) = FBE5D1 | Pixel 253 (28,7) = FAE5D0 | Pixel 254 (29,7) = F5E2CD | Pixel 255 (30,7) = F4DECA | Pixel 256 (31,7) = EDD9C6
Pixel 257 (0,8) = EFDBC7 | Pixel 258 (1,8) = F4E1CB | Pixel 259 (2,8) = F9E2CE | Pixel 260 (3,8) = FBE6D1 | Pixel 261 (4,8) = FCE8D2 | Pixel 262 (5,8) = FEEFDC | Pixel 263 (6,8) = 90312C | Pixel 264 (7,8) = 7C1E20 | Pixel 265 (8,8) = AB232E | Pixel 266 (9,8) = A51F2D | Pixel 267 (10,8) = 8D1324 | Pixel 268 (11,8) = 260208 | Pixel 269 (12,8) = AE1D32 | Pixel 270 (13,8) = 620A1D | Pixel 271 (14,8) = B31E35 | Pixel 272 (15,8) = B21C32 | Pixel 273 (16,8) = 820C1F | Pixel 274 (17,8) = D0A2CE | Pixel 275 (18,8) = F9B438 | Pixel 276 (19,8) = FAF747 | Pixel 277 (20,8) = 7D1D16 | Pixel 278 (21,8) = 61101C | Pixel 279 (22,8) = 551A1F | Pixel 280 (23,8) = 3A080F | Pixel 281 (24,8) = 56141A | Pixel 282 (25,8) = 4E1618 | Pixel 283 (26,8) = 5A1B19 | Pixel 284 (27,8) = 642721 | Pixel 285 (28,8) = FBE5D1 | Pixel 286 (29,8) = F8E2CF | Pixel 287 (30,8) = F5DFCC | Pixel 288 (31,8) = EFDCC7
Pixel 289 (0,9) = F1DDC8 | Pixel 290 (1,9) = F6E1CC | Pixel 291 (2,9) = FAE4CE | Pixel 292 (3,9) = FBE7D1 | Pixel 293 (4,9) = FCE8D1 | Pixel 294 (5,9) = 6C1F19 | Pixel 295 (6,9) = 992A2D | Pixel 296 (7,9) = 8F2528 | Pixel 297 (8,9) = 360907 | Pixel 298 (9,9) = 2B0506 | Pixel 299 (10,9) = 4D0E08 | Pixel 300 (11,9) = 8C2613 | Pixel 301 (12,9) = 930C1D | Pixel 302 (13,9) = DB3E43 | Pixel 303 (14,9) = DB3E44 | Pixel 304 (15,9) = D93C43 | Pixel 305 (16,9) = CC9FCD | Pixel 306 (17,9) = F6EFF3 | Pixel 307 (18,9) = D63D3E | Pixel 308 (19,9) = C42C37 | Pixel 309 (20,9) = 580817 | Pixel 310 (21,9) = 5A0C19 | Pixel 311 (22,9) = 651020 | Pixel 312 (23,9) = 540D1A | Pixel 313 (24,9) = 5A161A | Pixel 314 (25,9) = 480E12 | Pixel 315 (26,9) = 4E1816 | Pixel 316 (27,9) = 602017 | Pixel 317 (28,9) = FBE6D2 | Pixel 318 (29,9) = FAE4D0 | Pixel 319 (30,9) = F6E1CD | Pixel 320 (31,9) = F2DDC9
Pixel 321 (0,10) = F2DECA | Pixel 322 (1,10) = F7E2CE | Pixel 323 (2,10) = FAE6D0 | Pixel 324 (3,10) = 471A06 | Pixel 325 (4,10) = FAE3D0 | Pixel 326 (5,10) = FCE8D3 | Pixel 327 (6,10) = 9A292D | Pixel 328 (7,10) = 781E1F | Pixel 329 (8,10) = 570C15 | Pixel 330 (9,10) = 7D1921 | Pixel 331 (10,10) = FEEFEE | Pixel 332 (11,10) = D01C24 | Pixel 333 (12,10) = F9A32D | Pixel 334 (13,10) = AA202D | Pixel 335 (14,10) = D23542 | Pixel 336 (15,10) = D23642 | Pixel 337 (16,10) = D43741 | Pixel 338 (17,10) = D33340 | Pixel 339 (18,10) = CE3240 | Pixel 340 (19,10) = CD313E | Pixel 341 (20,10) = 490313 | Pixel 342 (21,10) = 5B0A1B | Pixel 343 (22,10) = 420711 | Pixel 344 (23,10) = 500B17 | Pixel 345 (24,10) = 4A0E14 | Pixel 346 (25,10) = 5E1C1C | Pixel 347 (26,10) = 5A1F1C | Pixel 348 (27,10) = 481412 | Pixel 349 (28,10) = FCE7D4 | Pixel 350 (29,10) = FBE4D2 | Pixel 351 (30,10) = F8E3CF | Pixel 352 (31,10) = F3DECB
Pixel 353 (0,11) = F4DFCB | Pixel 354 (1,11) = F8E2CE | Pixel 355 (2,11) = FAE6D1 | Pixel 356 (3,11) = FBE7D3 | Pixel 357 (4,11) = FCE8D3 | Pixel 358 (5,11) = FBE8D3 | Pixel 359 (6,11) = 751C1E | Pixel 360 (7,11) = 9B312F | Pixel 361 (8,11) = 73171D | Pixel 362 (9,11) = 4F0814 | Pixel 363 (10,11) = 270206 | Pixel 364 (11,11) = CC3338 | Pixel 365 (12,11) = D53740 | Pixel 366 (13,11) = AD1931 | Pixel 367 (14,11) = E5424A | Pixel 368 (15,11) = D63943 | Pixel 369 (16,11) = D63843 | Pixel 370 (17,11) = D53842 | Pixel 371 (18,11) = D53941 | Pixel 372 (19,11) = 540414 | Pixel 373 (20,11) = 650D1E | Pixel 374 (21,11) = 520918 | Pixel 375 (22,11) = 490613 | Pixel 376 (23,11) = 4B0815 | Pixel 377 (24,11) = 5D121A | Pixel 378 (25,11) = 6D1E21 | Pixel 379 (26,11) = 63211E | Pixel 380 (27,11) = 5B221C | Pixel 381 (28,11) = FBE7D4 | Pixel 382 (29,11) = FBE6D3 | Pixel 383 (30,11) = F8E4D0 | Pixel 384 (31,11) = F4DFCC
Pixel 385 (0,12) = F6E4D2 | Pixel 386 (1,12) = F8E8D6 | Pixel 387 (2,12) = FBEBD9 | Pixel 388 (3,12) = FCE7D2 | Pixel 389 (4,12) = FBE8D4 | Pixel 390 (5,12) = FAE7D4 | Pixel 391 (6,12) = 5B1215 | Pixel 392 (7,12) = 510B11 | Pixel 393 (8,12) = 6B121E | Pixel 394 (9,12) = 4D0612 | Pixel 395 (10,12) = 290206 | Pixel 396 (11,12) = D0333D | Pixel 397 (12,12) = D23440 | Pixel 398 (13,12) = D73943 | Pixel 399 (14,12) = BC1B35 | Pixel 400 (15,12) = DB4045 | Pixel 401 (16,12) = DC4046 | Pixel 402 (17,12) = DB4046 | Pixel 403 (18,12) = DC4046 | Pixel 404 (19,12) = DD4145 | Pixel 405 (20,12) = 8F1424 | Pixel 406 (21,12) = 5A0B18 | Pixel 407 (22,12) = 62101C | Pixel 408 (23,12) = 4C0914 | Pixel 409 (24,12) = 58101A | Pixel 410 (25,12) = 641B1D | Pixel 411 (26,12) = 6F2322 | Pixel 412 (27,12) = 6E2623 | Pixel 413 (28,12) = 59241A | Pixel 414 (29,12) = FCE6D4 | Pixel 415 (30,12) = FAE3D2 | Pixel 416 (31,12) = F5E0CC
Pixel 417 (0,13) = F5E6D7 | Pixel 418 (1,13) = F9EBDD | Pixel 419 (2,13) = FCEEE0 | Pixel 420 (3,13) = FCEFE1 | Pixel 421 (4,13) = FCF0E0 | Pixel 422 (5,13) = FBEEDF | Pixel 423 (6,13) = 4F0F11 | Pixel 424 (7,13) = 5D1018 | Pixel 425 (8,13) = 470710 | Pixel 426 (9,13) = 4B0712 | Pixel 427 (10,13) = 4B0413 | Pixel 428 (11,13) = FB5F5E | Pixel 429 (12,13) = D93E43 | Pixel 430 (13,13) = DC4044 | Pixel 431 (14,13) = DF4147 | Pixel 432 (15,13) = DF4347 | Pixel 433 (16,13) = DF4347 | Pixel 434 (17,13) = DF4347 | Pixel 435 (18,13) = DE4246 | Pixel 436 (19,13) = AA142B | Pixel 437 (20,13) = 230308 | Pixel 438 (21,13) = 66101D | Pixel 439 (22,13) = 5B0C1B | Pixel 440 (23,13) = 7C1A26 | Pixel 441 (24,13) = 590F1A | Pixel 442 (25,13) = 65171E | Pixel 443 (26,13) = 772625 | Pixel 444 (27,13) = 501514 | Pixel 445 (28,13) = 742C26 | Pixel 446 (29,13) = FCE7D4 | Pixel 447 (30,13) = FAE4D1 | Pixel 448 (31,13) = F5E2CE
Pixel 449 (0,14) = B22A2B | Pixel 450 (1,14) = F9EBDD | Pixel 451 (2,14) = FAEFE3 | Pixel 452 (3,14) = FDF0E4 | Pixel 453 (4,14) = FCF1E4 | Pixel 454 (5,14) = FAF0E2 | Pixel 455 (6,14) = 5B1117 | Pixel 456 (7,14) = B42430 | Pixel 457 (8,14) = BE2836 | Pixel 458 (9,14) = BB2535 | Pixel 459 (10,14) = B22333 | Pixel 460 (11,14) = 470313 | Pixel 461 (12,14) = 5C0919 | Pixel 462 (13,14) = E15253 | Pixel 463 (14,14) = DD4144 | Pixel 464 (15,14) = DE4245 | Pixel 465 (16,14) = DE4146 | Pixel 466 (17,14) = DD4043 | Pixel 467 (18,14) = 560B18 | Pixel 468 (19,14) = 830922 | Pixel 469 (20,14) = 220107 | Pixel 470 (21,14) = 8E1A2C | Pixel 471 (22,14) = 65101C | Pixel 472 (23,14) = 7E1726 | Pixel 473 (24,14) = 560F18 | Pixel 474 (25,14) = 6B1B1F | Pixel 475 (26,14) = 5A1818 | Pixel 476 (27,14) = 63211D | Pixel 477 (28,14) = 5F251C | Pixel 478 (29,14) = 722D25 | Pixel 479 (30,14) = F9E8D6 | Pixel 480 (31,14) = F7E2D0
Pixel 481 (0,15) = AF2728 | Pixel 482 (1,15) = B92C2D | Pixel 483 (2,15) = CE3C37 | Pixel 484 (3,15) = D43F3A | Pixel 485 (4,15) = D8433E | Pixel 486 (5,15) = D53E3D | Pixel 487 (6,15) = DA3F3E | Pixel 488 (7,15) = D3393F | Pixel 489 (8,15) = D4383F | Pixel 490 (9,15) = D2363F | Pixel 491 (10,15) = CF313E | Pixel 492 (11,15) = 9C112A | Pixel 493 (12,15) = 440112 | Pixel 494 (13,15) = 560719 | Pixel 495 (14,15) = 571920 | Pixel 496 (15,15) = 840B24 | Pixel 497 (16,15) = 730C20 | Pixel 498 (17,15) = 820A23 | Pixel 499 (18,15) = 98142B | Pixel 500 (19,15) = DD464B | Pixel 501 (20,15) = 96132B | Pixel 502 (21,15) = 630F1D | Pixel 503 (22,15) = 470411 | Pixel 504 (23,15) = 5B0D19 | Pixel 505 (24,15) = 6B181E | Pixel 506 (25,15) = 62181C | Pixel 507 (26,15) = 521415 | Pixel 508 (27,15) = 4E1414 | Pixel 509 (28,15) = 511A16 | Pixel 510 (29,15) = 4C1914 | Pixel 511 (30,15) = D4C1AF | Pixel 512 (31,15) = F7EBDB
Pixel 513 (0,16) = AF262A | Pixel 514 (1,16) = B92B2F | Pixel 515 (2,16) = C23032 | Pixel 516 (3,16) = CF3839 | Pixel 517 (4,16) = D9413E | Pixel 518 (5,16) = DD433F | Pixel 519 (6,16) = DD4241 | Pixel 520 (7,16) = DC4243 | Pixel 521 (8,16) = DB3F42 | Pixel 522 (9,16) = DA3D41 | Pixel 523 (10,16) = C92F39 | Pixel 524 (11,16) = 9A122A | Pixel 525 (12,16) = 30091D | Pixel 526 (13,16) = 851829 | Pixel 527 (14,16) = 841428 | Pixel 528 (15,16) = 7B0821 | Pixel 529 (16,16) = 7D0722 | Pixel 530 (17,16) = 880C25 | Pixel 531 (18,16) = 96122C | Pixel 532 (19,16) = B1232E | Pixel 533 (20,16) = AB1E31 | Pixel 534 (21,16) = 850A22 | Pixel 535 (22,16) = 580818 | Pixel 536 (23,16) = 62111D | Pixel 537 (24,16) = 5D101B | Pixel 538 (25,16) = 61171C | Pixel 539 (26,16) = 6E2022 | Pixel 540 (27,16) = 631E18 | Pixel 541 (28,16) = 4B1614 | Pixel 542 (29,16) = 511F18 | Pixel 543 (30,16) = FAF2E7 | Pixel 544 (31,16) = 421A12
Pixel 545 (0,17) = B3282C | Pixel 546 (1,17) = BA2A30 | Pixel 547 (2,17) = C12F33 | Pixel 548 (3,17) = CC3538 | Pixel 549 (4,17) = D73D3D | Pixel 550 (5,17) = DB413E | Pixel 551 (6,17) = DC4241 | Pixel 552 (7,17) = DE4243 | Pixel 553 (8,17) = DD4243 | Pixel 554 (9,17) = DC4043 | Pixel 555 (10,17) = B01D30 | Pixel 556 (11,17) = 8E1128 | Pixel 557 (12,17) = 9E1A2E | Pixel 558 (13,17) = 570919 | Pixel 559 (14,17) = 89172A | Pixel 560 (15,17) = 870D26 | Pixel 561 (16,17) = 97142B | Pixel 562 (17,17) = A0182E | Pixel 563 (18,17) = AB1D31 | Pixel 564 (19,17) = AF1F34 | Pixel 565 (20,17) = AF2530 | Pixel 566 (21,17) = 5F091B | Pixel 567 (22,17) = 320D1E | Pixel 568 (23,17) = BA333E | Pixel 569 (24,17) = 570F18 | Pixel 570 (25,17) = 3D0D0E | Pixel 571 (26,17) = 57151A | Pixel 572 (27,17) = 501515 | Pixel 573 (28,17) = 521B18 | Pixel 574 (29,17) = 491613 | Pixel 575 (30,17) = 9B8176 | Pixel 576 (31,17) = 431913
Pixel 577 (0,18) = B4292D | Pixel 578 (1,18) = BF2D31 | Pixel 579 (2,18) = C73235 | Pixel 580 (3,18) = CE3639 | Pixel 581 (4,18) = D63C3E | Pixel 582 (5,18) = DA3E40 | Pixel 583 (6,18) = DB4140 | Pixel 584 (7,18) = DC4142 | Pixel 585 (8,18) = DC4142 | Pixel 586 (9,18) = AD192E | Pixel 587 (10,18) = C63442 | Pixel 588 (11,18) = 2E0C1F | Pixel 589 (12,18) = A81D31 | Pixel 590 (13,18) = 570A19 | Pixel 591 (14,18) = 680F1E | Pixel 592 (15,18) = AD1E32 | Pixel 593 (16,18) = AC1D32 | Pixel 594 (17,18) = B01F34 | Pixel 595 (18,18) = B01F34 | Pixel 596 (19,18) = 9C102B | Pixel 597 (20,18) = 740B20 | Pixel 598 (21,18) = B2272F | Pixel 599 (22,18) = 381828 | Pixel 600 (23,18) = D63C40 | Pixel 601 (24,18) = D33940 | Pixel 602 (25,18) = D1393F | Pixel 603 (26,18) = 3F1010 | Pixel 604 (27,18) = 54171B | Pixel 605 (28,18) = 4D1816 | Pixel 606 (29,18) = 341109 | Pixel 607 (30,18) = 51221D | Pixel 608 (31,18) = 79443A
Pixel 609 (0,19) = B5292D | Pixel 610 (1,19) = BE2D32 | Pixel 611 (2,19) = C93337 | Pixel 612 (3,19) = D1383B | Pixel 613 (4,19) = D63D3F | Pixel 614 (5,19) = DA3E40 | Pixel 615 (6,19) = DA3F40 | Pixel 616 (7,19) = DB4041 | Pixel 617 (8,19) = AF1C30 | Pixel 618 (9,19) = 931C29 | Pixel 619 (10,19) = AA1D2F | Pixel 620 (11,19) = AE1C32 | Pixel 621 (12,19) = AC1E32 | Pixel 622 (13,19) = 69111F | Pixel 623 (14,19) = 480314 | Pixel 624 (15,19) = A11A2F | Pixel 625 (16,19) = 941326 | Pixel 626 (17,19) = B1252F | Pixel 627 (18,19) = B22630 | Pixel 628 (19,19) = B2262E | Pixel 629 (20,19) = B32630 | Pixel 630 (21,19) = B42630 | Pixel 631 (22,19) = B52830 | Pixel 632 (23,19) = DD4244 | Pixel 633 (24,19) = D83D42 | Pixel 634 (25,19) = D53C42 | Pixel 635 (26,19) = E55454 | Pixel 636 (27,19) = 852426 | Pixel 637 (28,19) = 441214 | Pixel 638 (29,19) = 52211C | Pixel 639 (30,19) = 401513 | Pixel 640 (31,19) = 4A211B
Pixel 641 (0,20) = B6292F | Pixel 642 (1,20) = C12F32 | Pixel 643 (2,20) = C83438 | Pixel 644 (3,20) = CF393C | Pixel 645 (4,20) = C32A36 | Pixel 646 (5,20) = B92433 | Pixel 647 (6,20) = AB1C30 | Pixel 648 (7,20) = A91F30 | Pixel 649 (8,20) = A91D2F | Pixel 650 (9,20) = C32A3D | Pixel 651 (10,20) = 380F24 | Pixel 652 (11,20) = C72D3A | Pixel 653 (12,20) = B11C31 | Pixel 654 (13,20) = 7A1626 | Pixel 655 (14,20) = A71C2F | Pixel 656 (15,20) = AC2033 | Pixel 657 (16,20) = AE1F34 | Pixel 658 (17,20) = AF1E32 | Pixel 659 (18,20) = 9C1528 | Pixel 660 (19,20) = B2262F | Pixel 661 (20,20) = B4262F | Pixel 662 (21,20) = B52730 | Pixel 663 (22,20) = B52830 | Pixel 664 (23,20) = B62830 | Pixel 665 (24,20) = DD4345 | Pixel 666 (25,20) = D73E41 | Pixel 667 (26,20) = D23A40 | Pixel 668 (27,20) = C9313B | Pixel 669 (28,20) = 491519 | Pixel 670 (29,20) = 3F1113 | Pixel 671 (30,20) = 4F201E | Pixel 672 (31,20) = 54201F
Pixel 673 (0,21) = B52A2F | Pixel 674 (1,21) = C02F34 | Pixel 675 (2,21) = C73237 | Pixel 676 (3,21) = AD1B30 | Pixel 677 (4,21) = A61E2F | Pixel 678 (5,21) = A41F2F | Pixel 679 (6,21) = A41F2E | Pixel 680 (7,21) = 890C24 | Pixel 681 (8,21) = AC162F | Pixel 682 (9,21) = D73D3F | Pixel 683 (10,21) = D73E41 | Pixel 684 (11,21) = 610F1D | Pixel 685 (12,21) = 7E1829 | Pixel 686 (13,21) = D73B41 | Pixel 687 (14,21) = B71E32 | Pixel 688 (15,21) = A81A31 | Pixel 689 (16,21) = AE1F34 | Pixel 690 (17,21) = AF1E33 | Pixel 691 (18,21) = 991027 | Pixel 692 (19,21) = D9474A | Pixel 693 (20,21) = B3252F | Pixel 694 (21,21) = B52630 | Pixel 695 (22,21) = B6282F | Pixel 696 (23,21) = B52931 | Pixel 697 (24,21) = 981B23 | Pixel 698 (25,21) = DB4143 | Pixel 699 (26,21) = D43A3F | Pixel 700 (27,21) = BE2736 | Pixel 701 (28,21) = 3D0D14 | Pixel 702 (29,21) = 350C0F | Pixel 703 (30,21) = 461D1B | Pixel 704 (31,21) = 391616
Pixel 705 (0,22) = B4282E | Pixel 706 (1,22) = BA2B32 | Pixel 707 (2,22) = A2192C | Pixel 708 (3,22) = A01C2C | Pixel 709 (4,22) = A21D2D | Pixel 710 (5,22) = A31E2E | Pixel 711 (6,22) = 901327 | Pixel 712 (7,22) = A7162D | Pixel 713 (8,22) = D63D40 | Pixel 714 (9,22) = 17060D | Pixel 715 (10,22) = CC383B | Pixel 716 (11,22) = DD4144 | Pixel 717 (12,22) = DD4144 | Pixel 718 (13,22) = DD4145 | Pixel 719 (14,22) = D83B41 | Pixel 720 (15,22) = AC1630 | Pixel 721 (16,22) = AD1C32 | Pixel 722 (17,22) = B01E33 | Pixel 723 (18,22) = 951126 | Pixel 724 (19,22) = 9E1028 | Pixel 725 (20,22) = B32630 | Pixel 726 (21,22) = B62731 | Pixel 727 (22,22) = B52831 | Pixel 728 (23,22) = B72931 | Pixel 729 (24,22) = B82A31 | Pixel 730 (25,22) = 63080F | Pixel 731 (26,22) = C72839 | Pixel 732 (27,22) = AF2032 | Pixel 733 (28,22) = 370B13 | Pixel 734 (29,22) = 46171A | Pixel 735 (30,22) = 47181B | Pixel 736 (31,22) = 361417
Pixel 737 (0,23) = 941226 | Pixel 738 (1,23) = 961827 | Pixel 739 (2,23) = 991B29 | Pixel 740 (3,23) = 3F0003 | Pixel 741 (4,23) = 140105 | Pixel 742 (5,23) = 931729 | Pixel 743 (6,23) = A3182D | Pixel 744 (7,23) = 3E1E2C | Pixel 745 (8,23) = 3C1D2A | Pixel 746 (9,23) = 3F1E2C | Pixel 747 (10,23) = 210911 | Pixel 748 (11,23) = DC4042 | Pixel 749 (12,23) = DD4245 | Pixel 750 (13,23) = DE4246 | Pixel 751 (14,23) = DD4145 | Pixel 752 (15,23) = C12536 | Pixel 753 (16,23) = AD1931 | Pixel 754 (17,23) = B61C35 | Pixel 755 (18,23) = BC1E36 | Pixel 756 (19,23) = 7E0C1B | Pixel 757 (20,23) = 6A0813 | Pixel 758 (21,23) = B62730 | Pixel 759 (22,23) = B72631 | Pixel 760 (23,23) = B62931 | Pixel 761 (24,23) = B82A32 | Pixel 762 (25,23) = B92932 | Pixel 763 (26,23) = B62033 | Pixel 764 (27,23) = AB2233 | Pixel 765 (28,23) = 340913 | Pixel 766 (29,23) = 3E1519 | Pixel 767 (30,23) = 381417 | Pixel 768 (31,23) = 491D1F
Pixel 769 (0,24) = 8A1725 | Pixel 770 (1,24) = 901A28 | Pixel 771 (2,24) = 7C0F20 | Pixel 772 (3,24) = 26050F | Pixel 773 (4,24) = 23060F | Pixel 774 (5,24) = 991A2A | Pixel 775 (6,24) = 200817 | Pixel 776 (7,24) = 3E202C | Pixel 777 (8,24) = 522835 | Pixel 778 (9,24) = 552836 | Pixel 779 (10,24) = 4C2130 | Pixel 780 (11,24) = 431C2B | Pixel 781 (12,24) = DD4144 | Pixel 782 (13,24) = DC3F44 | Pixel 783 (14,24) = D93B42 | Pixel 784 (15,24) = D93D41 | Pixel 785 (16,24) = 920A22 | Pixel 786 (17,24) = CF303D | Pixel 787 (18,24) = D93D43 | Pixel 788 (19,24) = DC4044 | Pixel 789 (20,24) = DB3E44 | Pixel 790 (21,24) = 900F24 | Pixel 791 (22,24) = B52831 | Pixel 792 (23,24) = B62730 | Pixel 793 (24,24) = B82832 | Pixel 794 (25,24) = B82932 | Pixel 795 (26,24) = B82A32 | Pixel 796 (27,24) = A82130 | Pixel 797 (28,24) = 40141A | Pixel 798 (29,24) = 40131A | Pixel 799 (30,24) = 2B0A13 | Pixel 800 (31,24) = 491B1F
Pixel 801 (0,25) = 8A1825 | Pixel 802 (1,25) = 160303 | Pixel 803 (2,25) = 25070F | Pixel 804 (3,25) = 110303 | Pixel 805 (4,25) = 21060F | Pixel 806 (5,25) = 0D0202 | Pixel 807 (6,25) = 2C0A1B | Pixel 808 (7,25) = 41222E | Pixel 809 (8,25) = 542A36 | Pixel 810 (9,25) = 612E3A | Pixel 811 (10,25) = 642E3A | Pixel 812 (11,25) = 3D1723 | Pixel 813 (12,25) = DA3F42 | Pixel 814 (13,25) = E24A50 | Pixel 815 (14,25) = D43540 | Pixel 816 (15,25) = D2353F | Pixel 817 (16,25) = CB2E3B | Pixel 818 (17,25) = D93A43 | Pixel 819 (18,25) = D83B43 | Pixel 820 (19,25) = DA3B42 | Pixel 821 (20,25) = DA3D43 | Pixel 822 (21,25) = DD3F44 | Pixel 823 (22,25) = 650810 | Pixel 824 (23,25) = 810E21 | Pixel 825 (24,25) = B62731 | Pixel 826 (25,25) = B82A32 | Pixel 827 (26,25) = B82931 | Pixel 828 (27,25) = 27030C | Pixel 829 (28,25) = 40141A | Pixel 830 (29,25) = 2C0812 | Pixel 831 (30,25) = 341418 | Pixel 832 (31,25) = 3F171C
Pixel 833 (0,26) = F4EEE7 | Pixel 834 (1,26) = 3B1017 | Pixel 835 (2,26) = 401319 | Pixel 836 (3,26) = 2A0F12 | Pixel 837 (4,26) = 22080F | Pixel 838 (5,26) = 280E1B | Pixel 839 (6,26) = 360E20 | Pixel 840 (7,26) = 4E2934 | Pixel 841 (8,26) = 4A2431 | Pixel 842 (9,26) = 62303C | Pixel 843 (10,26) = 532434 | Pixel 844 (11,26) = 522331 | Pixel 845 (12,26) = 33101A | Pixel 846 (13,26) = D1333F | Pixel 847 (14,26) = CE323E | Pixel 848 (15,26) = D0323E | Pixel 849 (16,26) = D53940 | Pixel 850 (17,26) = D33440 | Pixel 851 (18,26) = D53740 | Pixel 852 (19,26) = DE444A | Pixel 853 (20,26) = DA3C44 | Pixel 854 (21,26) = DE4144 | Pixel 855 (22,26) = DA3D41 | Pixel 856 (23,26) = 451C2B | Pixel 857 (24,26) = 961427 | Pixel 858 (25,26) = B92832 | Pixel 859 (26,26) = B92A31 | Pixel 860 (27,26) = 310612 | Pixel 861 (28,26) = 3E141A | Pixel 862 (29,26) = 2C0913 | Pixel 863 (30,26) = 41151D | Pixel 864 (31,26) = 2D1215
Pixel 865 (0,27) = 260D0F | Pixel 866 (1,27) = 290E10 | Pixel 867 (2,27) = 280C0E | Pixel 868 (3,27) = 250C0F | Pixel 869 (4,27) = 23090D | Pixel 870 (5,27) = 1D090F | Pixel 871 (6,27) = 351322 | Pixel 872 (7,27) = 34071A | Pixel 873 (8,27) = 492431 | Pixel 874 (9,27) = 5E2E39 | Pixel 875 (10,27) = 6B3440 | Pixel 876 (11,27) = 6D323F | Pixel 877 (12,27) = 582434 | Pixel 878 (13,27) = 5A1E33 | Pixel 879 (14,27) = CC313E | Pixel 880 (15,27) = D0323F | Pixel 881 (16,27) = D2353E | Pixel 882 (17,27) = D0323F | Pixel 883 (18,27) = D23640 | Pixel 884 (19,27) = E34E54 | Pixel 885 (20,27) = DC4046 | Pixel 886 (21,27) = D93E43 | Pixel 887 (22,27) = 310F1A | Pixel 888 (23,27) = 491D2F | Pixel 889 (24,27) = 971429 | Pixel 890 (25,27) = B92A32 | Pixel 891 (26,27) = B92B32 | Pixel 892 (27,27) = 300510 | Pixel 893 (28,27) = 330B15 | Pixel 894 (29,27) = 390E17 | Pixel 895 (30,27) = 3E141C | Pixel 896 (31,27) = 2C1316
Pixel 897 (0,28) = 461F1C | Pixel 898 (1,28) = 27120E | Pixel 899 (2,28) = 2A1111 | Pixel 900 (3,28) = 290F11 | Pixel 901 (4,28) = 260D0F | Pixel 902 (5,28) = 1A0A0C | Pixel 903 (6,28) = 361724 | Pixel 904 (7,28) = 350E1E | Pixel 905 (8,28) = 4B212D | Pixel 906 (9,28) = 5D2E3A | Pixel 907 (10,28) = 64313D | Pixel 908 (11,28) = 522432 | Pixel 909 (12,28) = 4F2230 | Pixel 910 (13,28) = 45192A | Pixel 911 (14,28) = CE323D | Pixel 912 (15,28) = D0343F | Pixel 913 (16,28) = D0343E | Pixel 914 (17,28) = CE313E | Pixel 915 (18,28) = D0323E | Pixel 916 (19,28) = D43841 | Pixel 917 (20,28) = D33841 | Pixel 918 (21,28) = 441521 | Pixel 919 (22,28) = 4F202F | Pixel 920 (23,28) = 4E1F30 | Pixel 921 (24,28) = 1A0003 | Pixel 922 (25,28) = BA2A33 | Pixel 923 (26,28) = B92C32 | Pixel 924 (27,28) = 300512 | Pixel 925 (28,28) = 310913 | Pixel 926 (29,28) = 49181F | Pixel 927 (30,28) = 2F1015 | Pixel 928 (31,28) = 2F1417
Pixel 929 (0,29) = 3E1B19 | Pixel 930 (1,29) = 2E1511 | Pixel 931 (2,29) = 321713 | Pixel 932 (3,29) = 331715 | Pixel 933 (4,29) = 280E10 | Pixel 934 (5,29) = 99202A | Pixel 935 (6,29) = 0D0603 | Pixel 936 (7,29) = 3B1625 | Pixel 937 (8,29) = 3A0D20 | Pixel 938 (9,29) = 4F2632 | Pixel 939 (10,29) = 552835 | Pixel 940 (11,29) = 612E3A | Pixel 941 (12,29) = 4C2231 | Pixel 942 (13,29) = 4C212F | Pixel 943 (14,29) = D0343C | Pixel 944 (15,29) = D3373F | Pixel 945 (16,29) = CC303B | Pixel 946 (17,29) = CB303B | Pixel 947 (18,29) = CC313D | Pixel 948 (19,29) = 4F1D2D | Pixel 949 (20,29) = 4E1F2E | Pixel 950 (21,29) = 662C3A | Pixel 951 (22,29) = 5F2938 | Pixel 952 (23,29) = 572634 | Pixel 953 (24,29) = 541F31 | Pixel 954 (25,29) = BC2D33 | Pixel 955 (26,29) = BA2D33 | Pixel 956 (27,29) = 310711 | Pixel 957 (28,29) = 310911 | Pixel 958 (29,29) = 4B1B1D | Pixel 959 (30,29) = 2E0F14 | Pixel 960 (31,29) = 2E1517
Pixel 961 (0,30) = 2D1513 | Pixel 962 (1,30) = 211109 | Pixel 963 (2,30) = 361C16 | Pixel 964 (3,30) = 1D0D05 | Pixel 965 (4,30) = 2C1110 | Pixel 966 (5,30) = A3262D | Pixel 967 (6,30) = A3242E | Pixel 968 (7,30) = 110300 | Pixel 969 (8,30) = 341222 | Pixel 970 (9,30) = 370F22 | Pixel 971 (10,30) = 3B091F | Pixel 972 (11,30) = 592A39 | Pixel 973 (12,30) = 471F2F | Pixel 974 (13,30) = 47202F | Pixel 975 (14,30) = 29131E | Pixel 976 (15,30) = DC454D | Pixel 977 (16,30) = 230610 | Pixel 978 (17,30) = 46182C | Pixel 979 (18,30) = 491C2C | Pixel 980 (19,30) = 4F2231 | Pixel 981 (20,30) = 532432 | Pixel 982 (21,30) = 642D3B | Pixel 983 (22,30) = 5D2837 | Pixel 984 (23,30) = 4E202E | Pixel 985 (24,30) = 230105 | Pixel 986 (25,30) = BC2E34 | Pixel 987 (26,30) = BD3033 | Pixel 988 (27,30) = 330910 | Pixel 989 (28,30) = 390E14 | Pixel 990 (29,30) = 4E1D1D | Pixel 991 (30,30) = 4B3B38 | Pixel 992 (31,30) = 2C1314
Pixel 993 (0,31) = 462119 | Pixel 994 (1,31) = 3E1E18 | Pixel 995 (2,31) = 2A140D | Pixel 996 (3,31) = 321311 | Pixel 997 (4,31) = 2F1111 | Pixel 998 (5,31) = A5272E | Pixel 999 (6,31) = A8232F | Pixel 1000 (7,31) = A51F2E | Pixel 1001 (8,31) = A01C2D | Pixel 1002 (9,31) = 391223 | Pixel 1003 (10,31) = 3A1225 | Pixel 1004 (11,31) = 3A0F24 | Pixel 1005 (12,31) = 3B0E23 | Pixel 1006 (13,31) = 320C20 | Pixel 1007 (14,31) = 23060F | Pixel 1008 (15,31) = 25050E | Pixel 1009 (16,31) = 401A29 | Pixel 1010 (17,31) = 5C2B38 | Pixel 1011 (18,31) = 4A2230 | Pixel 1012 (19,31) = 5A2B38 | Pixel 1013 (20,31) = 5B2A37 | Pixel 1014 (21,31) = 5A2A37 | Pixel 1015 (22,31) = 562231 | Pixel 1016 (23,31) = 3E071C | Pixel 1017 (24,31) = 941627 | Pixel 1018 (25,31) = BD3134 | Pixel 1019 (26,31) = BE3234 | Pixel 1020 (27,31) = D34946 | Pixel 1021 (28,31) = 380E12 | Pixel 1022 (29,31) = 3C1617 | Pixel 1023 (30,31) = F4F0E9 | Pixel 1024 (31,31) = 301414
        ]]
    }
}
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do
    art[i] = "FFFFFF"
end

-- ======================
-- PARSER UNIVERSAL
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do
        art[i] = "FFFFFF"
    end

    if not text or text == "" then return 0 end

    local count = 0
    for idx, hex in text:gmatch("Pixel%s+(%d+)[^=]*=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count += 1
        end
    end
    return count
end

-- ======================
-- ESTADO
-- ======================
local selectedMap = nil
local loopActive = false
local gui = nil
local frame = nil
local startBtn = nil
local preview = nil

-- ======================
-- CRIAR/ATUALIZAR GUI (Mais Bonita)
-- ======================
local function createOrUpdateGUI()
    if gui and gui.Parent then
        return gui
    end

    gui = Instance.new("ScreenGui")
    gui.Name = "PixelPainterHUD"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Toggle Button
    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 40, 0, 40)
    toggleBtn.Position = UDim2.new(1, -55, 0, 15)
    toggleBtn.Text = "🎨"
    toggleBtn.TextSize = 24
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.AutoButtonColor = false

    local toggleCorner = Instance.new("UICorner", toggleBtn)
    toggleCorner.CornerRadius = UDim.new(0, 8)

    -- Main Frame
    frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 160)
    frame.Position = UDim2.new(1, -250, 0, 65)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Visible = false

    local mainCorner = Instance.new("UICorner", frame)
    mainCorner.CornerRadius = UDim.new(0, 10)

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "Pixel Painter"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1

    -- Lista de Artes (Scroll corrigido!)
    local artList = Instance.new("ScrollingFrame", frame)
    artList.Size = UDim2.new(1, -10, 0, 85)
    artList.Position = UDim2.new(0, 5, 0, 30)
    artList.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    artList.BorderSizePixel = 0
    artList.ScrollBarThickness = 5
    artList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    artList.AutomaticCanvasSize = Enum.AutomaticSize.Y   -- ← Correção principal
    artList.CanvasSize = UDim2.new(0, 0, 0, 0)

    local listCorner = Instance.new("UICorner", artList)
    listCorner.CornerRadius = UDim.new(0, 6)

    local layout = Instance.new("UIListLayout", artList)
    layout.Padding = UDim.new(0, 3)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Preview
    preview = Instance.new("TextLabel", frame)
    preview.Size = UDim2.new(1, -10, 0, 22)
    preview.Position = UDim2.new(0, 5, 0, 120)
    preview.Text = "Preview: nenhuma arte selecionada"
    preview.Font = Enum.Font.Code
    preview.TextSize = 12
    preview.TextColor3 = Color3.fromRGB(200, 200, 200)
    preview.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    preview.TextTruncate = Enum.TextTruncate.AtEnd

    local previewCorner = Instance.new("UICorner", preview)
    previewCorner.CornerRadius = UDim.new(0, 4)

    -- Start Button
    startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1, -10, 0, 23)
    startBtn.Position = UDim2.new(0, 5, 0, 147)
    startBtn.Text = "COMEÇAR"
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 13
    startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    startBtn.TextColor3 = Color3.new(1, 1, 1)
    startBtn.BorderSizePixel = 0

    local btnCorner = Instance.new("UICorner", startBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    -- ======================
    -- Hover Effects
    -- ======================
    toggleBtn.MouseEnter:Connect(function() toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70) end)
    toggleBtn.MouseLeave:Connect(function() toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50) end)

    -- ======================
    -- Conexões
    -- ======================
    toggleBtn.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    startBtn.MouseButton1Click:Connect(function()
        loopActive = not loopActive
        if loopActive then
            startBtn.Text = "PARAR"
            startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        else
            startBtn.Text = "COMEÇAR"
            startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end)

    -- Popular lista de artes
    for i, slot in ipairs(ARTS) do
        local btn = Instance.new("TextButton", artList)
        btn.Size = UDim2.new(1, -8, 0, 22)
        btn.Text = "  " .. slot.name
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false

        local btnCorner2 = Instance.new("UICorner", btn)
        btnCorner2.CornerRadius = UDim.new(0, 5)

        btn.MouseButton1Click:Connect(function()
            selectedMap = slot.map
            preview.Text = "Preview: " .. slot.name
        end)

        -- Hover no botão da arte
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55) end)
    end

    -- Restaurar estado visual
    if selectedMap then
        preview.Text = "Preview: " .. (selectedMap.name or "arte_selecionada")
    end
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    end

    return gui
end

-- ======================
-- ANTI-MORTE (Monitoramento)
-- ======================
local function monitorGUI()
    while true do
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui and not playerGui:FindFirstChild("PixelPainterHUD") then
            createOrUpdateGUI()
            warn("[Pixel Painter] GUI recriada após morte/respawn")
        end
        task.wait(2)
    end
end

-- ======================
-- INICIALIZAÇÃO
-- ======================
if not player:FindFirstChild("PlayerGui") then
    player.CharacterAdded:Wait()
    task.wait(1)
end

createOrUpdateGUI()
task.spawn(monitorGUI)

-- ======================
-- LOOP DE PINTURA
-- ======================
task.spawn(function()
    while true do
        if loopActive and selectedMap then
            parseTextToArt(selectedMap)

            local packet = {}
            local count = 0

            for i = 1, TOTAL do
                packet[tostring(logicalToBoardIndex(i))] = art[i]
                count += 1

                if count >= 64 then
                    pcall(function()
                        if remote then remote:InvokeServer(packet) end
                    end)
                    packet = {}
                    count = 0
                    task.wait(0.01)
                end
            end

            if count > 0 then
                pcall(function()
                    if remote then remote:InvokeServer(packet) end
                end)
            end

            task.wait(0.5)
        else
            task.wait(0.2)
        end
    end
end)

-- Reconexão ao respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    if player:FindFirstChild("PlayerGui") and not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
    end
end)

print("🎨 Pixel Painter HUD carregada (versão melhorada + scroll corrigido)")
