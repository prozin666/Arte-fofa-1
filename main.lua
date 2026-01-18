-- ======================
-- PIXEL PAINTER CENTRAL (DELTA)
-- HUD compacta, flutuante, móvel
-- ======================

local player = game.Players.LocalPlayer
local remote = game.ReplicatedStorage:FindFirstChild("UpdateBoard")
    or game.Workspace:FindFirstChild("UpdateBoard", true)

local GRID = 32
local TOTAL = GRID * GRID

-- UTIL: índice lógico -> board (espelho X)
local function logicalToBoardIndex(pixel)
    local zero = pixel - 1
    local y = math.floor(zero / GRID)
    local x = zero % GRID
    local flippedX = (GRID - 1) - x
    return y * GRID + flippedX + 1
end

-- ======================
-- ⬇⬇⬇ SLOTS (BOT EDITA AQUI) ⬇⬇⬇
-- ======================
local ARTS = {
    
}
{
            name = "medium",
            map = [[
Pixel 1 (0,0) = FFE6E7 | Pixel 2 (1,0) = FFEFF0 | Pixel 3 (2,0) = FFDFE0 | Pixel 4 (3,0) = D2757A | Pixel 5 (4,0) = A94B50 | Pixel 6 (5,0) = F09196 | Pixel 7 (6,0) = FFC4C7 | Pixel 8 (7,0) = FFD2D4 | Pixel 9 (8,0) = FFCED1 | Pixel 10 (9,0) = FFF4F5 | Pixel 11 (10,0) = FFF6F7 | Pixel 12 (11,0) = FFF6F6 | Pixel 13 (12,0) = FFF7F7 | Pixel 14 (13,0) = FFF7F8 | Pixel 15 (14,0) = FFFBFB | Pixel 16 (15,0) = FFFDFD | Pixel 17 (16,0) = FFFDFD | Pixel 18 (17,0) = FFF7F8 | Pixel 19 (18,0) = FFF2F2 | Pixel 20 (19,0) = FFEFF0 | Pixel 21 (20,0) = FFF7F7 | Pixel 22 (21,0) = FFF7F8 | Pixel 23 (22,0) = FFFBFB | Pixel 24 (23,0) = FFFCFC | Pixel 25 (24,0) = FFF9F9 | Pixel 26 (25,0) = FFF9F9 | Pixel 27 (26,0) = FFF9F9 | Pixel 28 (27,0) = FFF9F9 | Pixel 29 (28,0) = FFF9F9 | Pixel 30 (29,0) = FFF7F8 | Pixel 31 (30,0) = FFF3F4 | Pixel 32 (31,0) = FFF0F1
Pixel 33 (0,1) = 882A2F | Pixel 34 (1,1) = 97393E | Pixel 35 (2,1) = 390104 | Pixel 36 (3,1) = 9F4146 | Pixel 37 (4,1) = FFEFF0 | Pixel 38 (5,1) = FFDCDE | Pixel 39 (6,1) = FFD2D5 | Pixel 40 (7,1) = FFEFEF | Pixel 41 (8,1) = FFF7F8 | Pixel 42 (9,1) = FFF9FA | Pixel 43 (10,1) = FFFAFB | Pixel 44 (11,1) = FFFAFB | Pixel 45 (12,1) = FFFAFB | Pixel 46 (13,1) = FFFAFB | Pixel 47 (14,1) = FFFBFB | Pixel 48 (15,1) = FFF9FB | Pixel 49 (16,1) = FFFBFC | Pixel 50 (17,1) = FFF6F6 | Pixel 51 (18,1) = FFF7F8 | Pixel 52 (19,1) = FFFCFC | Pixel 53 (20,1) = FFFDFC | Pixel 54 (21,1) = FFFAFB | Pixel 55 (22,1) = FFFCFC | Pixel 56 (23,1) = FFFBFC | Pixel 57 (24,1) = FFFAFB | Pixel 58 (25,1) = FFFBFC | Pixel 59 (26,1) = FFFAFB | Pixel 60 (27,1) = FFFAFB | Pixel 61 (28,1) = FFFCFC | Pixel 62 (29,1) = FFFAFB | Pixel 63 (30,1) = FFF9F9 | Pixel 64 (31,1) = FFF9F9
Pixel 65 (0,2) = FFF0F1 | Pixel 66 (1,2) = D17378 | Pixel 67 (2,2) = FFB3B7 | Pixel 68 (3,2) = FFF0F1 | Pixel 69 (4,2) = FFF2F2 | Pixel 70 (5,2) = FFECED | Pixel 71 (6,2) = FFEDEE | Pixel 72 (7,2) = FFF9F9 | Pixel 73 (8,2) = FFF9F9 | Pixel 74 (9,2) = FFF9F9 | Pixel 75 (10,2) = FFF9F9 | Pixel 76 (11,2) = FFF9F9 | Pixel 77 (12,2) = FFFAFB | Pixel 78 (13,2) = FFFAFB | Pixel 79 (14,2) = FFFAFB | Pixel 80 (15,2) = FFFAFB | Pixel 81 (16,2) = FFF5F5 | Pixel 82 (17,2) = FFDDDE | Pixel 83 (18,2) = FFC0C3 | Pixel 84 (19,2) = FFFBFB | Pixel 85 (20,2) = FFFBFB | Pixel 86 (21,2) = FFFBFC | Pixel 87 (22,2) = FFFAFB | Pixel 88 (23,2) = FFFBFC | Pixel 89 (24,2) = FFFBFB | Pixel 90 (25,2) = FFFBFC | Pixel 91 (26,2) = FFFAFB | Pixel 92 (27,2) = FFFAFB | Pixel 93 (28,2) = FFFBFC | Pixel 94 (29,2) = FFFBFB | Pixel 95 (30,2) = FFFCFC | Pixel 96 (31,2) = FFFCFC
Pixel 97 (0,3) = FFF1F2 | Pixel 98 (1,3) = FFEDEE | Pixel 99 (2,3) = DC7D82 | Pixel 100 (3,3) = FFF2F2 | Pixel 101 (4,3) = FFF3F4 | Pixel 102 (5,3) = FFF8F8 | Pixel 103 (6,3) = FFF9F9 | Pixel 104 (7,3) = FFF9F9 | Pixel 105 (8,3) = FFF9F9 | Pixel 106 (9,3) = FFF6F6 | Pixel 107 (10,3) = FFD6D9 | Pixel 108 (11,3) = FFB9BD | Pixel 109 (12,3) = FFCFD1 | Pixel 110 (13,3) = FFB8BC | Pixel 111 (14,3) = FFBBBF | Pixel 112 (15,3) = FFB0B5 | Pixel 113 (16,3) = FFAFB3 | Pixel 114 (17,3) = FFB1B6 | Pixel 115 (18,3) = FFCBCE | Pixel 116 (19,3) = FFD0D2 | Pixel 117 (20,3) = FFE4E5 | Pixel 118 (21,3) = FFFAFB | Pixel 119 (22,3) = FFFAFB | Pixel 120 (23,3) = FFFAFB | Pixel 121 (24,3) = FFFAFB | Pixel 122 (25,3) = FFFAFB | Pixel 123 (26,3) = FFFAFB | Pixel 124 (27,3) = FFFAFB | Pixel 125 (28,3) = FFFCFC | Pixel 126 (29,3) = FFFBFC | Pixel 127 (30,3) = FFFCFC | Pixel 128 (31,3) = FFFDFD
Pixel 129 (0,4) = FFF7F8 | Pixel 130 (1,4) = FFF7F8 | Pixel 131 (2,4) = FFEFF0 | Pixel 132 (3,4) = 913338 | Pixel 133 (4,4) = FFEDEE | Pixel 134 (5,4) = FFEEEF | Pixel 135 (6,4) = FFD8DA | Pixel 136 (7,4) = FFB3B7 | Pixel 137 (8,4) = FFAEB2 | Pixel 138 (9,4) = FFC3C7 | Pixel 139 (10,4) = F9A9AD | Pixel 140 (11,4) = 64060B | Pixel 141 (12,4) = EA8B90 | Pixel 142 (13,4) = FFDEE0 | Pixel 143 (14,4) = FFD5D7 | Pixel 144 (15,4) = FFECED | Pixel 145 (16,4) = FFFDFD | Pixel 146 (17,4) = FFECED | Pixel 147 (18,4) = FFFCFC | Pixel 148 (19,4) = FFF7F7 | Pixel 149 (20,4) = FCA9AD | Pixel 150 (21,4) = C96B70 | Pixel 151 (22,4) = 993B40 | Pixel 152 (23,4) = DF8085 | Pixel 153 (24,4) = FFF3F5 | Pixel 154 (25,4) = FFFAFB | Pixel 155 (26,4) = FFF9F9 | Pixel 156 (27,4) = FFF9F9 | Pixel 157 (28,4) = FFF9F9 | Pixel 158 (29,4) = FFF9F9 | Pixel 159 (30,4) = FFFAFB | Pixel 160 (31,4) = FFFCFC
Pixel 161 (0,5) = FFFBFB | Pixel 162 (1,5) = FFF7F8 | Pixel 163 (2,5) = FFF9F9 | Pixel 164 (3,5) = FFC6C9 | Pixel 165 (4,5) = BD5F64 | Pixel 166 (5,5) = FFBEC1 | Pixel 167 (6,5) = FFBBBF | Pixel 168 (7,5) = FBBDC0 | Pixel 169 (8,5) = C4666B | Pixel 170 (9,5) = D17378 | Pixel 171 (10,5) = FFC4C7 | Pixel 172 (11,5) = FFFDFD | Pixel 173 (12,5) = FFE7E8 | Pixel 174 (13,5) = FFD0D3 | Pixel 175 (14,5) = FFD6D8 | Pixel 176 (15,5) = DC7D82 | Pixel 177 (16,5) = FFCBCE | Pixel 178 (17,5) = DC7D82 | Pixel 179 (18,5) = FFDADC | Pixel 180 (19,5) = FFFBFB | Pixel 181 (20,5) = FFFDFD | Pixel 182 (21,5) = FFFEFE | Pixel 183 (22,5) = FFFCFC | Pixel 184 (23,5) = FFEAEB | Pixel 185 (24,5) = B85A5F | Pixel 186 (25,5) = FA9CA1 | Pixel 187 (26,5) = FFF2F3 | Pixel 188 (27,5) = FFF7F7 | Pixel 189 (28,5) = FFF9FA | Pixel 190 (29,5) = FFF6F7 | Pixel 191 (30,5) = FFF9F9 | Pixel 192 (31,5) = FFF9F9
Pixel 193 (0,6) = FFFDFD | Pixel 194 (1,6) = FFF9FA | Pixel 195 (2,6) = FFF9F9 | Pixel 196 (3,6) = FFE6E7 | Pixel 197 (4,6) = FFB8BC | Pixel 198 (5,6) = FFFCFC | Pixel 199 (6,6) = FFFBFC | Pixel 200 (7,6) = FFFAFB | Pixel 201 (8,6) = FB9FA4 | Pixel 202 (9,6) = FFD7DA | Pixel 203 (10,6) = FFFDFD | Pixel 204 (11,6) = FFE8E9 | Pixel 205 (12,6) = FFCED0 | Pixel 206 (13,6) = FFAFB3 | Pixel 207 (14,6) = FFC8CC | Pixel 208 (15,6) = FC9DA2 | Pixel 209 (16,6) = F09297 | Pixel 210 (17,6) = FFBBBE | Pixel 211 (18,6) = FFC0C4 | Pixel 212 (19,6) = FFE8E9 | Pixel 213 (20,6) = FFFEFE | Pixel 214 (21,6) = FFFFFF | Pixel 215 (22,6) = FFFFFF | Pixel 216 (23,6) = FFFEFE | Pixel 217 (24,6) = FFCED0 | Pixel 218 (25,6) = FFFEFE | Pixel 219 (26,6) = E08287 | Pixel 220 (27,6) = B7595E | Pixel 221 (28,6) = FFD4D7 | Pixel 222 (29,6) = FFCFD2 | Pixel 223 (30,6) = FFCCCF | Pixel 224 (31,6) = FFD0D2
Pixel 225 (0,7) = FFFFFF | Pixel 226 (1,7) = FFFCFC | Pixel 227 (2,7) = FFF9F9 | Pixel 228 (3,7) = FFF7F8 | Pixel 229 (4,7) = FFCBCE | Pixel 230 (5,7) = FFFCFC | Pixel 231 (6,7) = FFFBFB | Pixel 232 (7,7) = FEEDEE | Pixel 233 (8,7) = FFC9CC | Pixel 234 (9,7) = FFFAFB | Pixel 235 (10,7) = FFF1F1 | Pixel 236 (11,7) = FFD6D8 | Pixel 237 (12,7) = FFA9AE | Pixel 238 (13,7) = FFB9BC | Pixel 239 (14,7) = CB6D72 | Pixel 240 (15,7) = FFC7BF | Pixel 241 (16,7) = FFA89E | Pixel 242 (17,7) = FFFAFA | Pixel 243 (18,7) = FFACB0 | Pixel 244 (19,7) = FFDFE0 | Pixel 245 (20,7) = FFFDFD | Pixel 246 (21,7) = FFFEFE | Pixel 247 (22,7) = FFFFFF | Pixel 248 (23,7) = FFFEFE | Pixel 249 (24,7) = FFFDFD | Pixel 250 (25,7) = FFFFFF | Pixel 251 (26,7) = FFD8DA | Pixel 252 (27,7) = FFE0E2 | Pixel 253 (28,7) = FFB3B7 | Pixel 254 (29,7) = FCA2A7 | Pixel 255 (30,7) = FFC3C7 | Pixel 256 (31,7) = D4767B
Pixel 257 (0,8) = FFFAFA | Pixel 258 (1,8) = FFFFFF | Pixel 259 (2,8) = FFF8F9 | Pixel 260 (3,8) = FFECED | Pixel 261 (4,8) = FFFCFC | Pixel 262 (5,8) = FFFDFD | Pixel 263 (6,8) = FFFDFD | Pixel 264 (7,8) = FFB4B8 | Pixel 265 (8,8) = FFECED | Pixel 266 (9,8) = FFF7F8 | Pixel 267 (10,8) = FFDCDE | Pixel 268 (11,8) = FFB6BA | Pixel 269 (12,8) = FA9CA1 | Pixel 270 (13,8) = DD7F84 | Pixel 271 (14,8) = E47A6C | Pixel 272 (15,8) = B75144 | Pixel 273 (16,8) = FEA095 | Pixel 274 (17,8) = F6A2A5 | Pixel 275 (18,8) = F29499 | Pixel 276 (19,8) = FFD0D3 | Pixel 277 (20,8) = FFFBFC | Pixel 278 (21,8) = FFFEFE | Pixel 279 (22,8) = FFFFFF | Pixel 280 (23,8) = FFFEFE | Pixel 281 (24,8) = FFFDFD | Pixel 282 (25,8) = FFFFFF | Pixel 283 (26,8) = FFFFFF | Pixel 284 (27,8) = FFFFFF | Pixel 285 (28,8) = FFF6F7 | Pixel 286 (29,8) = FFFDFD | Pixel 287 (30,8) = FFFEFE | Pixel 288 (31,8) = A5484C
Pixel 289 (0,9) = FFFFFF | Pixel 290 (1,9) = FED6D8 | Pixel 291 (2,9) = FFF5F5 | Pixel 292 (3,9) = FFECED | Pixel 293 (4,9) = FFFDFD | Pixel 294 (5,9) = FFFEFE | Pixel 295 (6,9) = FFE7E8 | Pixel 296 (7,9) = FFCBCE | Pixel 297 (8,9) = FFF9F9 | Pixel 298 (9,9) = FFE3E5 | Pixel 299 (10,9) = FFCDD0 | Pixel 300 (11,9) = FB9DA2 | Pixel 301 (12,9) = FFF8F8 | Pixel 302 (13,9) = CA6254 | Pixel 303 (14,9) = ED8678 | Pixel 304 (15,9) = FFDDD8 | Pixel 305 (16,9) = AC4436 | Pixel 306 (17,9) = 8F423C | Pixel 307 (18,9) = FFB2B6 | Pixel 308 (19,9) = FFCACD | Pixel 309 (20,9) = FFE7E8 | Pixel 310 (21,9) = FFFDFD | Pixel 311 (22,9) = FFFFFF | Pixel 312 (23,9) = FFFFFF | Pixel 313 (24,9) = FFF6F6 | Pixel 314 (25,9) = FFFEFE | Pixel 315 (26,9) = FFFFFF | Pixel 316 (27,9) = FFFFFF | Pixel 317 (28,9) = FFFFFF | Pixel 318 (29,9) = FFFEFE | Pixel 319 (30,9) = 812328 | Pixel 320 (31,9) = FFE8E9
Pixel 321 (0,10) = FFFFFF | Pixel 322 (1,10) = FFFFFF | Pixel 323 (2,10) = BF6166 | Pixel 324 (3,10) = FFFAFB | Pixel 325 (4,10) = FFFBFB | Pixel 326 (5,10) = FFFDFD | Pixel 327 (6,10) = FFAEB2 | Pixel 328 (7,10) = FFD1D4 | Pixel 329 (8,10) = FFE9EA | Pixel 330 (9,10) = FFE1E3 | Pixel 331 (10,10) = FFB1B6 | Pixel 332 (11,10) = FFA5AA | Pixel 333 (12,10) = D6787D | Pixel 334 (13,10) = E47B6D | Pixel 335 (14,10) = FDB5AB | Pixel 336 (15,10) = FFDAD5 | Pixel 337 (16,10) = FFECEA | Pixel 338 (17,10) = AC524D | Pixel 339 (18,10) = FFCED1 | Pixel 340 (19,10) = FFBCC0 | Pixel 341 (20,10) = FFE3E4 | Pixel 342 (21,10) = FFFDFD | Pixel 343 (22,10) = FFFFFF | Pixel 344 (23,10) = FFFFFF | Pixel 345 (24,10) = FFF4F5 | Pixel 346 (25,10) = FFF8F9 | Pixel 347 (26,10) = FFFFFF | Pixel 348 (27,10) = FFFFFF | Pixel 349 (28,10) = FFFFFF | Pixel 350 (29,10) = C6676C | Pixel 351 (30,10) = FFF2F3 | Pixel 352 (31,10) = FFFBFB
Pixel 353 (0,11) = FFFFFF | Pixel 354 (1,11) = FFFFFF | Pixel 355 (2,11) = FFFDFD | Pixel 356 (3,11) = EB979B | Pixel 357 (4,11) = FFFBFC | Pixel 358 (5,11) = FFDEE0 | Pixel 359 (6,11) = FFAFB3 | Pixel 360 (7,11) = FFD8DB | Pixel 361 (8,11) = FFE6E7 | Pixel 362 (9,11) = FFD6D8 | Pixel 363 (10,11) = FC9EA3 | Pixel 364 (11,11) = FFF7F7 | Pixel 365 (12,11) = E88072 | Pixel 366 (13,11) = F78D7F | Pixel 367 (14,11) = FFCBC4 | Pixel 368 (15,11) = FFDAD6 | Pixel 369 (16,11) = E77E71 | Pixel 370 (17,11) = C0635A | Pixel 371 (18,11) = FFCACD | Pixel 372 (19,11) = FFBEC1 | Pixel 373 (20,11) = FFE3E4 | Pixel 374 (21,11) = FFFDFD | Pixel 375 (22,11) = FFFFFF | Pixel 376 (23,11) = FFFDFD | Pixel 377 (24,11) = FFF0F1 | Pixel 378 (25,11) = FFF4F5 | Pixel 379 (26,11) = FFFFFF | Pixel 380 (27,11) = CF6F75 | Pixel 381 (28,11) = 0E0000 | Pixel 382 (29,11) = FFE9EB | Pixel 383 (30,11) = FFFCFC | Pixel 384 (31,11) = FFF4F5
Pixel 385 (0,12) = FFFFFF | Pixel 386 (1,12) = FFFFFF | Pixel 387 (2,12) = FFFFFF | Pixel 388 (3,12) = FFFEFE | Pixel 389 (4,12) = B05257 | Pixel 390 (5,12) = FFC7CA | Pixel 391 (6,12) = FFB0B4 | Pixel 392 (7,12) = FFDADC | Pixel 393 (8,12) = FFE6E7 | Pixel 394 (9,12) = FFCCCF | Pixel 395 (10,12) = FEA0A5 | Pixel 396 (11,12) = FFC1C4 | Pixel 397 (12,12) = FFCFC9 | Pixel 398 (13,12) = FFD2CC | Pixel 399 (14,12) = FFA79C | Pixel 400 (15,12) = FFA194 | Pixel 401 (16,12) = FFE4E0 | Pixel 402 (17,12) = CF7572 | Pixel 403 (18,12) = FFB9BD | Pixel 404 (19,12) = FFB7BB | Pixel 405 (20,12) = FFDCDE | Pixel 406 (21,12) = FFF7F7 | Pixel 407 (22,12) = FFFFFF | Pixel 408 (23,12) = FFFCFC | Pixel 409 (24,12) = FFE9EA | Pixel 410 (25,12) = FFF5F6 | Pixel 411 (26,12) = FFFFFF | Pixel 412 (27,12) = FFFFFF | Pixel 413 (28,12) = FEDCDE | Pixel 414 (29,12) = FFFEFE | Pixel 415 (30,12) = FFF4F5 | Pixel 416 (31,12) = FFE3E5
Pixel 417 (0,13) = FFFFFF | Pixel 418 (1,13) = FFFFFF | Pixel 419 (2,13) = FFFFFF | Pixel 420 (3,13) = FFFEFE | Pixel 421 (4,13) = FFD2D4 | Pixel 422 (5,13) = FFCBCE | Pixel 423 (6,13) = FFB2B6 | Pixel 424 (7,13) = FFCFD1 | Pixel 425 (8,13) = FFDFE1 | Pixel 426 (9,13) = FFBEC2 | Pixel 427 (10,13) = FFADB2 | Pixel 428 (11,13) = E3858A | Pixel 429 (12,13) = FFDDD8 | Pixel 430 (13,13) = FFC1B9 | Pixel 431 (14,13) = BF4E3F | Pixel 432 (15,13) = DE6D5E | Pixel 433 (16,13) = FFDAD4 | Pixel 434 (17,13) = FFC5C9 | Pixel 435 (18,13) = FFBABD | Pixel 436 (19,13) = FFBABE | Pixel 437 (20,13) = FFE3E4 | Pixel 438 (21,13) = FFF4F5 | Pixel 439 (22,13) = FFFFFF | Pixel 440 (23,13) = FFFCFC | Pixel 441 (24,13) = FFE5E6 | Pixel 442 (25,13) = FFF8F8 | Pixel 443 (26,13) = FFFFFF | Pixel 444 (27,13) = FEF6F7 | Pixel 445 (28,13) = FFFDFD | Pixel 446 (29,13) = FFF7F8 | Pixel 447 (30,13) = FFCCCF | Pixel 448 (31,13) = FFF9F9
Pixel 449 (0,14) = FFFFFF | Pixel 450 (1,14) = FFFFFF | Pixel 451 (2,14) = FFFFFF | Pixel 452 (3,14) = FFFFFF | Pixel 453 (4,14) = FFD5D8 | Pixel 454 (5,14) = FFCDD0 | Pixel 455 (6,14) = FFAFB3 | Pixel 456 (7,14) = FFCACD | Pixel 457 (8,14) = FFD7DA | Pixel 458 (9,14) = FFBEC1 | Pixel 459 (10,14) = FA9FA4 | Pixel 460 (11,14) = D7797E | Pixel 461 (12,14) = FFF7F6 | Pixel 462 (13,14) = FF9B8E | Pixel 463 (14,14) = 8D1D0E | Pixel 464 (15,14) = DB6A5B | Pixel 465 (16,14) = FFEDEB | Pixel 466 (17,14) = FFD7D9 | Pixel 467 (18,14) = FA9DA2 | Pixel 468 (19,14) = FFC6C9 | Pixel 469 (20,14) = FFE2E3 | Pixel 470 (21,14) = FFF4F5 | Pixel 471 (22,14) = FFFEFE | Pixel 472 (23,14) = FFE5E6 | Pixel 473 (24,14) = FFBDC0 | Pixel 474 (25,14) = FFECED | Pixel 475 (26,14) = FFF7F8 | Pixel 476 (27,14) = FFF0F1 | Pixel 477 (28,14) = FFD5D7 | Pixel 478 (29,14) = FFFAFA | Pixel 479 (30,14) = FFFAFB | Pixel 480 (31,14) = FFFFFF
Pixel 481 (0,15) = FFFFFF | Pixel 482 (1,15) = FFFFFF | Pixel 483 (2,15) = FFFFFF | Pixel 484 (3,15) = FFFFFF | Pixel 485 (4,15) = FFF4F5 | Pixel 486 (5,15) = FFCACD | Pixel 487 (6,15) = FFACB1 | Pixel 488 (7,15) = FFC6C9 | Pixel 489 (8,15) = FFD2D5 | Pixel 490 (9,15) = FFBBBF | Pixel 491 (10,15) = FA9DA2 | Pixel 492 (11,15) = D17277 | Pixel 493 (12,15) = FFFFFF | Pixel 494 (13,15) = FF9C90 | Pixel 495 (14,15) = 831608 | Pixel 496 (15,15) = CC5A4C | Pixel 497 (16,15) = FFDFDB | Pixel 498 (17,15) = FFDFE1 | Pixel 499 (18,15) = FFA3A8 | Pixel 500 (19,15) = FFCACD | Pixel 501 (20,15) = FFDCDE | Pixel 502 (21,15) = FFF3F3 | Pixel 503 (22,15) = FFFCFC | Pixel 504 (23,15) = FFDFE0 | Pixel 505 (24,15) = AA4D52 | Pixel 506 (25,15) = FFE5E7 | Pixel 507 (26,15) = FFD5D7 | Pixel 508 (27,15) = FFCDD0 | Pixel 509 (28,15) = FFFBFC | Pixel 510 (29,15) = FFFBFB | Pixel 511 (30,15) = FFFFFF | Pixel 512 (31,15) = FFFFFF
Pixel 513 (0,16) = FFFFFF | Pixel 514 (1,16) = FFFFFF | Pixel 515 (2,16) = FFFFFF | Pixel 516 (3,16) = F29398 | Pixel 517 (4,16) = FFDEE0 | Pixel 518 (5,16) = FFBCC0 | Pixel 519 (6,16) = FFA7AB | Pixel 520 (7,16) = FFC0C3 | Pixel 521 (8,16) = FFD6D7 | Pixel 522 (9,16) = FFBCC0 | Pixel 523 (10,16) = EF9196 | Pixel 524 (11,16) = E8888B | Pixel 525 (12,16) = FFCBC4 | Pixel 526 (13,16) = FFA194 | Pixel 527 (14,16) = AE3C2E | Pixel 528 (15,16) = DF7567 | Pixel 529 (16,16) = AB4438 | Pixel 530 (17,16) = FFB1B5 | Pixel 531 (18,16) = FFB2B6 | Pixel 532 (19,16) = FFCCCF | Pixel 533 (20,16) = FFD0D3 | Pixel 534 (21,16) = FFFCFC | Pixel 535 (22,16) = FFEBEC | Pixel 536 (23,16) = FFCDD0 | Pixel 537 (24,16) = C16469 | Pixel 538 (25,16) = FFD3D5 | Pixel 539 (26,16) = FFCCCF | Pixel 540 (27,16) = F9979D | Pixel 541 (28,16) = FFF6F6 | Pixel 542 (29,16) = FFFDFD | Pixel 543 (30,16) = FFFFFF | Pixel 544 (31,16) = FFFFFF
Pixel 545 (0,17) = FFFFFF | Pixel 546 (1,17) = FFFFFF | Pixel 547 (2,17) = FFFFFF | Pixel 548 (3,17) = FFFFFF | Pixel 549 (4,17) = FFFFFF | Pixel 550 (5,17) = D5787D | Pixel 551 (6,17) = FFBDC1 | Pixel 552 (7,17) = FFB6BA | Pixel 553 (8,17) = FFC7CA | Pixel 554 (9,17) = FFC8CB | Pixel 555 (10,17) = FFA6AB | Pixel 556 (11,17) = DF8186 | Pixel 557 (12,17) = FFD5CF | Pixel 558 (13,17) = FFC9C1 | Pixel 559 (14,17) = B24A3C | Pixel 560 (15,17) = FFB4AA | Pixel 561 (16,17) = FFDADC | Pixel 562 (17,17) = DA7C81 | Pixel 563 (18,17) = FFC1C4 | Pixel 564 (19,17) = FFCDD0 | Pixel 565 (20,17) = FFD3D5 | Pixel 566 (21,17) = FFE6E7 | Pixel 567 (22,17) = FFE2E3 | Pixel 568 (23,17) = F9AAAE | Pixel 569 (24,17) = FFE4E5 | Pixel 570 (25,17) = D68488 | Pixel 571 (26,17) = FFFEFE | Pixel 572 (27,17) = FFFEFE | Pixel 573 (28,17) = FFFEFE | Pixel 574 (29,17) = FFFFFF | Pixel 575 (30,17) = FFFFFF | Pixel 576 (31,17) = FFFFFF
Pixel 577 (0,18) = FFFFFF | Pixel 578 (1,18) = FFFFFF | Pixel 579 (2,18) = FFFFFF | Pixel 580 (3,18) = FFFFFF | Pixel 581 (4,18) = FFFFFF | Pixel 582 (5,18) = FFFEFE | Pixel 583 (6,18) = FBA5A9 | Pixel 584 (7,18) = FFA7AC | Pixel 585 (8,18) = FFC0C4 | Pixel 586 (9,18) = FFC8CB | Pixel 587 (10,18) = FFB2B6 | Pixel 588 (11,18) = FFAEB2 | Pixel 589 (12,18) = FFBCB3 | Pixel 590 (13,18) = FFCDC6 | Pixel 591 (14,18) = BF5749 | Pixel 592 (15,18) = AF5950 | Pixel 593 (16,18) = FFA4A9 | Pixel 594 (17,18) = FC9FA4 | Pixel 595 (18,18) = FFC2C5 | Pixel 596 (19,18) = FFC6C9 | Pixel 597 (20,18) = FFE4E6 | Pixel 598 (21,18) = FFE7E8 | Pixel 599 (22,18) = FFD5D7 | Pixel 600 (23,18) = FFD6D9 | Pixel 601 (24,18) = FFF7F7 | Pixel 602 (25,18) = FFFEFE | Pixel 603 (26,18) = FFFFFF | Pixel 604 (27,18) = FFFDFD | Pixel 605 (28,18) = FFFEFE | Pixel 606 (29,18) = FFFFFF | Pixel 607 (30,18) = FFFFFF | Pixel 608 (31,18) = FFFFFF
Pixel 609 (0,19) = FFFFFF | Pixel 610 (1,19) = FFFFFF | Pixel 611 (2,19) = FFFFFF | Pixel 612 (3,19) = FFFFFF | Pixel 613 (4,19) = FFFFFF | Pixel 614 (5,19) = FFFFFF | Pixel 615 (6,19) = FFFDFD | Pixel 616 (7,19) = FFD3D5 | Pixel 617 (8,19) = FFB4B8 | Pixel 618 (9,19) = FFC5C8 | Pixel 619 (10,19) = FFB8BC | Pixel 620 (11,19) = FFB1B5 | Pixel 621 (12,19) = BD6E66 | Pixel 622 (13,19) = FFD6D0 | Pixel 623 (14,19) = FFDEDA | Pixel 624 (15,19) = FFD8DB | Pixel 625 (16,19) = D5777C | Pixel 626 (17,19) = FFB6BA | Pixel 627 (18,19) = FFC6C9 | Pixel 628 (19,19) = FFCCCF | Pixel 629 (20,19) = FFD5D7 | Pixel 630 (21,19) = FFD8DB | Pixel 631 (22,19) = FFC8CB | Pixel 632 (23,19) = FFF3F4 | Pixel 633 (24,19) = FFFDFD | Pixel 634 (25,19) = FFFFFF | Pixel 635 (26,19) = FFFFFF | Pixel 636 (27,19) = FFFFFF | Pixel 637 (28,19) = FFFFFF | Pixel 638 (29,19) = FFFFFF | Pixel 639 (30,19) = FFFFFF | Pixel 640 (31,19) = FFFFFF
Pixel 641 (0,20) = FFFFFF | Pixel 642 (1,20) = FFFFFF | Pixel 643 (2,20) = FFFFFF | Pixel 644 (3,20) = FFFFFF | Pixel 645 (4,20) = FFFFFF | Pixel 646 (5,20) = FFFFFF | Pixel 647 (6,20) = FFFDFD | Pixel 648 (7,20) = FFFBFB | Pixel 649 (8,20) = C6686D | Pixel 650 (9,20) = FFC4C7 | Pixel 651 (10,20) = FFC3C6 | Pixel 652 (11,20) = FFA9AE | Pixel 653 (12,20) = FFB9BE | Pixel 654 (13,20) = FFCFC8 | Pixel 655 (14,20) = CD7173 | Pixel 656 (15,20) = FFA8AD | Pixel 657 (16,20) = F19398 | Pixel 658 (17,20) = FFBFC2 | Pixel 659 (18,20) = FFC8CB | Pixel 660 (19,20) = FFCDD0 | Pixel 661 (20,20) = FFCED0 | Pixel 662 (21,20) = FFBFC4 | Pixel 663 (22,20) = FFEEEF | Pixel 664 (23,20) = FFE7E8 | Pixel 665 (24,20) = FFF9FA | Pixel 666 (25,20) = FFE1E2 | Pixel 667 (26,20) = FFFFFF | Pixel 668 (27,20) = FFFFFF | Pixel 669 (28,20) = FFFFFF | Pixel 670 (29,20) = FFFFFF | Pixel 671 (30,20) = FFFFFF | Pixel 672 (31,20) = FFFFFF
Pixel 673 (0,21) = FFFFFF | Pixel 674 (1,21) = FFFFFF | Pixel 675 (2,21) = FFFFFF | Pixel 676 (3,21) = FFFFFF | Pixel 677 (4,21) = FFFFFF | Pixel 678 (5,21) = FFFFFF | Pixel 679 (6,21) = FFFFFF | Pixel 680 (7,21) = FFFCFC | Pixel 681 (8,21) = FFFBFC | Pixel 682 (9,21) = FFAFB3 | Pixel 683 (10,21) = FFC5C8 | Pixel 684 (11,21) = FFB8BC | Pixel 685 (12,21) = FFBBBE | Pixel 686 (13,21) = C8675E | Pixel 687 (14,21) = FFDBDC | Pixel 688 (15,21) = D97B80 | Pixel 689 (16,21) = FFA6AB | Pixel 690 (17,21) = FFBFC3 | Pixel 691 (18,21) = FFC5C8 | Pixel 692 (19,21) = FFCBCE | Pixel 693 (20,21) = FFCBCE | Pixel 694 (21,21) = FFF4F5 | Pixel 695 (22,21) = F09DA2 | Pixel 696 (23,21) = FFFEFE | Pixel 697 (24,21) = FFFFFF | Pixel 698 (25,21) = FFFFFF | Pixel 699 (26,21) = FFFFFF | Pixel 700 (27,21) = FFFFFF | Pixel 701 (28,21) = FFFFFF | Pixel 702 (29,21) = FFFFFF | Pixel 703 (30,21) = FFFDFD | Pixel 704 (31,21) = FFFFFF
Pixel 705 (0,22) = FFFFFF | Pixel 706 (1,22) = FFFFFF | Pixel 707 (2,22) = FFFFFF | Pixel 708 (3,22) = FFFFFF | Pixel 709 (4,22) = FFFFFF | Pixel 710 (5,22) = FFFFFF | Pixel 711 (6,22) = FFFFFF | Pixel 712 (7,22) = FFFEFE | Pixel 713 (8,22) = FFFDFD | Pixel 714 (9,22) = FFCCCF | Pixel 715 (10,22) = FFBFC2 | Pixel 716 (11,22) = FFBCBF | Pixel 717 (12,22) = CF7176 | Pixel 718 (13,22) = FFCCCF | Pixel 719 (14,22) = FFCED1 | Pixel 720 (15,22) = E28489 | Pixel 721 (16,22) = FFABAF | Pixel 722 (17,22) = FFC3C6 | Pixel 723 (18,22) = FFC8CB | Pixel 724 (19,22) = FFC3C6 | Pixel 725 (20,22) = FFECED | Pixel 726 (21,22) = DF7C82 | Pixel 727 (22,22) = FFFAF9 | Pixel 728 (23,22) = FFFFFF | Pixel 729 (24,22) = FFFFFF | Pixel 730 (25,22) = FFFFFF | Pixel 731 (26,22) = FFFFFF | Pixel 732 (27,22) = FFFFFF | Pixel 733 (28,22) = FFFFFF | Pixel 734 (29,22) = FFFFFF | Pixel 735 (30,22) = FFFFFF | Pixel 736 (31,22) = FFFFFF
Pixel 737 (0,23) = FFFFFF | Pixel 738 (1,23) = FFFFFF | Pixel 739 (2,23) = FFFFFF | Pixel 740 (3,23) = FFFFFF | Pixel 741 (4,23) = FFFFFF | Pixel 742 (5,23) = FFFFFF | Pixel 743 (6,23) = FFFFFF | Pixel 744 (7,23) = FFFFFF | Pixel 745 (8,23) = FFFEFE | Pixel 746 (9,23) = FFFDFD | Pixel 747 (10,23) = 9F4247 | Pixel 748 (11,23) = FFC8CB | Pixel 749 (12,23) = FFD0D3 | Pixel 750 (13,23) = FFEEF0 | Pixel 751 (14,23) = FFE2E3 | Pixel 752 (15,23) = FA9CA1 | Pixel 753 (16,23) = FFB7BB | Pixel 754 (17,23) = FFD4D7 | Pixel 755 (18,23) = FFD2D4 | Pixel 756 (19,23) = FFEAEB | Pixel 757 (20,23) = FFC9CC | Pixel 758 (21,23) = FFFFFF | Pixel 759 (22,23) = FFFFFF | Pixel 760 (23,23) = FFFFFF | Pixel 761 (24,23) = FFFFFF | Pixel 762 (25,23) = FFFFFF | Pixel 763 (26,23) = FFFFFF | Pixel 764 (27,23) = FFFFFF | Pixel 765 (28,23) = FFFFFF | Pixel 766 (29,23) = FFFFFF | Pixel 767 (30,23) = FFFFFF | Pixel 768 (31,23) = FFFFFF
Pixel 769 (0,24) = FFFFFF | Pixel 770 (1,24) = FFFFFF | Pixel 771 (2,24) = FFFFFF | Pixel 772 (3,24) = FFFFFF | Pixel 773 (4,24) = FFFFFF | Pixel 774 (5,24) = FFFFFF | Pixel 775 (6,24) = FFFFFF | Pixel 776 (7,24) = FFFFFF | Pixel 777 (8,24) = FFFFFF | Pixel 778 (9,24) = FFFFFF | Pixel 779 (10,24) = F89DA1 | Pixel 780 (11,24) = FFFEFE | Pixel 781 (12,24) = FFF0F1 | Pixel 782 (13,24) = FFFEFE | Pixel 783 (14,24) = FFFBFB | Pixel 784 (15,24) = FFAFB4 | Pixel 785 (16,24) = FFCACD | Pixel 786 (17,24) = FFECED | Pixel 787 (18,24) = FFB7BB | Pixel 788 (19,24) = FFD7D9 | Pixel 789 (20,24) = FFFFFF | Pixel 790 (21,24) = FFFFFF | Pixel 791 (22,24) = FFFFFF | Pixel 792 (23,24) = FFFFFF | Pixel 793 (24,24) = FFFFFF | Pixel 794 (25,24) = FFFFFF | Pixel 795 (26,24) = FFFFFF | Pixel 796 (27,24) = FFFFFF | Pixel 797 (28,24) = FFFFFF | Pixel 798 (29,24) = FFFFFF | Pixel 799 (30,24) = FFFFFF | Pixel 800 (31,24) = FFFFFF
Pixel 801 (0,25) = FFFFFF | Pixel 802 (1,25) = FFFFFF | Pixel 803 (2,25) = FFFFFF | Pixel 804 (3,25) = FFFFFF | Pixel 805 (4,25) = FFFFFF | Pixel 806 (5,25) = FFFFFF | Pixel 807 (6,25) = FFFFFF | Pixel 808 (7,25) = FFFFFF | Pixel 809 (8,25) = FFFFFF | Pixel 810 (9,25) = FFFFFF | Pixel 811 (10,25) = FFFFFF | Pixel 812 (11,25) = CA676C | Pixel 813 (12,25) = FFFEFE | Pixel 814 (13,25) = FFFEFE | Pixel 815 (14,25) = FFFDFD | Pixel 816 (15,25) = FFE5E6 | Pixel 817 (16,25) = FFFBFC | Pixel 818 (17,25) = FFFDFD | Pixel 819 (18,25) = FFF7F8 | Pixel 820 (19,25) = FFFAFA | Pixel 821 (20,25) = FFFFFF | Pixel 822 (21,25) = FFFFFF | Pixel 823 (22,25) = FFFFFF | Pixel 824 (23,25) = FFFFFF | Pixel 825 (24,25) = FFFFFF | Pixel 826 (25,25) = FFFFFF | Pixel 827 (26,25) = FFFFFF | Pixel 828 (27,25) = FFFFFF | Pixel 829 (28,25) = FFFFFF | Pixel 830 (29,25) = FFFFFF | Pixel 831 (30,25) = FFFFFF | Pixel 832 (31,25) = FFFFFF
Pixel 833 (0,26) = FFFFFF | Pixel 834 (1,26) = FFFFFF | Pixel 835 (2,26) = FFFFFF | Pixel 836 (3,26) = FFFFFF | Pixel 837 (4,26) = FFFFFF | Pixel 838 (5,26) = FFFFFF | Pixel 839 (6,26) = FFFFFF | Pixel 840 (7,26) = FFFFFF | Pixel 841 (8,26) = FFFFFF | Pixel 842 (9,26) = FFFFFF | Pixel 843 (10,26) = FFFFFF | Pixel 844 (11,26) = FFFFFF | Pixel 845 (12,26) = FFFFFF | Pixel 846 (13,26) = FFFFFF | Pixel 847 (14,26) = FFFEFE | Pixel 848 (15,26) = FFFEFE | Pixel 849 (16,26) = FFFCFC | Pixel 850 (17,26) = FFFDFD | Pixel 851 (18,26) = FFFAFB | Pixel 852 (19,26) = FFFFFF | Pixel 853 (20,26) = FFFFFF | Pixel 854 (21,26) = FFFFFF | Pixel 855 (22,26) = FFFFFF | Pixel 856 (23,26) = FFFFFF | Pixel 857 (24,26) = FFFFFF | Pixel 858 (25,26) = FFFFFF | Pixel 859 (26,26) = FFFFFF | Pixel 860 (27,26) = FFFFFF | Pixel 861 (28,26) = FFFFFF | Pixel 862 (29,26) = FFFFFF | Pixel 863 (30,26) = FFFFFF | Pixel 864 (31,26) = FFFFFF
Pixel 865 (0,27) = FFFFFF | Pixel 866 (1,27) = FFFFFF | Pixel 867 (2,27) = FFFFFF | Pixel 868 (3,27) = FFFFFF | Pixel 869 (4,27) = FFFFFF | Pixel 870 (5,27) = FFFFFF | Pixel 871 (6,27) = FFFFFF | Pixel 872 (7,27) = FFFFFF | Pixel 873 (8,27) = FFFFFF | Pixel 874 (9,27) = FFFFFF | Pixel 875 (10,27) = FFFFFF | Pixel 876 (11,27) = FFFFFF | Pixel 877 (12,27) = FFFFFF | Pixel 878 (13,27) = FFFFFF | Pixel 879 (14,27) = FFFFFF | Pixel 880 (15,27) = FFFFFF | Pixel 881 (16,27) = FFFFFF | Pixel 882 (17,27) = FFFAFA | Pixel 883 (18,27) = FFF7F8 | Pixel 884 (19,27) = FFFFFF | Pixel 885 (20,27) = FFFFFF | Pixel 886 (21,27) = FFFFFF | Pixel 887 (22,27) = FFFFFF | Pixel 888 (23,27) = FFFFFF | Pixel 889 (24,27) = FFFFFF | Pixel 890 (25,27) = FFFFFF | Pixel 891 (26,27) = FFFFFF | Pixel 892 (27,27) = FFFFFF | Pixel 893 (28,27) = FFFFFF | Pixel 894 (29,27) = FFFFFF | Pixel 895 (30,27) = FFFFFF | Pixel 896 (31,27) = FFFFFF
Pixel 897 (0,28) = FFFFFF | Pixel 898 (1,28) = FFFFFF | Pixel 899 (2,28) = FFFFFF | Pixel 900 (3,28) = FFFFFF | Pixel 901 (4,28) = FFFFFF | Pixel 902 (5,28) = FFFFFF | Pixel 903 (6,28) = FFFFFF | Pixel 904 (7,28) = FFFFFF | Pixel 905 (8,28) = FFFFFF | Pixel 906 (9,28) = FFFFFF | Pixel 907 (10,28) = FFFEFE | Pixel 908 (11,28) = FFFCFC | Pixel 909 (12,28) = FFFCFC | Pixel 910 (13,28) = DD8186 | Pixel 911 (14,28) = FFFFFF | Pixel 912 (15,28) = FFFFFF | Pixel 913 (16,28) = FFFFFF | Pixel 914 (17,28) = FFFCFC | Pixel 915 (18,28) = FFFEFE | Pixel 916 (19,28) = FFFFFF | Pixel 917 (20,28) = FFFFFF | Pixel 918 (21,28) = FFFFFF | Pixel 919 (22,28) = FFFFFF | Pixel 920 (23,28) = FFFFFF | Pixel 921 (24,28) = FFFFFF | Pixel 922 (25,28) = FFFFFF | Pixel 923 (26,28) = FFFFFF | Pixel 924 (27,28) = FFFFFF | Pixel 925 (28,28) = FFFFFF | Pixel 926 (29,28) = FFFFFF | Pixel 927 (30,28) = FFFFFF | Pixel 928 (31,28) = FFFFFF
Pixel 929 (0,29) = FFFFFF | Pixel 930 (1,29) = FFFFFF | Pixel 931 (2,29) = FFFFFF | Pixel 932 (3,29) = FFFFFF | Pixel 933 (4,29) = FFFFFF | Pixel 934 (5,29) = FFFFFF | Pixel 935 (6,29) = FFFFFF | Pixel 936 (7,29) = FFFFFF | Pixel 937 (8,29) = FFFFFF | Pixel 938 (9,29) = FFFFFF | Pixel 939 (10,29) = FFFFFF | Pixel 940 (11,29) = FFFFFF | Pixel 941 (12,29) = FFF5F6 | Pixel 942 (13,29) = FEECED | Pixel 943 (14,29) = FFFEFE | Pixel 944 (15,29) = FFFFFF | Pixel 945 (16,29) = FFFBFB | Pixel 946 (17,29) = FFF9F9 | Pixel 947 (18,29) = FFFFFF | Pixel 948 (19,29) = FFFFFF | Pixel 949 (20,29) = FFFFFF | Pixel 950 (21,29) = FFFFFF | Pixel 951 (22,29) = FFFFFF | Pixel 952 (23,29) = FFFFFF | Pixel 953 (24,29) = FFFFFF | Pixel 954 (25,29) = FFFFFF | Pixel 955 (26,29) = FFFFFF | Pixel 956 (27,29) = FFFFFF | Pixel 957 (28,29) = FFFFFF | Pixel 958 (29,29) = FFFFFF | Pixel 959 (30,29) = FFFFFF | Pixel 960 (31,29) = FFFFFF
Pixel 961 (0,30) = FFFFFF | Pixel 962 (1,30) = FFFFFF | Pixel 963 (2,30) = FFFFFF | Pixel 964 (3,30) = FFFFFF | Pixel 965 (4,30) = FFFFFF | Pixel 966 (5,30) = FFFFFF | Pixel 967 (6,30) = FFFFFF | Pixel 968 (7,30) = FFFFFF | Pixel 969 (8,30) = FFFFFF | Pixel 970 (9,30) = FFFEFE | Pixel 971 (10,30) = FFFEFE | Pixel 972 (11,30) = D87479 | Pixel 973 (12,30) = FFD5D8 | Pixel 974 (13,30) = FFFFFF | Pixel 975 (14,30) = FFFFFF | Pixel 976 (15,30) = FFCDCF | Pixel 977 (16,30) = FFE5E6 | Pixel 978 (17,30) = FFF8F8 | Pixel 979 (18,30) = FFFCFC | Pixel 980 (19,30) = FFFFFF | Pixel 981 (20,30) = FFFFFF | Pixel 982 (21,30) = FFFFFF | Pixel 983 (22,30) = FFFFFF | Pixel 984 (23,30) = FFFFFF | Pixel 985 (24,30) = FFFFFF | Pixel 986 (25,30) = FFFFFF | Pixel 987 (26,30) = FFFFFF | Pixel 988 (27,30) = FFFFFF | Pixel 989 (28,30) = FFFFFF | Pixel 990 (29,30) = FFFFFF | Pixel 991 (30,30) = FFFFFF | Pixel 992 (31,30) = FFFFFF
Pixel 993 (0,31) = FFFFFF | Pixel 994 (1,31) = FFFFFF | Pixel 995 (2,31) = FFFFFF | Pixel 996 (3,31) = FFFFFF | Pixel 997 (4,31) = FFFFFF | Pixel 998 (5,31) = FFFFFF | Pixel 999 (6,31) = FFFFFF | Pixel 1000 (7,31) = FFFFFF | Pixel 1001 (8,31) = FFFFFF | Pixel 1002 (9,31) = FFFFFF | Pixel 1003 (10,31) = FFF3F4 | Pixel 1004 (11,31) = EC9B9F | Pixel 1005 (12,31) = FFFFFF | Pixel 1006 (13,31) = FFFFFF | Pixel 1007 (14,31) = FFFFFF | Pixel 1008 (15,31) = FFFFFF | Pixel 1009 (16,31) = FFEFF0 | Pixel 1010 (17,31) = FFFAFA | Pixel 1011 (18,31) = FFFFFF | Pixel 1012 (19,31) = FFFFFF | Pixel 1013 (20,31) = FFFFFF | Pixel 1014 (21,31) = FFFFFF | Pixel 1015 (22,31) = FFFFFF | Pixel 1016 (23,31) = FFFFFF | Pixel 1017 (24,31) = FFFFFF | Pixel 1018 (25,31) = FFFFFF | Pixel 1019 (26,31) = FFFFFF | Pixel 1020 (27,31) = FFFFFF | Pixel 1021 (28,31) = FFFFFF | Pixel 1022 (29,31) = FFFFFF | Pixel 1023 (30,31) = FFFFFF | Pixel 1024 (31,31) = FFFFFF
            ]]
        },
