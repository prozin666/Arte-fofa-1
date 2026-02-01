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
-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇
local ARTS = {
    {
        name = "Gu",
        map = [[
Pixel 1 (0,0) = 000000 | Pixel 2 (1,0) = 000000 | Pixel 3 (2,0) = 000000 | Pixel 4 (3,0) = 000000 | Pixel 5 (4,0) = 000000 | Pixel 6 (5,0) = 000000 | Pixel 7 (6,0) = 000000 | Pixel 8 (7,0) = 000000 | Pixel 9 (8,0) = 000000 | Pixel 10 (9,0) = 000000 | Pixel 11 (10,0) = 000000 | Pixel 12 (11,0) = 000000 | Pixel 13 (12,0) = 000000 | Pixel 14 (13,0) = 000000 | Pixel 15 (14,0) = 000000 | Pixel 16 (15,0) = 000000 | Pixel 17 (16,0) = 000000 | Pixel 18 (17,0) = 000000 | Pixel 19 (18,0) = 000000 | Pixel 20 (19,0) = 000000 | Pixel 21 (20,0) = 000000 | Pixel 22 (21,0) = 000000 | Pixel 23 (22,0) = 000000 | Pixel 24 (23,0) = 000000 | Pixel 25 (24,0) = 000000 | Pixel 26 (25,0) = 000000 | Pixel 27 (26,0) = 000000 | Pixel 28 (27,0) = 000000 | Pixel 29 (28,0) = 000000 | Pixel 30 (29,0) = 000000 | Pixel 31 (30,0) = 000000 | Pixel 32 (31,0) = 000000
Pixel 33 (0,1) = 000000 | Pixel 34 (1,1) = 000000 | Pixel 35 (2,1) = 000000 | Pixel 36 (3,1) = 000000 | Pixel 37 (4,1) = 000000 | Pixel 38 (5,1) = 000000 | Pixel 39 (6,1) = 000000 | Pixel 40 (7,1) = 000000 | Pixel 41 (8,1) = 000000 | Pixel 42 (9,1) = 000000 | Pixel 43 (10,1) = 000000 | Pixel 44 (11,1) = 000000 | Pixel 45 (12,1) = 000000 | Pixel 46 (13,1) = 000000 | Pixel 47 (14,1) = 000000 | Pixel 48 (15,1) = 000000 | Pixel 49 (16,1) = 000000 | Pixel 50 (17,1) = 000000 | Pixel 51 (18,1) = 000000 | Pixel 52 (19,1) = 000000 | Pixel 53 (20,1) = 000000 | Pixel 54 (21,1) = 000000 | Pixel 55 (22,1) = 000000 | Pixel 56 (23,1) = 000000 | Pixel 57 (24,1) = 000000 | Pixel 58 (25,1) = 000000 | Pixel 59 (26,1) = 000000 | Pixel 60 (27,1) = 000000 | Pixel 61 (28,1) = 000000 | Pixel 62 (29,1) = 000000 | Pixel 63 (30,1) = 000000 | Pixel 64 (31,1) = 000000
Pixel 65 (0,2) = 000000 | Pixel 66 (1,2) = 000000 | Pixel 67 (2,2) = 000000 | Pixel 68 (3,2) = 000000 | Pixel 69 (4,2) = 000000 | Pixel 70 (5,2) = 000000 | Pixel 71 (6,2) = 000000 | Pixel 72 (7,2) = 000000 | Pixel 73 (8,2) = 000000 | Pixel 74 (9,2) = 000000 | Pixel 75 (10,2) = 000000 | Pixel 76 (11,2) = 000000 | Pixel 77 (12,2) = 000000 | Pixel 78 (13,2) = 000000 | Pixel 79 (14,2) = 000000 | Pixel 80 (15,2) = 000000 | Pixel 81 (16,2) = 000000 | Pixel 82 (17,2) = 000000 | Pixel 83 (18,2) = 000000 | Pixel 84 (19,2) = 000000 | Pixel 85 (20,2) = 000000 | Pixel 86 (21,2) = 000000 | Pixel 87 (22,2) = 000000 | Pixel 88 (23,2) = 000000 | Pixel 89 (24,2) = 000000 | Pixel 90 (25,2) = 000000 | Pixel 91 (26,2) = 000000 | Pixel 92 (27,2) = 000000 | Pixel 93 (28,2) = 000000 | Pixel 94 (29,2) = 000000 | Pixel 95 (30,2) = 000000 | Pixel 96 (31,2) = 000000
Pixel 97 (0,3) = 000000 | Pixel 98 (1,3) = 000000 | Pixel 99 (2,3) = 000000 | Pixel 100 (3,3) = 000000 | Pixel 101 (4,3) = 000000 | Pixel 102 (5,3) = 000000 | Pixel 103 (6,3) = 000000 | Pixel 104 (7,3) = 000000 | Pixel 105 (8,3) = 000000 | Pixel 106 (9,3) = 000000 | Pixel 107 (10,3) = 000000 | Pixel 108 (11,3) = 000000 | Pixel 109 (12,3) = 000000 | Pixel 110 (13,3) = 000000 | Pixel 111 (14,3) = 000000 | Pixel 112 (15,3) = 000000 | Pixel 113 (16,3) = 000000 | Pixel 114 (17,3) = 000000 | Pixel 115 (18,3) = 000000 | Pixel 116 (19,3) = 000000 | Pixel 117 (20,3) = 000000 | Pixel 118 (21,3) = 000000 | Pixel 119 (22,3) = 000000 | Pixel 120 (23,3) = 000000 | Pixel 121 (24,3) = 000000 | Pixel 122 (25,3) = 000000 | Pixel 123 (26,3) = 000000 | Pixel 124 (27,3) = 000000 | Pixel 125 (28,3) = 000000 | Pixel 126 (29,3) = 000000 | Pixel 127 (30,3) = 000000 | Pixel 128 (31,3) = 000000
Pixel 129 (0,4) = 000000 | Pixel 130 (1,4) = 000000 | Pixel 131 (2,4) = 000000 | Pixel 132 (3,4) = 000000 | Pixel 133 (4,4) = 000000 | Pixel 134 (5,4) = 000000 | Pixel 135 (6,4) = 000000 | Pixel 136 (7,4) = 000000 | Pixel 137 (8,4) = 000000 | Pixel 138 (9,4) = 000000 | Pixel 139 (10,4) = 000000 | Pixel 140 (11,4) = 000000 | Pixel 141 (12,4) = 000000 | Pixel 142 (13,4) = 000000 | Pixel 143 (14,4) = 000000 | Pixel 144 (15,4) = 000000 | Pixel 145 (16,4) = 000000 | Pixel 146 (17,4) = 000000 | Pixel 147 (18,4) = 000000 | Pixel 148 (19,4) = 000000 | Pixel 149 (20,4) = 000000 | Pixel 150 (21,4) = 000000 | Pixel 151 (22,4) = 000000 | Pixel 152 (23,4) = 000000 | Pixel 153 (24,4) = 000000 | Pixel 154 (25,4) = 000000 | Pixel 155 (26,4) = 000000 | Pixel 156 (27,4) = 000000 | Pixel 157 (28,4) = 000000 | Pixel 158 (29,4) = 000000 | Pixel 159 (30,4) = 000000 | Pixel 160 (31,4) = 000000
Pixel 161 (0,5) = 000000 | Pixel 162 (1,5) = 000000 | Pixel 163 (2,5) = 000000 | Pixel 164 (3,5) = 000000 | Pixel 165 (4,5) = 000000 | Pixel 166 (5,5) = 000000 | Pixel 167 (6,5) = 000000 | Pixel 168 (7,5) = 000000 | Pixel 169 (8,5) = 000000 | Pixel 170 (9,5) = 000000 | Pixel 171 (10,5) = 000000 | Pixel 172 (11,5) = 000000 | Pixel 173 (12,5) = 000000 | Pixel 174 (13,5) = 000000 | Pixel 175 (14,5) = 000000 | Pixel 176 (15,5) = 000000 | Pixel 177 (16,5) = 000000 | Pixel 178 (17,5) = 000000 | Pixel 179 (18,5) = 000000 | Pixel 180 (19,5) = 000000 | Pixel 181 (20,5) = 000000 | Pixel 182 (21,5) = 000000 | Pixel 183 (22,5) = 000000 | Pixel 184 (23,5) = 000000 | Pixel 185 (24,5) = 000000 | Pixel 186 (25,5) = 000000 | Pixel 187 (26,5) = 000000 | Pixel 188 (27,5) = 000000 | Pixel 189 (28,5) = 000000 | Pixel 190 (29,5) = 000000 | Pixel 191 (30,5) = 000000 | Pixel 192 (31,5) = 000000
Pixel 193 (0,6) = 000000 | Pixel 194 (1,6) = 000000 | Pixel 195 (2,6) = 000000 | Pixel 196 (3,6) = 000000 | Pixel 197 (4,6) = 000000 | Pixel 198 (5,6) = 000000 | Pixel 199 (6,6) = 000000 | Pixel 200 (7,6) = 000000 | Pixel 201 (8,6) = 000000 | Pixel 202 (9,6) = 000000 | Pixel 203 (10,6) = 000000 | Pixel 204 (11,6) = 000000 | Pixel 205 (12,6) = 000000 | Pixel 206 (13,6) = 000000 | Pixel 207 (14,6) = 000000 | Pixel 208 (15,6) = 000000 | Pixel 209 (16,6) = 000000 | Pixel 210 (17,6) = 000000 | Pixel 211 (18,6) = 000000 | Pixel 212 (19,6) = 000000 | Pixel 213 (20,6) = 000000 | Pixel 214 (21,6) = 000000 | Pixel 215 (22,6) = 000000 | Pixel 216 (23,6) = 000000 | Pixel 217 (24,6) = 000000 | Pixel 218 (25,6) = 000000 | Pixel 219 (26,6) = 000000 | Pixel 220 (27,6) = 000000 | Pixel 221 (28,6) = 000000 | Pixel 222 (29,6) = 000000 | Pixel 223 (30,6) = 000000 | Pixel 224 (31,6) = 000000
Pixel 225 (0,7) = 000000 | Pixel 226 (1,7) = 000000 | Pixel 227 (2,7) = 000000 | Pixel 228 (3,7) = 000000 | Pixel 229 (4,7) = 000000 | Pixel 230 (5,7) = 000000 | Pixel 231 (6,7) = 000000 | Pixel 232 (7,7) = 000000 | Pixel 233 (8,7) = 000000 | Pixel 234 (9,7) = 000000 | Pixel 235 (10,7) = 000000 | Pixel 236 (11,7) = 000000 | Pixel 237 (12,7) = 000000 | Pixel 238 (13,7) = 000000 | Pixel 239 (14,7) = 000000 | Pixel 240 (15,7) = 000000 | Pixel 241 (16,7) = 000000 | Pixel 242 (17,7) = 000000 | Pixel 243 (18,7) = 000000 | Pixel 244 (19,7) = 000000 | Pixel 245 (20,7) = 000000 | Pixel 246 (21,7) = 000000 | Pixel 247 (22,7) = 000000 | Pixel 248 (23,7) = 000000 | Pixel 249 (24,7) = 000000 | Pixel 250 (25,7) = 000000 | Pixel 251 (26,7) = 000000 | Pixel 252 (27,7) = 000000 | Pixel 253 (28,7) = 000000 | Pixel 254 (29,7) = 000000 | Pixel 255 (30,7) = 000000 | Pixel 256 (31,7) = 000000
Pixel 257 (0,8) = 000000 | Pixel 258 (1,8) = 000000 | Pixel 259 (2,8) = 000000 | Pixel 260 (3,8) = 000000 | Pixel 261 (4,8) = 000000 | Pixel 262 (5,8) = 000000 | Pixel 263 (6,8) = 000000 | Pixel 264 (7,8) = 000000 | Pixel 265 (8,8) = 000000 | Pixel 266 (9,8) = 000000 | Pixel 267 (10,8) = 000000 | Pixel 268 (11,8) = 000000 | Pixel 269 (12,8) = 5A4E47 | Pixel 270 (13,8) = 665751 | Pixel 271 (14,8) = 675C53 | Pixel 272 (15,8) = 6F5F56 | Pixel 273 (16,8) = 806F67 | Pixel 274 (17,8) = 867A70 | Pixel 275 (18,8) = 96857E | Pixel 276 (19,8) = 86786F | Pixel 277 (20,8) = 000000 | Pixel 278 (21,8) = 000000 | Pixel 279 (22,8) = 000000 | Pixel 280 (23,8) = 000000 | Pixel 281 (24,8) = 000000 | Pixel 282 (25,8) = 000000 | Pixel 283 (26,8) = 000000 | Pixel 284 (27,8) = 000000 | Pixel 285 (28,8) = 000000 | Pixel 286 (29,8) = 000000 | Pixel 287 (30,8) = 000000 | Pixel 288 (31,8) = 000000
Pixel 289 (0,9) = 000000 | Pixel 290 (1,9) = 000000 | Pixel 291 (2,9) = 000000 | Pixel 292 (3,9) = 000000 | Pixel 293 (4,9) = 000000 | Pixel 294 (5,9) = 000000 | Pixel 295 (6,9) = 000000 | Pixel 296 (7,9) = 000000 | Pixel 297 (8,9) = 000000 | Pixel 298 (9,9) = 000000 | Pixel 299 (10,9) = 000000 | Pixel 300 (11,9) = 564B45 | Pixel 301 (12,9) = 61554D | Pixel 302 (13,9) = 665A55 | Pixel 303 (14,9) = 695C54 | Pixel 304 (15,9) = 6B5D55 | Pixel 305 (16,9) = 7B6D66 | Pixel 306 (17,9) = 867870 | Pixel 307 (18,9) = 978984 | Pixel 308 (19,9) = 9F9087 | Pixel 309 (20,9) = 908279 | Pixel 310 (21,9) = 000000 | Pixel 311 (22,9) = 000000 | Pixel 312 (23,9) = 000000 | Pixel 313 (24,9) = 000000 | Pixel 314 (25,9) = 000000 | Pixel 315 (26,9) = 000000 | Pixel 316 (27,9) = 000000 | Pixel 317 (28,9) = 000000 | Pixel 318 (29,9) = 000000 | Pixel 319 (30,9) = 000000 | Pixel 320 (31,9) = 000000
Pixel 321 (0,10) = 000000 | Pixel 322 (1,10) = 000000 | Pixel 323 (2,10) = 000000 | Pixel 324 (3,10) = 000000 | Pixel 325 (4,10) = 000000 | Pixel 326 (5,10) = 000000 | Pixel 327 (6,10) = 000000 | Pixel 328 (7,10) = D3D3D3 | Pixel 329 (8,10) = FFFFFF | Pixel 330 (9,10) = FFFFFF | Pixel 331 (10,10) = 413933 | Pixel 332 (11,10) = 574E47 | Pixel 333 (12,10) = 5D504A | Pixel 334 (13,10) = 584D47 | Pixel 335 (14,10) = 574B45 | Pixel 336 (15,10) = 564A43 | Pixel 337 (16,10) = 584C45 | Pixel 338 (17,10) = 5A4E48 | Pixel 339 (18,10) = 5E524B | Pixel 340 (19,10) = 9E8D85 | Pixel 341 (20,10) = 9B8E87 | Pixel 342 (21,10) = 86776E | Pixel 343 (22,10) = C1C1C1 | Pixel 344 (23,10) = F7F7F7 | Pixel 345 (24,10) = FFFFFF | Pixel 346 (25,10) = 000000 | Pixel 347 (26,10) = 000000 | Pixel 348 (27,10) = 000000 | Pixel 349 (28,10) = 000000 | Pixel 350 (29,10) = 000000 | Pixel 351 (30,10) = 000000 | Pixel 352 (31,10) = 000000
Pixel 353 (0,11) = 000000 | Pixel 354 (1,11) = 000000 | Pixel 355 (2,11) = 000000 | Pixel 356 (3,11) = 000000 | Pixel 357 (4,11) = 000000 | Pixel 358 (5,11) = 000000 | Pixel 359 (6,11) = BABABA | Pixel 360 (7,11) = D1D1D1 | Pixel 361 (8,11) = DCDCDC | Pixel 362 (9,11) = 443A36 | Pixel 363 (10,11) = 4D443F | Pixel 364 (11,11) = 574C45 | Pixel 365 (12,11) = 60534C | Pixel 366 (13,11) = 524842 | Pixel 367 (14,11) = 655750 | Pixel 368 (15,11) = 837874 | Pixel 369 (16,11) = 5E504B | Pixel 370 (17,11) = 645650 | Pixel 371 (18,11) = 5D4F4A | Pixel 372 (19,11) = 655750 | Pixel 373 (20,11) = 95857C | Pixel 374 (21,11) = 84766E | Pixel 375 (22,11) = 89786F | Pixel 376 (23,11) = DEDEDE | Pixel 377 (24,11) = E7E7E7 | Pixel 378 (25,11) = FFFFFF | Pixel 379 (26,11) = 000000 | Pixel 380 (27,11) = 000000 | Pixel 381 (28,11) = 000000 | Pixel 382 (29,11) = 000000 | Pixel 383 (30,11) = 000000 | Pixel 384 (31,11) = 000000
Pixel 385 (0,12) = 000000 | Pixel 386 (1,12) = 000000 | Pixel 387 (2,12) = 000000 | Pixel 388 (3,12) = 000000 | Pixel 389 (4,12) = 000000 | Pixel 390 (5,12) = 000000 | Pixel 391 (6,12) = 5C514A | Pixel 392 (7,12) = D5D5D5 | Pixel 393 (8,12) = D6D6D6 | Pixel 394 (9,12) = 584B46 | Pixel 395 (10,12) = 544943 | Pixel 396 (11,12) = 5E524C | Pixel 397 (12,12) = 4A4039 | Pixel 398 (13,12) = 524741 | Pixel 399 (14,12) = 5B4F49 | Pixel 400 (15,12) = D4D4D4 | Pixel 401 (16,12) = 574B45 | Pixel 402 (17,12) = 514641 | Pixel 403 (18,12) = 50473F | Pixel 404 (19,12) = 544842 | Pixel 405 (20,12) = 645751 | Pixel 406 (21,12) = 776961 | Pixel 407 (22,12) = 917F77 | Pixel 408 (23,12) = DBDBDB | Pixel 409 (24,12) = DCDCDC | Pixel 410 (25,12) = 8B8079 | Pixel 411 (26,12) = 000000 | Pixel 412 (27,12) = 000000 | Pixel 413 (28,12) = 000000 | Pixel 414 (29,12) = 000000 | Pixel 415 (30,12) = 000000 | Pixel 416 (31,12) = 000000
Pixel 417 (0,13) = 000000 | Pixel 418 (1,13) = 000000 | Pixel 419 (2,13) = 000000 | Pixel 420 (3,13) = 000000 | Pixel 421 (4,13) = 000000 | Pixel 422 (5,13) = 6B5E56 | Pixel 423 (6,13) = 594D47 | Pixel 424 (7,13) = CBCBCB | Pixel 425 (8,13) = 4B3F3A | Pixel 426 (9,13) = 514740 | Pixel 427 (10,13) = 4E443F | Pixel 428 (11,13) = 5A4E47 | Pixel 429 (12,13) = 4F453E | Pixel 430 (13,13) = 544640 | Pixel 431 (14,13) = 504740 | Pixel 432 (15,13) = D7D7D7 | Pixel 433 (16,13) = 4F453F | Pixel 434 (17,13) = 524941 | Pixel 435 (18,13) = 544A42 | Pixel 436 (19,13) = 53483F | Pixel 437 (20,13) = 5D514A | Pixel 438 (21,13) = 756760 | Pixel 439 (22,13) = 827369 | Pixel 440 (23,13) = 847167 | Pixel 441 (24,13) = BEBEBE | Pixel 442 (25,13) = 8C7E76 | Pixel 443 (26,13) = 665952 | Pixel 444 (27,13) = 000000 | Pixel 445 (28,13) = 000000 | Pixel 446 (29,13) = 000000 | Pixel 447 (30,13) = 000000 | Pixel 448 (31,13) = 000000
Pixel 449 (0,14) = 000000 | Pixel 450 (1,14) = 000000 | Pixel 451 (2,14) = 000000 | Pixel 452 (3,14) = 000000 | Pixel 453 (4,14) = 59504A | Pixel 454 (5,14) = 5E534B | Pixel 455 (6,14) = 736660 | Pixel 456 (7,14) = 000000 | Pixel 457 (8,14) = 4F443C | Pixel 458 (9,14) = 504641 | Pixel 459 (10,14) = 544A44 | Pixel 460 (11,14) = 534845 | Pixel 461 (12,14) = 584E48 | Pixel 462 (13,14) = 524640 | Pixel 463 (14,14) = D3D3D3 | Pixel 464 (15,14) = D4D4D4 | Pixel 465 (16,14) = 564C43 | Pixel 466 (17,14) = 554A42 | Pixel 467 (18,14) = 574C47 | Pixel 468 (19,14) = 584D47 | Pixel 469 (20,14) = 574C42 | Pixel 470 (21,14) = 574C46 | Pixel 471 (22,14) = 625651 | Pixel 472 (23,14) = 78675D | Pixel 473 (24,14) = 000000 | Pixel 474 (25,14) = 685C56 | Pixel 475 (26,14) = 877B71 | Pixel 476 (27,14) = 92867F | Pixel 477 (28,14) = 000000 | Pixel 478 (29,14) = 000000 | Pixel 479 (30,14) = 000000 | Pixel 480 (31,14) = 000000
Pixel 481 (0,15) = 000000 | Pixel 482 (1,15) = 000000 | Pixel 483 (2,15) = 000000 | Pixel 484 (3,15) = 000000 | Pixel 485 (4,15) = 685A53 | Pixel 486 (5,15) = 61574E | Pixel 487 (6,15) = 776861 | Pixel 488 (7,15) = 000000 | Pixel 489 (8,15) = 52443F | Pixel 490 (9,15) = 4B413C | Pixel 491 (10,15) = 534841 | Pixel 492 (11,15) = 5F534B | Pixel 493 (12,15) = 564B46 | Pixel 494 (13,15) = 534941 | Pixel 495 (14,15) = D3D3D3 | Pixel 496 (15,15) = D4D4D4 | Pixel 497 (16,15) = 5F534A | Pixel 498 (17,15) = 5E5048 | Pixel 499 (18,15) = 645751 | Pixel 500 (19,15) = 584D47 | Pixel 501 (20,15) = 5C5049 | Pixel 502 (21,15) = 564A43 | Pixel 503 (22,15) = 645852 | Pixel 504 (23,15) = 695851 | Pixel 505 (24,15) = 000000 | Pixel 506 (25,15) = 5A4E48 | Pixel 507 (26,15) = 6D635A | Pixel 508 (27,15) = 635650 | Pixel 509 (28,15) = 000000 | Pixel 510 (29,15) = 000000 | Pixel 511 (30,15) = 000000 | Pixel 512 (31,15) = 000000
Pixel 513 (0,16) = 000000 | Pixel 514 (1,16) = 000000 | Pixel 515 (2,16) = 000000 | Pixel 516 (3,16) = 000000 | Pixel 517 (4,16) = 655852 | Pixel 518 (5,16) = 4D433E | Pixel 519 (6,16) = 776961 | Pixel 520 (7,16) = 000000 | Pixel 521 (8,16) = 5A4C48 | Pixel 522 (9,16) = 4A413A | Pixel 523 (10,16) = 4E423C | Pixel 524 (11,16) = 62564E | Pixel 525 (12,16) = 5D5049 | Pixel 526 (13,16) = CCCCCC | Pixel 527 (14,16) = 9E9E9E | Pixel 528 (15,16) = D0D0D0 | Pixel 529 (16,16) = D4D4D4 | Pixel 530 (17,16) = 5B4E47 | Pixel 531 (18,16) = 5F524B | Pixel 532 (19,16) = 5B4E46 | Pixel 533 (20,16) = 62544E | Pixel 534 (21,16) = 51453F | Pixel 535 (22,16) = 5E524B | Pixel 536 (23,16) = 685954 | Pixel 537 (24,16) = 000000 | Pixel 538 (25,16) = 594D46 | Pixel 539 (26,16) = 85766E | Pixel 540 (27,16) = 83756D | Pixel 541 (28,16) = 000000 | Pixel 542 (29,16) = 000000 | Pixel 543 (30,16) = 000000 | Pixel 544 (31,16) = 000000
Pixel 545 (0,17) = 000000 | Pixel 546 (1,17) = 000000 | Pixel 547 (2,17) = 000000 | Pixel 548 (3,17) = 554943 | Pixel 549 (4,17) = 5F544C | Pixel 550 (5,17) = 463C38 | Pixel 551 (6,17) = 796B66 | Pixel 552 (7,17) = 000000 | Pixel 553 (8,17) = 463D38 | Pixel 554 (9,17) = 493F3A | Pixel 555 (10,17) = 52453F | Pixel 556 (11,17) = BBBBBB | Pixel 557 (12,17) = C7C7C7 | Pixel 558 (13,17) = CCCCCC | Pixel 559 (14,17) = D0D0D0 | Pixel 560 (15,17) = D0D0D0 | Pixel 561 (16,17) = D4D4D4 | Pixel 562 (17,17) = 544842 | Pixel 563 (18,17) = 534943 | Pixel 564 (19,17) = 50443F | Pixel 565 (20,17) = 594D47 | Pixel 566 (21,17) = 544741 | Pixel 567 (22,17) = 574C46 | Pixel 568 (23,17) = 5E524C | Pixel 569 (24,17) = 000000 | Pixel 570 (25,17) = 554946 | Pixel 571 (26,17) = 7F716A | Pixel 572 (27,17) = 7A6D65 | Pixel 573 (28,17) = 8C7B73 | Pixel 574 (29,17) = 000000 | Pixel 575 (30,17) = 000000 | Pixel 576 (31,17) = 000000
Pixel 577 (0,18) = 000000 | Pixel 578 (1,18) = 000000 | Pixel 579 (2,18) = 000000 | Pixel 580 (3,18) = 635750 | Pixel 581 (4,18) = 5F544D | Pixel 582 (5,18) = 483D38 | Pixel 583 (6,18) = 796B66 | Pixel 584 (7,18) = 000000 | Pixel 585 (8,18) = 4A403B | Pixel 586 (9,18) = 4C423D | Pixel 587 (10,18) = 776F6B | Pixel 588 (11,18) = C2C2C2 | Pixel 589 (12,18) = C7C7C7 | Pixel 590 (13,18) = CCCCCC | Pixel 591 (14,18) = D0D0D0 | Pixel 592 (15,18) = D0D0D0 | Pixel 593 (16,18) = D4D4D4 | Pixel 594 (17,18) = D6D6D6 | Pixel 595 (18,18) = D9D9D9 | Pixel 596 (19,18) = D8D8D8 | Pixel 597 (20,18) = DFDFDF | Pixel 598 (21,18) = 877F7B | Pixel 599 (22,18) = 574C46 | Pixel 600 (23,18) = 5E524B | Pixel 601 (24,18) = 000000 | Pixel 602 (25,18) = 534844 | Pixel 603 (26,18) = 7E6E66 | Pixel 604 (27,18) = 6F635C | Pixel 605 (28,18) = 73665E | Pixel 606 (29,18) = 000000 | Pixel 607 (30,18) = 000000 | Pixel 608 (31,18) = 000000
Pixel 609 (0,19) = 000000 | Pixel 610 (1,19) = 000000 | Pixel 611 (2,19) = 000000 | Pixel 612 (3,19) = 5C514B | Pixel 613 (4,19) = 62564F | Pixel 614 (5,19) = 4A3F39 | Pixel 615 (6,19) = 000000 | Pixel 616 (7,19) = 000000 | Pixel 617 (8,19) = 4E433D | Pixel 618 (9,19) = 4E443E | Pixel 619 (10,19) = 786F6B | Pixel 620 (11,19) = BEBDBD | Pixel 621 (12,19) = C7C6C7 | Pixel 622 (13,19) = B9B6B7 | Pixel 623 (14,19) = CFCFCF | Pixel 624 (15,19) = D0D0D0 | Pixel 625 (16,19) = D0D0D0 | Pixel 626 (17,19) = D4D4D4 | Pixel 627 (18,19) = CAC9C9 | Pixel 628 (19,19) = D4D3D3 | Pixel 629 (20,19) = CFCDCD | Pixel 630 (21,19) = 89817D | Pixel 631 (22,19) = 554A43 | Pixel 632 (23,19) = 5B4D47 | Pixel 633 (24,19) = 000000 | Pixel 634 (25,19) = 000000 | Pixel 635 (26,19) = 7A6961 | Pixel 636 (27,19) = 6E605A | Pixel 637 (28,19) = 756861 | Pixel 638 (29,19) = 000000 | Pixel 639 (30,19) = 000000 | Pixel 640 (31,19) = 000000
Pixel 641 (0,20) = 000000 | Pixel 642 (1,20) = 000000 | Pixel 643 (2,20) = 000000 | Pixel 644 (3,20) = 594F49 | Pixel 645 (4,20) = 61544F | Pixel 646 (5,20) = 4B413C | Pixel 647 (6,20) = 7A6C65 | Pixel 648 (7,20) = 000000 | Pixel 649 (8,20) = 4F4440 | Pixel 650 (9,20) = 514641 | Pixel 651 (10,20) = 5C4F48 | Pixel 652 (11,20) = C1B7B8 | Pixel 653 (12,20) = C6BBBD | Pixel 654 (13,20) = C7C0C2 | Pixel 655 (14,20) = CFCFCF | Pixel 656 (15,20) = D0D0D0 | Pixel 657 (16,20) = D0D0D0 | Pixel 658 (17,20) = D4D3D4 | Pixel 659 (18,20) = D8D0D1 | Pixel 660 (19,20) = D3C7C9 | Pixel 661 (20,20) = DACED0 | Pixel 662 (21,20) = 5E524B | Pixel 663 (22,20) = 584C46 | Pixel 664 (23,20) = 554A45 | Pixel 665 (24,20) = 000000 | Pixel 666 (25,20) = 524742 | Pixel 667 (26,20) = 74655E | Pixel 668 (27,20) = 655852 | Pixel 669 (28,20) = 6F635C | Pixel 670 (29,20) = 000000 | Pixel 671 (30,20) = 000000 | Pixel 672 (31,20) = 000000
Pixel 673 (0,21) = 000000 | Pixel 674 (1,21) = 000000 | Pixel 675 (2,21) = 514641 | Pixel 676 (3,21) = 5D514B | Pixel 677 (4,21) = 5A4F48 | Pixel 678 (5,21) = 4D433D | Pixel 679 (6,21) = 776962 | Pixel 680 (7,21) = 000000 | Pixel 681 (8,21) = 000000 | Pixel 682 (9,21) = 514741 | Pixel 683 (10,21) = 584D47 | Pixel 684 (11,21) = C1B7B9 | Pixel 685 (12,21) = C5BABD | Pixel 686 (13,21) = C9C6C6 | Pixel 687 (14,21) = CECECE | Pixel 688 (15,21) = D0D0D0 | Pixel 689 (16,21) = D1D1D1 | Pixel 690 (17,21) = D4D4D4 | Pixel 691 (18,21) = D6D1D2 | Pixel 692 (19,21) = D1C7C8 | Pixel 693 (20,21) = CEC4C5 | Pixel 694 (21,21) = 5B4F49 | Pixel 695 (22,21) = 554A44 | Pixel 696 (23,21) = 020101 | Pixel 697 (24,21) = 000000 | Pixel 698 (25,21) = 534943 | Pixel 699 (26,21) = 6F615A | Pixel 700 (27,21) = 5A4E48 | Pixel 701 (28,21) = 71635C | Pixel 702 (29,21) = 86746E | Pixel 703 (30,21) = 000000 | Pixel 704 (31,21) = 000000
Pixel 705 (0,22) = 000000 | Pixel 706 (1,22) = 000000 | Pixel 707 (2,22) = 534742 | Pixel 708 (3,22) = 61544F | Pixel 709 (4,22) = 5B4F48 | Pixel 710 (5,22) = 50443F | Pixel 711 (6,22) = 75665F | Pixel 712 (7,22) = 000000 | Pixel 713 (8,22) = 000000 | Pixel 714 (9,22) = 584B46 | Pixel 715 (10,22) = 594D47 | Pixel 716 (11,22) = C7C7C7 | Pixel 717 (12,22) = C8C7C8 | Pixel 718 (13,22) = C8C8C8 | Pixel 719 (14,22) = CDCDCD | Pixel 720 (15,22) = CDCDCD | Pixel 721 (16,22) = CDCDCD | Pixel 722 (17,22) = CDCDCD | Pixel 723 (18,22) = CFCFCF | Pixel 724 (19,22) = CBCACB | Pixel 725 (20,22) = C8C8C8 | Pixel 726 (21,22) = 5C4F4A | Pixel 727 (22,22) = 5E504A | Pixel 728 (23,22) = 000000 | Pixel 729 (24,22) = 000000 | Pixel 730 (25,22) = 544944 | Pixel 731 (26,22) = 6B5C55 | Pixel 732 (27,22) = 544842 | Pixel 733 (28,22) = 72635E | Pixel 734 (29,22) = 85736B | Pixel 735 (30,22) = 000000 | Pixel 736 (31,22) = 000000
Pixel 737 (0,23) = 000000 | Pixel 738 (1,23) = 000000 | Pixel 739 (2,23) = 4F453F | Pixel 740 (3,23) = 584E48 | Pixel 741 (4,23) = 584C46 | Pixel 742 (5,23) = 504640 | Pixel 743 (6,23) = 70625B | Pixel 744 (7,23) = 000000 | Pixel 745 (8,23) = 000000 | Pixel 746 (9,23) = 544944 | Pixel 747 (10,23) = 86807C | Pixel 748 (11,23) = CECECE | Pixel 749 (12,23) = CDCDCD | Pixel 750 (13,23) = CFCFCF | Pixel 751 (14,23) = CCCCCC | Pixel 752 (15,23) = CDCDCD | Pixel 753 (16,23) = CDCDCD | Pixel 754 (17,23) = CACACA | Pixel 755 (18,23) = C9C9C9 | Pixel 756 (19,23) = C7C7C7 | Pixel 757 (20,23) = C1C1C1 | Pixel 758 (21,23) = 675E59 | Pixel 759 (22,23) = 564A45 | Pixel 760 (23,23) = 000000 | Pixel 761 (24,23) = 000000 | Pixel 762 (25,23) = 564A45 | Pixel 763 (26,23) = 63574F | Pixel 764 (27,23) = 534842 | Pixel 765 (28,23) = 645951 | Pixel 766 (29,23) = 7D6D63 | Pixel 767 (30,23) = 000000 | Pixel 768 (31,23) = 000000
Pixel 769 (0,24) = 000000 | Pixel 770 (1,24) = 000000 | Pixel 771 (2,24) = 584C44 | Pixel 772 (3,24) = 5D504A | Pixel 773 (4,24) = 5C504B | Pixel 774 (5,24) = 4F4640 | Pixel 775 (6,24) = 695B55 | Pixel 776 (7,24) = 000000 | Pixel 777 (8,24) = 000000 | Pixel 778 (9,24) = 000000 | Pixel 779 (10,24) = 000000 | Pixel 780 (11,24) = 000000 | Pixel 781 (12,24) = FFFFFF | Pixel 782 (13,24) = CACACA | Pixel 783 (14,24) = C8C8C8 | Pixel 784 (15,24) = C6C6C6 | Pixel 785 (16,24) = C8C8C8 | Pixel 786 (17,24) = C5C5C5 | Pixel 787 (18,24) = C0C0C0 | Pixel 788 (19,24) = 000000 | Pixel 789 (20,24) = 000000 | Pixel 790 (21,24) = 000000 | Pixel 791 (22,24) = 000000 | Pixel 792 (23,24) = 000000 | Pixel 793 (24,24) = 000000 | Pixel 794 (25,24) = 534843 | Pixel 795 (26,24) = 5C514A | Pixel 796 (27,24) = 5B4F4A | Pixel 797 (28,24) = 655750 | Pixel 798 (29,24) = 72635A | Pixel 799 (30,24) = 000000 | Pixel 800 (31,24) = 000000
Pixel 801 (0,25) = 000000 | Pixel 802 (1,25) = 000000 | Pixel 803 (2,25) = 574C45 | Pixel 804 (3,25) = 5F524B | Pixel 805 (4,25) = 5A4F49 | Pixel 806 (5,25) = 544A44 | Pixel 807 (6,25) = 675B54 | Pixel 808 (7,25) = 000000 | Pixel 809 (8,25) = 000000 | Pixel 810 (9,25) = EAD1D8 | Pixel 811 (10,25) = FFEFF7 | Pixel 812 (11,25) = FFFFFF | Pixel 813 (12,25) = B1AFB1 | Pixel 814 (13,25) = FFFFFF | Pixel 815 (14,25) = FFFFFF | Pixel 816 (15,25) = C9C9C9 | Pixel 817 (16,25) = CFCFCF | Pixel 818 (17,25) = FFFFFF | Pixel 819 (18,25) = FFFFFF | Pixel 820 (19,25) = 494A50 | Pixel 821 (20,25) = FFFFFF | Pixel 822 (21,25) = FFFFFF | Pixel 823 (22,25) = 000000 | Pixel 824 (23,25) = 000000 | Pixel 825 (24,25) = 000000 | Pixel 826 (25,25) = 544A44 | Pixel 827 (26,25) = 5C514B | Pixel 828 (27,25) = 5E524D | Pixel 829 (28,25) = 665851 | Pixel 830 (29,25) = 645750 | Pixel 831 (30,25) = 000000 | Pixel 832 (31,25) = 000000
Pixel 833 (0,26) = 000000 | Pixel 834 (1,26) = 000000 | Pixel 835 (2,26) = 574B47 | Pixel 836 (3,26) = 62544E | Pixel 837 (4,26) = 5F524C | Pixel 838 (5,26) = 554A45 | Pixel 839 (6,26) = 645752 | Pixel 840 (7,26) = 000000 | Pixel 841 (8,26) = AC9A9F | Pixel 842 (9,26) = EBD2DA | Pixel 843 (10,26) = FEE3EB | Pixel 844 (11,26) = FFFAFF | Pixel 845 (12,26) = FFFFFF | Pixel 846 (13,26) = FFFFFF | Pixel 847 (14,26) = FFFFFF | Pixel 848 (15,26) = FFFFFF | Pixel 849 (16,26) = FFFFFF | Pixel 850 (17,26) = FFFFFF | Pixel 851 (18,26) = FFFFFF | Pixel 852 (19,26) = 545559 | Pixel 853 (20,26) = FFFFFF | Pixel 854 (21,26) = FDEFF7 | Pixel 855 (22,26) = FFFFFF | Pixel 856 (23,26) = 000000 | Pixel 857 (24,26) = 000000 | Pixel 858 (25,26) = 594D49 | Pixel 859 (26,26) = 5E524C | Pixel 860 (27,26) = 61534C | Pixel 861 (28,26) = 695B54 | Pixel 862 (29,26) = 5E514D | Pixel 863 (30,26) = 000000 | Pixel 864 (31,26) = 000000
Pixel 865 (0,27) = 000000 | Pixel 866 (1,27) = 534742 | Pixel 867 (2,27) = 000000 | Pixel 868 (3,27) = 60524D | Pixel 869 (4,27) = 5F504B | Pixel 870 (5,27) = 5A4E48 | Pixel 871 (6,27) = 5F534C | Pixel 872 (7,27) = 000000 | Pixel 873 (8,27) = A7959A | Pixel 874 (9,27) = D1BBC2 | Pixel 875 (10,27) = E6CDD5 | Pixel 876 (11,27) = F3D9E1 | Pixel 877 (12,27) = FFF7FF | Pixel 878 (13,27) = E6E6E6 | Pixel 879 (14,27) = E9E9E9 | Pixel 880 (15,27) = F1F1F1 | Pixel 881 (16,27) = FAFAFA | Pixel 882 (17,27) = FFFFFF | Pixel 883 (18,27) = FFFFFF | Pixel 884 (19,27) = 36373C | Pixel 885 (20,27) = FFFFFF | Pixel 886 (21,27) = FFFFFF | Pixel 887 (22,27) = FFFFFF | Pixel 888 (23,27) = FFFFFF | Pixel 889 (24,27) = 000000 | Pixel 890 (25,27) = 5B5049 | Pixel 891 (26,27) = 635650 | Pixel 892 (27,27) = 61534D | Pixel 893 (28,27) = 6A5A54 | Pixel 894 (29,27) = 000000 | Pixel 895 (30,27) = 63554F | Pixel 896 (31,27) = 000000
Pixel 897 (0,28) = 000000 | Pixel 898 (1,28) = 564B45 | Pixel 899 (2,28) = 000000 | Pixel 900 (3,28) = 60534C | Pixel 901 (4,28) = 5D4F4A | Pixel 902 (5,28) = 61544D | Pixel 903 (6,28) = 5D5048 | Pixel 904 (7,28) = 000000 | Pixel 905 (8,28) = BAA7AC | Pixel 906 (9,28) = C4AFB5 | Pixel 907 (10,28) = C6B1B7 | Pixel 908 (11,28) = CAB4BB | Pixel 909 (12,28) = D9C2C9 | Pixel 910 (13,28) = B1B0B3 | Pixel 911 (14,28) = 37383C | Pixel 912 (15,28) = 636367 | Pixel 913 (16,28) = 2D2D32 | Pixel 914 (17,28) = 7C7B80 | Pixel 915 (18,28) = C3C1C5 | Pixel 916 (19,28) = 3B343D | Pixel 917 (20,28) = FFEBF4 | Pixel 918 (21,28) = FFF7FF | Pixel 919 (22,28) = FFFFFF | Pixel 920 (23,28) = FFFFFF | Pixel 921 (24,28) = FFFFFF | Pixel 922 (25,28) = 5E524A | Pixel 923 (26,28) = 695B53 | Pixel 924 (27,28) = 60514C | Pixel 925 (28,28) = 685A52 | Pixel 926 (29,28) = 000000 | Pixel 927 (30,28) = 584D47 | Pixel 928 (31,28) = 000000
Pixel 929 (0,29) = 000000 | Pixel 930 (1,29) = 50453F | Pixel 931 (2,29) = 000000 | Pixel 932 (3,29) = 60534D | Pixel 933 (4,29) = 5E524B | Pixel 934 (5,29) = 62544A | Pixel 935 (6,29) = 5A4F47 | Pixel 936 (7,29) = AE9BA1 | Pixel 937 (8,29) = F5F2F3 | Pixel 938 (9,29) = C5B0B7 | Pixel 939 (10,29) = C7B2B8 | Pixel 940 (11,29) = CAB5BB | Pixel 941 (12,29) = CFB9C0 | Pixel 942 (13,29) = D4BEC4 | Pixel 943 (14,29) = 38383C | Pixel 944 (15,29) = 959499 | Pixel 945 (16,29) = 908F93 | Pixel 946 (17,29) = 212125 | Pixel 947 (18,29) = 202227 | Pixel 948 (19,29) = 3F373E | Pixel 949 (20,29) = DCC5CC | Pixel 950 (21,29) = FCE1E9 | Pixel 951 (22,29) = FFF8FF | Pixel 952 (23,29) = FFFFFF | Pixel 953 (24,29) = FFFFFF | Pixel 954 (25,29) = 5D5149 | Pixel 955 (26,29) = 6A5B51 | Pixel 956 (27,29) = 62554E | Pixel 957 (28,29) = 695B54 | Pixel 958 (29,29) = 000000 | Pixel 959 (30,29) = 544842 | Pixel 960 (31,29) = 000000
Pixel 961 (0,30) = 534944 | Pixel 962 (1,30) = 4F4440 | Pixel 963 (2,30) = 000000 | Pixel 964 (3,30) = 61544E | Pixel 965 (4,30) = 5F514C | Pixel 966 (5,30) = 5B4E46 | Pixel 967 (6,30) = 5A4E48 | Pixel 968 (7,30) = B4A0A6 | Pixel 969 (8,30) = BDA9AF | Pixel 970 (9,30) = F9F9F9 | Pixel 971 (10,30) = C8B2B9 | Pixel 972 (11,30) = CBB6BC | Pixel 973 (12,30) = CDB7BE | Pixel 974 (13,30) = D1BBC2 | Pixel 975 (14,30) = 111216 | Pixel 976 (15,30) = 111216 | Pixel 977 (16,30) = 292B2F | Pixel 978 (17,30) = 18191D | Pixel 979 (18,30) = 212328 | Pixel 980 (19,30) = 705866 | Pixel 981 (20,30) = D2BCC3 | Pixel 982 (21,30) = D8C1C8 | Pixel 983 (22,30) = F6DCE3 | Pixel 984 (23,30) = FFF1F9 | Pixel 985 (24,30) = FFFFFF | Pixel 986 (25,30) = 5C514A | Pixel 987 (26,30) = 63554C | Pixel 988 (27,30) = 63544F | Pixel 989 (28,30) = 6A5C55 | Pixel 990 (29,30) = 000000 | Pixel 991 (30,30) = 544843 | Pixel 992 (31,30) = 5A4E4A
Pixel 993 (0,31) = 514740 | Pixel 994 (1,31) = 4C413C | Pixel 995 (2,31) = 000000 | Pixel 996 (3,31) = 5E524B | Pixel 997 (4,31) = 5D514B | Pixel 998 (5,31) = 594D46 | Pixel 999 (6,31) = 584C46 | Pixel 1000 (7,31) = BAA7AD | Pixel 1001 (8,31) = C1ACB2 | Pixel 1002 (9,31) = BAA6AC | Pixel 1003 (10,31) = F7F8F8 | Pixel 1004 (11,31) = C9B4BA | Pixel 1005 (12,31) = CDB8BE | Pixel 1006 (13,31) = D0BAC0 | Pixel 1007 (14,31) = 25282D | Pixel 1008 (15,31) = 101115 | Pixel 1009 (16,31) = 131418 | Pixel 1010 (17,31) = 1F2126 | Pixel 1011 (18,31) = 292A2F | Pixel 1012 (19,31) = C7B2B8 | Pixel 1013 (20,31) = D1BBC1 | Pixel 1014 (21,31) = D7C0C7 | Pixel 1015 (22,31) = D8C1C8 | Pixel 1016 (23,31) = F5DBE3 | Pixel 1017 (24,31) = FCE1E9 | Pixel 1018 (25,31) = 5B4F49 | Pixel 1019 (26,31) = 60534B | Pixel 1020 (27,31) = 61544D | Pixel 1021 (28,31) = 695B54 | Pixel 1022 (29,31) = 000000 | Pixel 1023 (30,31) = 504540 | Pixel 1024 (31,31) = 564C44
        ]]
    }
}
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
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
