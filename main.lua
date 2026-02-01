-- ======================
-- PIXEL PAINTER CENTRAL (DELTA)
-- GUI FIXA / SLOTS INFINITOS
-- FORMATO INLINE SUPORTADO (|)
-- SISTEMA ANTI-MORTE (HUD PERSISTENTE)
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

-- ======================
-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇-- ======================
local ARTS = {
    {
-- ======================
local ARTS = {
    {
        name = "Gelo",
        map = [[
Pixel 1 (0,0) = 000000 | Pixel 2 (1,0) = 000000 | Pixel 3 (2,0) = 000000 | Pixel 4 (3,0) = 000000 | Pixel 5 (4,0) = 000000 | Pixel 6 (5,0) = 000000 | Pixel 7 (6,0) = 000000 | Pixel 8 (7,0) = 000000 | Pixel 9 (8,0) = 000000 | Pixel 10 (9,0) = 000000 | Pixel 11 (10,0) = 000000 | Pixel 12 (11,0) = 000000 | Pixel 13 (12,0) = 000000 | Pixel 14 (13,0) = 000000 | Pixel 15 (14,0) = 000000 | Pixel 16 (15,0) = 000000 | Pixel 17 (16,0) = 000000 | Pixel 18 (17,0) = 000000 | Pixel 19 (18,0) = 000000 | Pixel 20 (19,0) = 000000 | Pixel 21 (20,0) = 000000 | Pixel 22 (21,0) = 000000 | Pixel 23 (22,0) = 000000 | Pixel 24 (23,0) = 000000 | Pixel 25 (24,0) = 000000 | Pixel 26 (25,0) = 000000 | Pixel 27 (26,0) = 000000 | Pixel 28 (27,0) = 000000 | Pixel 29 (28,0) = 000000 | Pixel 30 (29,0) = 000000 | Pixel 31 (30,0) = 000000 | Pixel 32 (31,0) = 000000
Pixel 33 (0,1) = 000000 | Pixel 34 (1,1) = 000000 | Pixel 35 (2,1) = 000000 | Pixel 36 (3,1) = 000000 | Pixel 37 (4,1) = 000000 | Pixel 38 (5,1) = 000000 | Pixel 39 (6,1) = 000000 | Pixel 40 (7,1) = 000000 | Pixel 41 (8,1) = 000000 | Pixel 42 (9,1) = 000000 | Pixel 43 (10,1) = 000000 | Pixel 44 (11,1) = 000000 | Pixel 45 (12,1) = 000000 | Pixel 46 (13,1) = 000000 | Pixel 47 (14,1) = 000000 | Pixel 48 (15,1) = 000000 | Pixel 49 (16,1) = 000000 | Pixel 50 (17,1) = 000000 | Pixel 51 (18,1) = 000000 | Pixel 52 (19,1) = 000000 | Pixel 53 (20,1) = 000000 | Pixel 54 (21,1) = 000000 | Pixel 55 (22,1) = 000000 | Pixel 56 (23,1) = 000000 | Pixel 57 (24,1) = 000000 | Pixel 58 (25,1) = 000000 | Pixel 59 (26,1) = 000000 | Pixel 60 (27,1) = 000000 | Pixel 61 (28,1) = 000000 | Pixel 62 (29,1) = 000000 | Pixel 63 (30,1) = 000000 | Pixel 64 (31,1) = 000000
Pixel 65 (0,2) = 000000 | Pixel 66 (1,2) = 000000 | Pixel 67 (2,2) = 000000 | Pixel 68 (3,2) = 000000 | Pixel 69 (4,2) = 000000 | Pixel 70 (5,2) = 000000 | Pixel 71 (6,2) = 000000 | Pixel 72 (7,2) = 000000 | Pixel 73 (8,2) = 000000 | Pixel 74 (9,2) = 000000 | Pixel 75 (10,2) = 000000 | Pixel 76 (11,2) = 000000 | Pixel 77 (12,2) = 000000 | Pixel 78 (13,2) = 000000 | Pixel 79 (14,2) = 000000 | Pixel 80 (15,2) = 000000 | Pixel 81 (16,2) = 000000 | Pixel 82 (17,2) = 000000 | Pixel 83 (18,2) = 000000 | Pixel 84 (19,2) = 000000 | Pixel 85 (20,2) = 000000 | Pixel 86 (21,2) = 000000 | Pixel 87 (22,2) = 000000 | Pixel 88 (23,2) = 000000 | Pixel 89 (24,2) = 000000 | Pixel 90 (25,2) = 000000 | Pixel 91 (26,2) = 000000 | Pixel 92 (27,2) = 000000 | Pixel 93 (28,2) = 000000 | Pixel 94 (29,2) = 000000 | Pixel 95 (30,2) = 000000 | Pixel 96 (31,2) = 000000
Pixel 97 (0,3) = 000000 | Pixel 98 (1,3) = 000000 | Pixel 99 (2,3) = 000000 | Pixel 100 (3,3) = 000000 | Pixel 101 (4,3) = 000000 | Pixel 102 (5,3) = 000000 | Pixel 103 (6,3) = 000000 | Pixel 104 (7,3) = 000000 | Pixel 105 (8,3) = 000000 | Pixel 106 (9,3) = 000000 | Pixel 107 (10,3) = 000000 | Pixel 108 (11,3) = 000000 | Pixel 109 (12,3) = 000000 | Pixel 110 (13,3) = 000000 | Pixel 111 (14,3) = 000000 | Pixel 112 (15,3) = 000000 | Pixel 113 (16,3) = 000000 | Pixel 114 (17,3) = 000000 | Pixel 115 (18,3) = 000000 | Pixel 116 (19,3) = 000000 | Pixel 117 (20,3) = 000000 | Pixel 118 (21,3) = 000000 | Pixel 119 (22,3) = 000000 | Pixel 120 (23,3) = 000000 | Pixel 121 (24,3) = 000000 | Pixel 122 (25,3) = 000000 | Pixel 123 (26,3) = 000000 | Pixel 124 (27,3) = 000000 | Pixel 125 (28,3) = 000000 | Pixel 126 (29,3) = 000000 | Pixel 127 (30,3) = 000000 | Pixel 128 (31,3) = 000000
Pixel 129 (0,4) = 000000 | Pixel 130 (1,4) = 000000 | Pixel 131 (2,4) = 000000 | Pixel 132 (3,4) = 000000 | Pixel 133 (4,4) = 000000 | Pixel 134 (5,4) = 000000 | Pixel 135 (6,4) = 000000 | Pixel 136 (7,4) = 000000 | Pixel 137 (8,4) = 000000 | Pixel 138 (9,4) = 000000 | Pixel 139 (10,4) = 000000 | Pixel 140 (11,4) = 161616 | Pixel 141 (12,4) = 191919 | Pixel 142 (13,4) = 2C2C2C | Pixel 143 (14,4) = 282728 | Pixel 144 (15,4) = 272727 | Pixel 145 (16,4) = 2E2E2E | Pixel 146 (17,4) = 3D3C3D | Pixel 147 (18,4) = 3B3B3B | Pixel 148 (19,4) = 474747 | Pixel 149 (20,4) = 2C2C2C | Pixel 150 (21,4) = 000000 | Pixel 151 (22,4) = 000000 | Pixel 152 (23,4) = 212121 | Pixel 153 (24,4) = 020202 | Pixel 154 (25,4) = 010101 | Pixel 155 (26,4) = 393939 | Pixel 156 (27,4) = 000000 | Pixel 157 (28,4) = 000000 | Pixel 158 (29,4) = 000000 | Pixel 159 (30,4) = 000000 | Pixel 160 (31,4) = 000000
Pixel 161 (0,5) = 000000 | Pixel 162 (1,5) = 000000 | Pixel 163 (2,5) = 000000 | Pixel 164 (3,5) = 000000 | Pixel 165 (4,5) = 010101 | Pixel 166 (5,5) = 010101 | Pixel 167 (6,5) = 010101 | Pixel 168 (7,5) = 010101 | Pixel 169 (8,5) = 010101 | Pixel 170 (9,5) = 101010 | Pixel 171 (10,5) = 121212 | Pixel 172 (11,5) = 141414 | Pixel 173 (12,5) = 151515 | Pixel 174 (13,5) = 1E1E1E | Pixel 175 (14,5) = 1D1D1D | Pixel 176 (15,5) = 252525 | Pixel 177 (16,5) = 303030 | Pixel 178 (17,5) = 393939 | Pixel 179 (18,5) = 404040 | Pixel 180 (19,5) = 434343 | Pixel 181 (20,5) = 525252 | Pixel 182 (21,5) = 464646 | Pixel 183 (22,5) = 010101 | Pixel 184 (23,5) = 010101 | Pixel 185 (24,5) = 010101 | Pixel 186 (25,5) = 010101 | Pixel 187 (26,5) = 010101 | Pixel 188 (27,5) = 1F1F1F | Pixel 189 (28,5) = 000000 | Pixel 190 (29,5) = 000000 | Pixel 191 (30,5) = 000000 | Pixel 192 (31,5) = 000000
Pixel 193 (0,6) = 000000 | Pixel 194 (1,6) = 000000 | Pixel 195 (2,6) = 000000 | Pixel 196 (3,6) = 000000 | Pixel 197 (4,6) = 010101 | Pixel 198 (5,6) = 010101 | Pixel 199 (6,6) = 010101 | Pixel 200 (7,6) = 010101 | Pixel 201 (8,6) = 0D0D0D | Pixel 202 (9,6) = 1F1F1F | Pixel 203 (10,6) = 0D0D0D | Pixel 204 (11,6) = 131313 | Pixel 205 (12,6) = 131313 | Pixel 206 (13,6) = 1F1F1F | Pixel 207 (14,6) = 1B1B1B | Pixel 208 (15,6) = 202020 | Pixel 209 (16,6) = 323232 | Pixel 210 (17,6) = 333333 | Pixel 211 (18,6) = 333333 | Pixel 212 (19,6) = 373737 | Pixel 213 (20,6) = 545454 | Pixel 214 (21,6) = 5A5A5A | Pixel 215 (22,6) = 505050 | Pixel 216 (23,6) = 3B3B3B | Pixel 217 (24,6) = 010101 | Pixel 218 (25,6) = 010101 | Pixel 219 (26,6) = 010101 | Pixel 220 (27,6) = 010101 | Pixel 221 (28,6) = 000000 | Pixel 222 (29,6) = 000000 | Pixel 223 (30,6) = 000000 | Pixel 224 (31,6) = 000000
Pixel 225 (0,7) = 000000 | Pixel 226 (1,7) = 000000 | Pixel 227 (2,7) = 000000 | Pixel 228 (3,7) = 000000 | Pixel 229 (4,7) = 010101 | Pixel 230 (5,7) = 010101 | Pixel 231 (6,7) = 010101 | Pixel 232 (7,7) = 0A0A0A | Pixel 233 (8,7) = 0B0B0B | Pixel 234 (9,7) = 131313 | Pixel 235 (10,7) = 0A0A0A | Pixel 236 (11,7) = 0D0D0D | Pixel 237 (12,7) = 111111 | Pixel 238 (13,7) = 181818 | Pixel 239 (14,7) = 161616 | Pixel 240 (15,7) = 242324 | Pixel 241 (16,7) = 262626 | Pixel 242 (17,7) = 282828 | Pixel 243 (18,7) = 2B2B2B | Pixel 244 (19,7) = 4B4B4B | Pixel 245 (20,7) = 4A4A4A | Pixel 246 (21,7) = 575757 | Pixel 247 (22,7) = 565656 | Pixel 248 (23,7) = 4E4E4E | Pixel 249 (24,7) = 3A3A3A | Pixel 250 (25,7) = 010101 | Pixel 251 (26,7) = 010101 | Pixel 252 (27,7) = 010101 | Pixel 253 (28,7) = 000000 | Pixel 254 (29,7) = 000000 | Pixel 255 (30,7) = 000000 | Pixel 256 (31,7) = 000000
Pixel 257 (0,8) = 000000 | Pixel 258 (1,8) = 000000 | Pixel 259 (2,8) = 000000 | Pixel 260 (3,8) = 000000 | Pixel 261 (4,8) = 010101 | Pixel 262 (5,8) = 0D0D0D | Pixel 263 (6,8) = 101010 | Pixel 264 (7,8) = 070707 | Pixel 265 (8,8) = 090909 | Pixel 266 (9,8) = 070707 | Pixel 267 (10,8) = 090909 | Pixel 268 (11,8) = 090909 | Pixel 269 (12,8) = 0C0C0C | Pixel 270 (13,8) = 101010 | Pixel 271 (14,8) = 111111 | Pixel 272 (15,8) = 161616 | Pixel 273 (16,8) = 1F1F1F | Pixel 274 (17,8) = 1C1C1C | Pixel 275 (18,8) = 222222 | Pixel 276 (19,8) = 3A3A3A | Pixel 277 (20,8) = 3A3A3A | Pixel 278 (21,8) = 484848 | Pixel 279 (22,8) = 4C4C4C | Pixel 280 (23,8) = 454545 | Pixel 281 (24,8) = 434343 | Pixel 282 (25,8) = 3B383B | Pixel 283 (26,8) = 010101 | Pixel 284 (27,8) = 0D0D0D | Pixel 285 (28,8) = 000000 | Pixel 286 (29,8) = 000000 | Pixel 287 (30,8) = 000000 | Pixel 288 (31,8) = 000000
Pixel 289 (0,9) = 000000 | Pixel 290 (1,9) = 000000 | Pixel 291 (2,9) = 000000 | Pixel 292 (3,9) = 000000 | Pixel 293 (4,9) = 010101 | Pixel 294 (5,9) = 0A0A0A | Pixel 295 (6,9) = 040504 | Pixel 296 (7,9) = 010101 | Pixel 297 (8,9) = 060606 | Pixel 298 (9,9) = 010101 | Pixel 299 (10,9) = 020202 | Pixel 300 (11,9) = 020202 | Pixel 301 (12,9) = 090909 | Pixel 302 (13,9) = 0B0B0B | Pixel 303 (14,9) = 0D0D0D | Pixel 304 (15,9) = 141414 | Pixel 305 (16,9) = 171717 | Pixel 306 (17,9) = 171717 | Pixel 307 (18,9) = 191919 | Pixel 308 (19,9) = 272727 | Pixel 309 (20,9) = 2B2B2B | Pixel 310 (21,9) = 343434 | Pixel 311 (22,9) = 383838 | Pixel 312 (23,9) = 3B3B3B | Pixel 313 (24,9) = 3A3A3A | Pixel 314 (25,9) = 2C2C2C | Pixel 315 (26,9) = 272727 | Pixel 316 (27,9) = 000000 | Pixel 317 (28,9) = 000000 | Pixel 318 (29,9) = 000000 | Pixel 319 (30,9) = 000000 | Pixel 320 (31,9) = 000000
Pixel 321 (0,10) = 000000 | Pixel 322 (1,10) = 000000 | Pixel 323 (2,10) = 000000 | Pixel 324 (3,10) = 000000 | Pixel 325 (4,10) = 000000 | Pixel 326 (5,10) = 050605 | Pixel 327 (6,10) = 010101 | Pixel 328 (7,10) = 020202 | Pixel 329 (8,10) = 020102 | Pixel 330 (9,10) = 010101 | Pixel 331 (10,10) = 010101 | Pixel 332 (11,10) = 0B0B0B | Pixel 333 (12,10) = 020202 | Pixel 334 (13,10) = 040404 | Pixel 335 (14,10) = 050505 | Pixel 336 (15,10) = 060606 | Pixel 337 (16,10) = 111111 | Pixel 338 (17,10) = 121212 | Pixel 339 (18,10) = 101010 | Pixel 340 (19,10) = 1B1B1B | Pixel 341 (20,10) = 1F1F1F | Pixel 342 (21,10) = 2A2A2A | Pixel 343 (22,10) = 252525 | Pixel 344 (23,10) = 2F2F2F | Pixel 345 (24,10) = 2F302F | Pixel 346 (25,10) = 2F2F2F | Pixel 347 (26,10) = 2C2C2C | Pixel 348 (27,10) = 000000 | Pixel 349 (28,10) = 000000 | Pixel 350 (29,10) = 000000 | Pixel 351 (30,10) = 000000 | Pixel 352 (31,10) = 000000
Pixel 353 (0,11) = 000000 | Pixel 354 (1,11) = 000000 | Pixel 355 (2,11) = 000000 | Pixel 356 (3,11) = 000000 | Pixel 357 (4,11) = 010101 | Pixel 358 (5,11) = 010101 | Pixel 359 (6,11) = 090909 | Pixel 360 (7,11) = 010101 | Pixel 361 (8,11) = 010101 | Pixel 362 (9,11) = 020202 | Pixel 363 (10,11) = 090B09 | Pixel 364 (11,11) = 0E0E0E | Pixel 365 (12,11) = 0B0D0B | Pixel 366 (13,11) = 0F0F0F | Pixel 367 (14,11) = 010101 | Pixel 368 (15,11) = 070607 | Pixel 369 (16,11) = 0C0C0C | Pixel 370 (17,11) = 131313 | Pixel 371 (18,11) = 0C0C0C | Pixel 372 (19,11) = 141414 | Pixel 373 (20,11) = 151415 | Pixel 374 (21,11) = 212121 | Pixel 375 (22,11) = 171717 | Pixel 376 (23,11) = 2A2A2A | Pixel 377 (24,11) = 2F2F2F | Pixel 378 (25,11) = 2B2B2B | Pixel 379 (26,11) = 282828 | Pixel 380 (27,11) = 222222 | Pixel 381 (28,11) = 000000 | Pixel 382 (29,11) = 000000 | Pixel 383 (30,11) = 000000 | Pixel 384 (31,11) = 000000
Pixel 385 (0,12) = 000000 | Pixel 386 (1,12) = 000000 | Pixel 387 (2,12) = 000000 | Pixel 388 (3,12) = 000000 | Pixel 389 (4,12) = 010101 | Pixel 390 (5,12) = 070507 | Pixel 391 (6,12) = 0A0A0A | Pixel 392 (7,12) = 010101 | Pixel 393 (8,12) = 010101 | Pixel 394 (9,12) = 080A08 | Pixel 395 (10,12) = 111111 | Pixel 396 (11,12) = 131213 | Pixel 397 (12,12) = 080908 | Pixel 398 (13,12) = 0F0F0F | Pixel 399 (14,12) = 191819 | Pixel 400 (15,12) = 050505 | Pixel 401 (16,12) = 050505 | Pixel 402 (17,12) = 141314 | Pixel 403 (18,12) = 0C0C0C | Pixel 404 (19,12) = 101010 | Pixel 405 (20,12) = 0D0D0D | Pixel 406 (21,12) = 181818 | Pixel 407 (22,12) = 101010 | Pixel 408 (23,12) = 242424 | Pixel 409 (24,12) = 2C2C2C | Pixel 410 (25,12) = 212121 | Pixel 411 (26,12) = 292929 | Pixel 412 (27,12) = 232323 | Pixel 413 (28,12) = 000000 | Pixel 414 (29,12) = 000000 | Pixel 415 (30,12) = 000000 | Pixel 416 (31,12) = 000000
Pixel 417 (0,13) = 000000 | Pixel 418 (1,13) = 000000 | Pixel 419 (2,13) = 000000 | Pixel 420 (3,13) = 000000 | Pixel 421 (4,13) = 0A0A0A | Pixel 422 (5,13) = 0F0F0F | Pixel 423 (6,13) = 030303 | Pixel 424 (7,13) = 090909 | Pixel 425 (8,13) = 0B0B0B | Pixel 426 (9,13) = 060606 | Pixel 427 (10,13) = 0B0B0B | Pixel 428 (11,13) = 050505 | Pixel 429 (12,13) = 080808 | Pixel 430 (13,13) = 0A0A0A | Pixel 431 (14,13) = 3F3F3F | Pixel 432 (15,13) = 161616 | Pixel 433 (16,13) = 0F0F0F | Pixel 434 (17,13) = 040404 | Pixel 435 (18,13) = 060606 | Pixel 436 (19,13) = 121212 | Pixel 437 (20,13) = 010101 | Pixel 438 (21,13) = 141414 | Pixel 439 (22,13) = 080808 | Pixel 440 (23,13) = 1C1C1C | Pixel 441 (24,13) = 1F1F1F | Pixel 442 (25,13) = 2A292A | Pixel 443 (26,13) = 202020 | Pixel 444 (27,13) = 000000 | Pixel 445 (28,13) = 000000 | Pixel 446 (29,13) = 000000 | Pixel 447 (30,13) = 000000 | Pixel 448 (31,13) = 000000
Pixel 449 (0,14) = 000000 | Pixel 450 (1,14) = 000000 | Pixel 451 (2,14) = 000000 | Pixel 452 (3,14) = 000000 | Pixel 453 (4,14) = 070707 | Pixel 454 (5,14) = 0B0A0B | Pixel 455 (6,14) = 010101 | Pixel 456 (7,14) = 121212 | Pixel 457 (8,14) = 101010 | Pixel 458 (9,14) = 0A0A0A | Pixel 459 (10,14) = 030303 | Pixel 460 (11,14) = 040404 | Pixel 461 (12,14) = 030303 | Pixel 462 (13,14) = 010101 | Pixel 463 (14,14) = D3D3D3 | Pixel 464 (15,14) = 121212 | Pixel 465 (16,14) = 151515 | Pixel 466 (17,14) = 010101 | Pixel 467 (18,14) = 060606 | Pixel 468 (19,14) = 0C0C0C | Pixel 469 (20,14) = 040404 | Pixel 470 (21,14) = 0E0E0E | Pixel 471 (22,14) = 010101 | Pixel 472 (23,14) = 1D1D1D | Pixel 473 (24,14) = 131313 | Pixel 474 (25,14) = 1B1B1B | Pixel 475 (26,14) = 191919 | Pixel 476 (27,14) = 242324 | Pixel 477 (28,14) = 000000 | Pixel 478 (29,14) = 000000 | Pixel 479 (30,14) = 000000 | Pixel 480 (31,14) = 000000
Pixel 481 (0,15) = 000000 | Pixel 482 (1,15) = 000000 | Pixel 483 (2,15) = 000000 | Pixel 484 (3,15) = 000000 | Pixel 485 (4,15) = 111011 | Pixel 486 (5,15) = 070607 | Pixel 487 (6,15) = 010101 | Pixel 488 (7,15) = 0D0E0D | Pixel 489 (8,15) = 131313 | Pixel 490 (9,15) = 0A0A0A | Pixel 491 (10,15) = 010101 | Pixel 492 (11,15) = CFCFCF | Pixel 493 (12,15) = 010101 | Pixel 494 (13,15) = 010101 | Pixel 495 (14,15) = 030102 | Pixel 496 (15,15) = 030303 | Pixel 497 (16,15) = D8D8D8 | Pixel 498 (17,15) = 050303 | Pixel 499 (18,15) = 020202 | Pixel 500 (19,15) = 040404 | Pixel 501 (20,15) = 0A0A0A | Pixel 502 (21,15) = 111111 | Pixel 503 (22,15) = 111111 | Pixel 504 (23,15) = 141414 | Pixel 505 (24,15) = 0D0D0D | Pixel 506 (25,15) = 131313 | Pixel 507 (26,15) = 161616 | Pixel 508 (27,15) = 1B1B1B | Pixel 509 (28,15) = 161616 | Pixel 510 (29,15) = 171717 | Pixel 511 (30,15) = 000000 | Pixel 512 (31,15) = 000000
Pixel 513 (0,16) = 000000 | Pixel 514 (1,16) = 000000 | Pixel 515 (2,16) = 000000 | Pixel 516 (3,16) = 010101 | Pixel 517 (4,16) = 0C0C0C | Pixel 518 (5,16) = 0B0C0B | Pixel 519 (6,16) = 010101 | Pixel 520 (7,16) = 0C0C0C | Pixel 521 (8,16) = 0B0B0B | Pixel 522 (9,16) = 060606 | Pixel 523 (10,16) = 010101 | Pixel 524 (11,16) = CBCBCB | Pixel 525 (12,16) = 010101 | Pixel 526 (13,16) = CACACA | Pixel 527 (14,16) = D3D3D3 | Pixel 528 (15,16) = 010101 | Pixel 529 (16,16) = 010101 | Pixel 530 (17,16) = DCDCDC | Pixel 531 (18,16) = 141314 | Pixel 532 (19,16) = 010101 | Pixel 533 (20,16) = DDDDDD | Pixel 534 (21,16) = 151515 | Pixel 535 (22,16) = 050505 | Pixel 536 (23,16) = 0D0D0D | Pixel 537 (24,16) = 080808 | Pixel 538 (25,16) = 101010 | Pixel 539 (26,16) = 111111 | Pixel 540 (27,16) = 131313 | Pixel 541 (28,16) = 000000 | Pixel 542 (29,16) = 000000 | Pixel 543 (30,16) = 000000 | Pixel 544 (31,16) = 000000
Pixel 545 (0,17) = 000000 | Pixel 546 (1,17) = 000000 | Pixel 547 (2,17) = 000000 | Pixel 548 (3,17) = 000000 | Pixel 549 (4,17) = 020202 | Pixel 550 (5,17) = 0A0B0A | Pixel 551 (6,17) = 010101 | Pixel 552 (7,17) = 0B0B0B | Pixel 553 (8,17) = 040404 | Pixel 554 (9,17) = 030303 | Pixel 555 (10,17) = 868686 | Pixel 556 (11,17) = CCCCCC | Pixel 557 (12,17) = 010101 | Pixel 558 (13,17) = D0D0D0 | Pixel 559 (14,17) = D2D2D2 | Pixel 560 (15,17) = 010101 | Pixel 561 (16,17) = D8D8D8 | Pixel 562 (17,17) = DCDCDC | Pixel 563 (18,17) = 131313 | Pixel 564 (19,17) = 020202 | Pixel 565 (20,17) = DDDDDD | Pixel 566 (21,17) = 030303 | Pixel 567 (22,17) = 020202 | Pixel 568 (23,17) = 0B0B0B | Pixel 569 (24,17) = 040404 | Pixel 570 (25,17) = 0E0D0E | Pixel 571 (26,17) = 0D0D0D | Pixel 572 (27,17) = 101010 | Pixel 573 (28,17) = 000000 | Pixel 574 (29,17) = 000000 | Pixel 575 (30,17) = 000000 | Pixel 576 (31,17) = 000000
Pixel 577 (0,18) = 000000 | Pixel 578 (1,18) = 000000 | Pixel 579 (2,18) = 000000 | Pixel 580 (3,18) = 010101 | Pixel 581 (4,18) = 010101 | Pixel 582 (5,18) = 020102 | Pixel 583 (6,18) = 010101 | Pixel 584 (7,18) = 040404 | Pixel 585 (8,18) = 020202 | Pixel 586 (9,18) = 030303 | Pixel 587 (10,18) = C9ADB1 | Pixel 588 (11,18) = CCCCCC | Pixel 589 (12,18) = CCCBCB | Pixel 590 (13,18) = D1D1D1 | Pixel 591 (14,18) = C1C1C1 | Pixel 592 (15,18) = D7D7D7 | Pixel 593 (16,18) = D6D6D6 | Pixel 594 (17,18) = D8D8D8 | Pixel 595 (18,18) = 131313 | Pixel 596 (19,18) = E1E1E1 | Pixel 597 (20,18) = DDDDDD | Pixel 598 (21,18) = 010101 | Pixel 599 (22,18) = 010101 | Pixel 600 (23,18) = 010101 | Pixel 601 (24,18) = 010101 | Pixel 602 (25,18) = 0E0E0E | Pixel 603 (26,18) = 090909 | Pixel 604 (27,18) = 0D0D0D | Pixel 605 (28,18) = 000000 | Pixel 606 (29,18) = 000000 | Pixel 607 (30,18) = 000000 | Pixel 608 (31,18) = 000000
Pixel 609 (0,19) = 000000 | Pixel 610 (1,19) = 000000 | Pixel 611 (2,19) = 000000 | Pixel 612 (3,19) = 000000 | Pixel 613 (4,19) = 0B0B0B | Pixel 614 (5,19) = 020202 | Pixel 615 (6,19) = 060606 | Pixel 616 (7,19) = 010101 | Pixel 617 (8,19) = 010101 | Pixel 618 (9,19) = 010101 | Pixel 619 (10,19) = C8C8C8 | Pixel 620 (11,19) = 9D4451 | Pixel 621 (12,19) = CE9098 | Pixel 622 (13,19) = D1D1D1 | Pixel 623 (14,19) = 010101 | Pixel 624 (15,19) = D7D7D7 | Pixel 625 (16,19) = D6D6D6 | Pixel 626 (17,19) = D9D9D9 | Pixel 627 (18,19) = 010101 | Pixel 628 (19,19) = DDDDDD | Pixel 629 (20,19) = DAD0D1 | Pixel 630 (21,19) = DB4C61 | Pixel 631 (22,19) = 010101 | Pixel 632 (23,19) = 010101 | Pixel 633 (24,19) = 010101 | Pixel 634 (25,19) = 0E0E0E | Pixel 635 (26,19) = 040404 | Pixel 636 (27,19) = 080708 | Pixel 637 (28,19) = 000000 | Pixel 638 (29,19) = 000000 | Pixel 639 (30,19) = 000000 | Pixel 640 (31,19) = 000000
Pixel 641 (0,20) = 000000 | Pixel 642 (1,20) = 000000 | Pixel 643 (2,20) = 000000 | Pixel 644 (3,20) = 000000 | Pixel 645 (4,20) = 080808 | Pixel 646 (5,20) = 010101 | Pixel 647 (6,20) = 111111 | Pixel 648 (7,20) = 555555 | Pixel 649 (8,20) = 010101 | Pixel 650 (9,20) = 222222 | Pixel 651 (10,20) = C8C8C8 | Pixel 652 (11,20) = 999999 | Pixel 653 (12,20) = CCCCCC | Pixel 654 (13,20) = D1D1D1 | Pixel 655 (14,20) = D2D2D2 | Pixel 656 (15,20) = D7D7D7 | Pixel 657 (16,20) = D7D7D7 | Pixel 658 (17,20) = D9D9D9 | Pixel 659 (18,20) = 8A8A8A | Pixel 660 (19,20) = DDDDDD | Pixel 661 (20,20) = 010101 | Pixel 662 (21,20) = D6D6D6 | Pixel 663 (22,20) = 010101 | Pixel 664 (23,20) = 010101 | Pixel 665 (24,20) = 010101 | Pixel 666 (25,20) = 131213 | Pixel 667 (26,20) = 040404 | Pixel 668 (27,20) = 0F0F0F | Pixel 669 (28,20) = 151515 | Pixel 670 (29,20) = 000000 | Pixel 671 (30,20) = 000000 | Pixel 672 (31,20) = 000000
Pixel 673 (0,21) = 000000 | Pixel 674 (1,21) = 000000 | Pixel 675 (2,21) = 000000 | Pixel 676 (3,21) = 020202 | Pixel 677 (4,21) = 010101 | Pixel 678 (5,21) = 010101 | Pixel 679 (6,21) = 010101 | Pixel 680 (7,21) = 0B0B0B | Pixel 681 (8,21) = 010101 | Pixel 682 (9,21) = 222222 | Pixel 683 (10,21) = C8C8C8 | Pixel 684 (11,21) = CCCCCC | Pixel 685 (12,21) = CCCCCC | Pixel 686 (13,21) = D1D1D1 | Pixel 687 (14,21) = D2D2D2 | Pixel 688 (15,21) = D7D7D7 | Pixel 689 (16,21) = D6D6D6 | Pixel 690 (17,21) = D8D8D8 | Pixel 691 (18,21) = DDDDDD | Pixel 692 (19,21) = DDDDDD | Pixel 693 (20,21) = DADADA | Pixel 694 (21,21) = D7D7D7 | Pixel 695 (22,21) = 010101 | Pixel 696 (23,21) = 010101 | Pixel 697 (24,21) = 010101 | Pixel 698 (25,21) = 010101 | Pixel 699 (26,21) = 010101 | Pixel 700 (27,21) = 0E0E0E | Pixel 701 (28,21) = 000000 | Pixel 702 (29,21) = 000000 | Pixel 703 (30,21) = 000000 | Pixel 704 (31,21) = 000000
Pixel 705 (0,22) = 000000 | Pixel 706 (1,22) = 000000 | Pixel 707 (2,22) = 000000 | Pixel 708 (3,22) = 000000 | Pixel 709 (4,22) = 010101 | Pixel 710 (5,22) = 010101 | Pixel 711 (6,22) = 010101 | Pixel 712 (7,22) = 080808 | Pixel 713 (8,22) = 010101 | Pixel 714 (9,22) = 010101 | Pixel 715 (10,22) = C4C4C4 | Pixel 716 (11,22) = CCCCCC | Pixel 717 (12,22) = 020102 | Pixel 718 (13,22) = 020101 | Pixel 719 (14,22) = 030102 | Pixel 720 (15,22) = 030102 | Pixel 721 (16,22) = 030101 | Pixel 722 (17,22) = 030101 | Pixel 723 (18,22) = 030102 | Pixel 724 (19,22) = 020102 | Pixel 725 (20,22) = DADADA | Pixel 726 (21,22) = D7D7D7 | Pixel 727 (22,22) = C3C3C3 | Pixel 728 (23,22) = 010101 | Pixel 729 (24,22) = 010101 | Pixel 730 (25,22) = 0A0A0A | Pixel 731 (26,22) = 0A0A0A | Pixel 732 (27,22) = 000000 | Pixel 733 (28,22) = 0D0D0D | Pixel 734 (29,22) = 000000 | Pixel 735 (30,22) = 000000 | Pixel 736 (31,22) = 000000
Pixel 737 (0,23) = 000000 | Pixel 738 (1,23) = 000000 | Pixel 739 (2,23) = 000000 | Pixel 740 (3,23) = 010101 | Pixel 741 (4,23) = 010101 | Pixel 742 (5,23) = 010101 | Pixel 743 (6,23) = 0D0B0D | Pixel 744 (7,23) = 010101 | Pixel 745 (8,23) = C0C0C0 | Pixel 746 (9,23) = C2C2C2 | Pixel 747 (10,23) = C4C4C4 | Pixel 748 (11,23) = CCCCCC | Pixel 749 (12,23) = 676667 | Pixel 750 (13,23) = 030102 | Pixel 751 (14,23) = 030101 | Pixel 752 (15,23) = 0D0101 | Pixel 753 (16,23) = 0D0101 | Pixel 754 (17,23) = 030102 | Pixel 755 (18,23) = 030101 | Pixel 756 (19,23) = B9B8B9 | Pixel 757 (20,23) = DADADA | Pixel 758 (21,23) = D6D6D6 | Pixel 759 (22,23) = DDDDDD | Pixel 760 (23,23) = 4F4F4F | Pixel 761 (24,23) = 050505 | Pixel 762 (25,23) = 060606 | Pixel 763 (26,23) = 070707 | Pixel 764 (27,23) = 000000 | Pixel 765 (28,23) = 000000 | Pixel 766 (29,23) = 000000 | Pixel 767 (30,23) = 000000 | Pixel 768 (31,23) = 000000
Pixel 769 (0,24) = 000000 | Pixel 770 (1,24) = 000000 | Pixel 771 (2,24) = 000000 | Pixel 772 (3,24) = 000000 | Pixel 773 (4,24) = 010101 | Pixel 774 (5,24) = 010101 | Pixel 775 (6,24) = 030303 | Pixel 776 (7,24) = 060606 | Pixel 777 (8,24) = 010101 | Pixel 778 (9,24) = 222222 | Pixel 779 (10,24) = C4C4C4 | Pixel 780 (11,24) = CCCCCC | Pixel 781 (12,24) = C8C8C8 | Pixel 782 (13,24) = 030101 | Pixel 783 (14,24) = D54359 | Pixel 784 (15,24) = D8455B | Pixel 785 (16,24) = DA465C | Pixel 786 (17,24) = DE465E | Pixel 787 (18,24) = 030101 | Pixel 788 (19,24) = DBDBDB | Pixel 789 (20,24) = D7D7D7 | Pixel 790 (21,24) = D3D3D3 | Pixel 791 (22,24) = A4A4A4 | Pixel 792 (23,24) = E4E4E4 | Pixel 793 (24,24) = 080808 | Pixel 794 (25,24) = 010201 | Pixel 795 (26,24) = 060606 | Pixel 796 (27,24) = 010101 | Pixel 797 (28,24) = 000000 | Pixel 798 (29,24) = 000000 | Pixel 799 (30,24) = 000000 | Pixel 800 (31,24) = 000000
Pixel 801 (0,25) = 000000 | Pixel 802 (1,25) = 000000 | Pixel 803 (2,25) = 000000 | Pixel 804 (3,25) = 000000 | Pixel 805 (4,25) = 000000 | Pixel 806 (5,25) = 010101 | Pixel 807 (6,25) = 010101 | Pixel 808 (7,25) = 030303 | Pixel 809 (8,25) = C0C0C0 | Pixel 810 (9,25) = C5C5C5 | Pixel 811 (10,25) = C6C6C6 | Pixel 812 (11,25) = CACACA | Pixel 813 (12,25) = C8C8C8 | Pixel 814 (13,25) = C4A5A9 | Pixel 815 (14,25) = D4445A | Pixel 816 (15,25) = D8465C | Pixel 817 (16,25) = D8465B | Pixel 818 (17,25) = DA465A | Pixel 819 (18,25) = D8CECF | Pixel 820 (19,25) = DADADA | Pixel 821 (20,25) = D8D8D8 | Pixel 822 (21,25) = D4D4D4 | Pixel 823 (22,25) = D2D2D2 | Pixel 824 (23,25) = D9D9D9 | Pixel 825 (24,25) = 040404 | Pixel 826 (25,25) = 010101 | Pixel 827 (26,25) = 131313 | Pixel 828 (27,25) = 000000 | Pixel 829 (28,25) = 0C0C0C | Pixel 830 (29,25) = 000000 | Pixel 831 (30,25) = 000000 | Pixel 832 (31,25) = 000000
Pixel 833 (0,26) = 000000 | Pixel 834 (1,26) = 000000 | Pixel 835 (2,26) = 000000 | Pixel 836 (3,26) = 000000 | Pixel 837 (4,26) = 010101 | Pixel 838 (5,26) = 010101 | Pixel 839 (6,26) = 1B1B1B | Pixel 840 (7,26) = 010101 | Pixel 841 (8,26) = 7A7A7A | Pixel 842 (9,26) = C6C6C6 | Pixel 843 (10,26) = C7C7C7 | Pixel 844 (11,26) = CBCBCB | Pixel 845 (12,26) = CACACA | Pixel 846 (13,26) = CECECE | Pixel 847 (14,26) = CDCCCC | Pixel 848 (15,26) = D54A5E | Pixel 849 (16,26) = D64B60 | Pixel 850 (17,26) = D5D5D5 | Pixel 851 (18,26) = D5D5D5 | Pixel 852 (19,26) = D8D8D8 | Pixel 853 (20,26) = D2D2D2 | Pixel 854 (21,26) = CFCFCF | Pixel 855 (22,26) = CECECE | Pixel 856 (23,26) = 010101 | Pixel 857 (24,26) = 010101 | Pixel 858 (25,26) = 010101 | Pixel 859 (26,26) = 080808 | Pixel 860 (27,26) = 000000 | Pixel 861 (28,26) = 000000 | Pixel 862 (29,26) = 000000 | Pixel 863 (30,26) = 000000 | Pixel 864 (31,26) = 000000
Pixel 865 (0,27) = 1A1A1A | Pixel 866 (1,27) = 1A1A1A | Pixel 867 (2,27) = 1A1A1A | Pixel 868 (3,27) = 1B1B1B | Pixel 869 (4,27) = 1C1C1C | Pixel 870 (5,27) = 1B1B1B | Pixel 871 (6,27) = 1B1B1B | Pixel 872 (7,27) = 010101 | Pixel 873 (8,27) = 010101 | Pixel 874 (9,27) = CBCBCB | Pixel 875 (10,27) = CCCCCC | Pixel 876 (11,27) = CCCCCC | Pixel 877 (12,27) = CDCDCD | Pixel 878 (13,27) = D0D0D0 | Pixel 879 (14,27) = CFCFCF | Pixel 880 (15,27) = D0D0D0 | Pixel 881 (16,27) = CECECE | Pixel 882 (17,27) = D3D3D3 | Pixel 883 (18,27) = D1D1D1 | Pixel 884 (19,27) = D3D3D3 | Pixel 885 (20,27) = CECECE | Pixel 886 (21,27) = CDCDCD | Pixel 887 (22,27) = CACACA | Pixel 888 (23,27) = 010101 | Pixel 889 (24,27) = 010101 | Pixel 890 (25,27) = 222222 | Pixel 891 (26,27) = 020202 | Pixel 892 (27,27) = 020202 | Pixel 893 (28,27) = 232323 | Pixel 894 (29,27) = 242424 | Pixel 895 (30,27) = 242424 | Pixel 896 (31,27) = 242424
Pixel 897 (0,28) = 1A1A1A | Pixel 898 (1,28) = 1A1A1A | Pixel 899 (2,28) = 1A1A1A | Pixel 900 (3,28) = 1C1C1C | Pixel 901 (4,28) = 191919 | Pixel 902 (5,28) = 191919 | Pixel 903 (6,28) = 191919 | Pixel 904 (7,28) = F9F9F9 | Pixel 905 (8,28) = 010101 | Pixel 906 (9,28) = FFFFFF | Pixel 907 (10,28) = CCCCCC | Pixel 908 (11,28) = CDCDCD | Pixel 909 (12,28) = CFCFCF | Pixel 910 (13,28) = CDCDCD | Pixel 911 (14,28) = CECECE | Pixel 912 (15,28) = CFCFCF | Pixel 913 (16,28) = CDCDCD | Pixel 914 (17,28) = CECECE | Pixel 915 (18,28) = CDCDCD | Pixel 916 (19,28) = CDCDCD | Pixel 917 (20,28) = CDCDCD | Pixel 918 (21,28) = C8C8C8 | Pixel 919 (22,28) = C0C0C0 | Pixel 920 (23,28) = 414141 | Pixel 921 (24,28) = FCFCFC | Pixel 922 (25,28) = 222222 | Pixel 923 (26,28) = 222222 | Pixel 924 (27,28) = 232323 | Pixel 925 (28,28) = 010101 | Pixel 926 (29,28) = 242424 | Pixel 927 (30,28) = 242424 | Pixel 928 (31,28) = 252525
Pixel 929 (0,29) = 0D0D0D | Pixel 930 (1,29) = 1D1D1D | Pixel 931 (2,29) = 3A3A3A | Pixel 932 (3,29) = 010101 | Pixel 933 (4,29) = 161616 | Pixel 934 (5,29) = 171717 | Pixel 935 (6,29) = 171717 | Pixel 936 (7,29) = F1F1F1 | Pixel 937 (8,29) = 414141 | Pixel 938 (9,29) = 010101 | Pixel 939 (10,29) = FCFDFD | Pixel 940 (11,29) = FFFFFF | Pixel 941 (12,29) = FFFFFF | Pixel 942 (13,29) = CCCCCC | Pixel 943 (14,29) = CACACA | Pixel 944 (15,29) = CBCBCB | Pixel 945 (16,29) = C9C9C9 | Pixel 946 (17,29) = CACACA | Pixel 947 (18,29) = C9C9C9 | Pixel 948 (19,29) = FFFFFF | Pixel 949 (20,29) = FFFFFF | Pixel 950 (21,29) = C4C7CC | Pixel 951 (22,29) = 010101 | Pixel 952 (23,29) = 9C9C9C | Pixel 953 (24,29) = FFFFFF | Pixel 954 (25,29) = 222222 | Pixel 955 (26,29) = 222222 | Pixel 956 (27,29) = 232323 | Pixel 957 (28,29) = 262626 | Pixel 958 (29,29) = 050505 | Pixel 959 (30,29) = 131313 | Pixel 960 (31,29) = 131313
Pixel 961 (0,30) = 0D0D0D | Pixel 962 (1,30) = 0D0D0D | Pixel 963 (2,30) = 393939 | Pixel 964 (3,30) = 010101 | Pixel 965 (4,30) = 010101 | Pixel 966 (5,30) = 010101 | Pixel 967 (6,30) = 010101 | Pixel 968 (7,30) = 7F7F7F | Pixel 969 (8,30) = C4C4C4 | Pixel 970 (9,30) = 494949 | Pixel 971 (10,30) = D1D1D1 | Pixel 972 (11,30) = 5C5B56 | Pixel 973 (12,30) = C8C8C8 | Pixel 974 (13,30) = BABABA | Pixel 975 (14,30) = CFCFCF | Pixel 976 (15,30) = CFCFCF | Pixel 977 (16,30) = D2D2D2 | Pixel 978 (17,30) = D2D2D2 | Pixel 979 (18,30) = BCBCBC | Pixel 980 (19,30) = CECECE | Pixel 981 (20,30) = 686765 | Pixel 982 (21,30) = 5C5C5C | Pixel 983 (22,30) = 3E3E3E | Pixel 984 (23,30) = CBCBCB | Pixel 985 (24,30) = 454545 | Pixel 986 (25,30) = 010101 | Pixel 987 (26,30) = 010101 | Pixel 988 (27,30) = 010101 | Pixel 989 (28,30) = 080808 | Pixel 990 (29,30) = 050505 | Pixel 991 (30,30) = 131313 | Pixel 992 (31,30) = 131313
Pixel 993 (0,31) = 010101 | Pixel 994 (1,31) = 010101 | Pixel 995 (2,31) = 0B0B0B | Pixel 996 (3,31) = 010101 | Pixel 997 (4,31) = 010101 | Pixel 998 (5,31) = 010101 | Pixel 999 (6,31) = 010101 | Pixel 1000 (7,31) = 010101 | Pixel 1001 (8,31) = C1C1C1 | Pixel 1002 (9,31) = B9B9B9 | Pixel 1003 (10,31) = 262626 | Pixel 1004 (11,31) = C8C8C8 | Pixel 1005 (12,31) = 989898 | Pixel 1006 (13,31) = 9D9D9D | Pixel 1007 (14,31) = ACACAC | Pixel 1008 (15,31) = CECECE | Pixel 1009 (16,31) = D2D2D2 | Pixel 1010 (17,31) = 9E9E9E | Pixel 1011 (18,31) = 9D9D9D | Pixel 1012 (19,31) = B5B5B5 | Pixel 1013 (20,31) = C7C7C7 | Pixel 1014 (21,31) = 7B7B7B | Pixel 1015 (22,31) = CDCDCD | Pixel 1016 (23,31) = B8B8B8 | Pixel 1017 (24,31) = 010101 | Pixel 1018 (25,31) = 010101 | Pixel 1019 (26,31) = 010101 | Pixel 1020 (27,31) = 010101 | Pixel 1021 (28,31) = 080808 | Pixel 1022 (29,31) = 010101 | Pixel 1023 (30,31) = 010101 | Pixel 1024 (31,31) = 010101
        ]]
    },
},
-- ======================-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
-- ======================

-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do
    art[i] = "FFFFFF"
end

-- ======================
-- PARSER UNIVERSAL (linha OU inline)
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do
        art[i] = "FFFFFF"
    end

    if not text or text == "" then
        return 0
    end

    local count = 0

    -- aceita:
    -- Pixel 1 (0,0) = FFFFFF
    -- Pixel 1 = FFFFFF
    -- Pixel 1 (0,0) = FFFFFF | Pixel 2 ...
    for idx, hex in text:gmatch("Pixel%s+(%d+)[^=]*=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count = count + 1
        end
    end

    return count
end

-- ======================
-- ESTADO (PERSISTENTE)
-- ======================
local selectedMap = nil
local loopActive = false
local gui = nil
local frame = nil
local startBtn = nil
local preview = nil

-- ======================
-- FUNÇÃO PARA CRIAR/ATUALIZAR GUI
-- ======================
local function createOrUpdateGUI()
    -- Se a GUI já existe, apenas garanta que está no PlayerGui
    if gui and gui.Parent then
        return gui
    end
    
    -- Se foi destruída, cria novamente
    gui = Instance.new("ScreenGui")
    gui.Name = "PixelPainterHUD"
    gui.ResetOnSpawn = false -- IMPEDE QUE SEJA DESTRUÍDA AO RENASCER
    gui.Parent = player:WaitForChild("PlayerGui")

    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 35, 0, 30)
    toggleBtn.Position = UDim2.new(1, -45, 0, 15)
    toggleBtn.Text = "🎨"
    toggleBtn.TextSize = 20
    toggleBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.BorderSizePixel = 0

    frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 160)
    frame.Position = UDim2.new(1, -250, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,20)
    title.Text = "Pixel Painter"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1

    local artList = Instance.new("ScrollingFrame", frame)
    artList.Size = UDim2.new(1,-10,0,90)
    artList.Position = UDim2.new(0,5,0,25)
    artList.BackgroundColor3 = Color3.fromRGB(40,40,40)
    artList.BorderSizePixel = 0
    artList.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout", artList)
    layout.Padding = UDim.new(0,2)

    preview = Instance.new("TextLabel", frame)
    preview.Size = UDim2.new(1,-10,0,20)
    preview.Position = UDim2.new(0,5,0,120)
    preview.Text = "Preview: selecione"
    preview.Font = Enum.Font.Code
    preview.TextSize = 12
    preview.TextColor3 = Color3.new(1,1,1)
    preview.BackgroundColor3 = Color3.fromRGB(48,48,48)

    startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1,-10,0,20)
    startBtn.Position = UDim2.new(0,5,0,135)
    startBtn.Text = "COMEÇAR"
    startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    startBtn.TextColor3 = Color3.new(1,1,1)
    startBtn.BorderSizePixel = 0

    -- ======================
    -- CONEXÕES DE EVENTOS
    -- ======================
    toggleBtn.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    startBtn.MouseButton1Click:Connect(function()
        loopActive = not loopActive
        startBtn.Text = loopActive and "PARAR" or "COMEÇAR"
        startBtn.BackgroundColor3 = loopActive
            and Color3.fromRGB(50,180,50)
            or Color3.fromRGB(180,50,50)
    end)

    -- ======================
    -- POPULAR LISTA DE ARTES
    -- ======================
    for _, slot in ipairs(ARTS) do
        local btn = Instance.new("TextButton", artList)
        btn.Size = UDim2.new(1,0,0,20)
        btn.Text = slot.name
        btn.TextSize = 12
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BorderSizePixel = 0

        btn.MouseButton1Click:Connect(function()
            selectedMap = slot.map
            preview.Text = "Preview: "..slot.name
        end)
    end

    -- ======================
    -- RESTAURAR ESTADO
    -- ======================
    if selectedMap then
        preview.Text = "Preview: "..(selectedMap.name or "arte_selecionada")
    end
    
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50,180,50)
    else
        startBtn.Text = "COMEÇAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    end

    return gui