-- ⬆⬆⬆ FIM DOS SLOTS ⬆⬆⬆
-- ======================

-- ======================
-- ART BUFFER
-- ======================
local art = {}
for i = 1, TOTAL do art[i] = "FFFFFF" end

-- ======================
-- PARSER DE MAP
-- ======================
local function parseTextToArt(text)
    for i = 1, TOTAL do art[i] = "FFFFFF" end
    if not text then return 0 end
    local count = 0
    for idx, hex in text:gmatch("Pixel%s+(%d+).-=%s*([A-Fa-f0-9]+)") do
        local n = tonumber(idx)
        if n and n >= 1 and n <= TOTAL then
            art[n] = hex:upper()
            count = count + 1
        end
    end
    return count
end

-- ======================
-- VARIÁVEL GLOBAL PARA A ARTE SELECIONADA
-- ======================
local selectedMap = nil

-- ======================
-- GUI MÓVEL
-- ======================
local gui = Instance.new("ScreenGui")
gui.Name = "PixelPainterHUD"
gui.Parent = player:WaitForChild("PlayerGui")

-- Botão flutuante
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 35, 0, 30)
toggleBtn.Position = UDim2.new(1, -45, 0, 15)
toggleBtn.Text = "🎨"
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 20
toggleBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
toggleBtn.BorderSizePixel = 0
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.AnchorPoint = Vector2.new(0,0)