end

-- ======================
-- SISTEMA DE MONITORAMENTO ANTI-MORTE
-- ======================
local function monitorGUI()
    while true do
        -- Verifica se o PlayerGui existe
        local playerGui = player:FindFirstChild("PlayerGui")
        if not playerGui then
            task.wait(1)
            continue
        end

        -- Verifica se a GUI ainda está no PlayerGui
        local existingGui = playerGui:FindFirstChild("PixelPainterHUD")
        if not existingGui then
            -- Recria a GUI
            createOrUpdateGUI()
            warn("[Pixel Painter] GUI recriada após morte/respawn")
        end

        task.wait(2) -- Verifica a cada 2 segundos
    end
end

-- ======================
-- INICIALIZAÇÃO
-- ======================
-- Espera o PlayerGui estar disponível
if not player:FindFirstChild("PlayerGui") then
    player.CharacterAdded:Wait()
    task.wait(1)
end

-- Cria a GUI inicial
createOrUpdateGUI()

-- Inicia o monitoramento
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
                count = count + 1

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

-- ======================
-- CONEXÃO PARA RENASCIMENTO
-- ======================
player.CharacterAdded:Connect(function()
    task.wait(1) -- Espera o PlayerGui ser recriado
    if not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
        warn("[Pixel Painter] GUI recriada após respawn do personagem")
    end
end)

-- Garante que a GUI seja recriada se o PlayerGui for resetado
player:GetPropertyChangedSignal("PlayerGui"):Connect(function()
    task.wait(0.5)
    if not player.PlayerGui:FindFirstChild("PixelPainterHUD") then
        createOrUpdateGUI()
        warn("[Pixel Painter] GUI recriada após mudança no PlayerGui")
    end
end)

print("🎨 Pixel Painter HUD carregada (sistema anti-morte ativado)")