-- Frame HUD compacto e móvel
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 160)
frame.Position = UDim2.new(1, -250, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- Header
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,20)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Pixel Painter"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextColor3 = Color3.new(1,1,1)

-- Lista de artes (scroll)
local artList = Instance.new("ScrollingFrame", frame)
artList.Size = UDim2.new(1,-10,0,90)
artList.Position = UDim2.new(0,5,0,25)
artList.BackgroundTransparency = 0.2
artList.BackgroundColor3 = Color3.fromRGB(40,40,40)
artList.BorderSizePixel = 0
artList.CanvasSize = UDim2.new(0,0,0,0)
artList.ScrollBarThickness = 6
local uiLayout = Instance.new("UIListLayout", artList)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0,2)

-- Preview (apenas identificação)
local preview = Instance.new("TextLabel", frame)
preview.Size = UDim2.new(1,-10,0,20)
preview.Position = UDim2.new(0,5,0,120)
preview.BackgroundColor3 = Color3.fromRGB(48,48,48)
preview.TextColor3 = Color3.new(1,1,1)
preview.Font = Enum.Font.Code
preview.TextSize = 12
preview.TextWrapped = true
preview.Text = "Preview: (clique em arte)"
preview.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Começar/Parar
local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(1,-10,0,20)
startBtn.Position = UDim2.new(0,5,0,135)
startBtn.Text = "COMEÇAR"
startBtn.Font = Enum.Font.SourceSansBold
startBtn.TextSize = 12
startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.BorderSizePixel = 0

-- ======================
-- Funções HUD
-- ======================
local loopActive = false
startBtn.MouseButton1Click:Connect(function()
    loopActive = not loopActive
    if loopActive then
        startBtn.Text = "PARAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(50,180,50)
    else
        startBtn.Text = "COMEÇAR"
        startBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Limpar lista
local function clearArtList()
    for _,c in ipairs(artList:GetChildren()) do
        if c~=uiLayout then c:Destroy() end
    end
    artList.CanvasSize = UDim2.new(0,0,0,0)
end

-- Adicionar artes na lista
local function addArt(name,map)
    local btn = Instance.new("TextButton", artList)
    btn.Size = UDim2.new(1,0,0,20)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 12
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        preview.Text = "Preview: AQUI"
        selectedMap = map  -- variável separada
    end)

    artList.CanvasSize = UDim2.new(0,0,0,uiLayout.AbsoluteContentSize.Y + 4)
end

clearArtList()
for _,entry in ipairs(ARTS) do
    addArt(entry.name, entry.map)
end

-- ======================
-- LOOP DE PINTURA
-- ======================
task.spawn(function()
    while true do
        if loopActive and selectedMap and selectedMap ~= "" then
            parseTextToArt(selectedMap)
            local packet = {}
            local count = 0
            for i = 1, TOTAL do
                local realIndex = logicalToBoardIndex(i)
                packet[tostring(realIndex)] = art[i]
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
