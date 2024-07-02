vim9script

# Rulers
iabbrev rlower abcdefghijklmnopqrstuvwxyz
iabbrev rupper ABCDEFGHIJKLMNOPQRSTUVWXYZ
iabbrev r10 1234567890
iabbrev r40 1234567890123456789012345678901234567890
iabbrev r80 12345678901234567890123456789012345678901234567890123456789012345678901234567890
iabbrev r72 123456789012345678901234567890123456789012345678901234567890123456789012
iabbrev rd10 ----------
iabbrev rd40 ----------------------------------------
iabbrev rd80 --------------------------------------------------------------------------------
iabbrev rd72 ------------------------------------------------------------------------

# General echo editing abbreviations
# yyyymmdd
iabbrev cdate <C-R>=strftime("%Y%m%d")<CR>
# yyyy.mm.dd
iabbrev cfdate <C-R>=strftime("%Y.%m.%d")<CR>
# hh:mm
iabbrev ctime <C-R>=strftime("%H:%M")<CR>
# yyyymmdd hh:mm
iabbrev cdatetime <C-R>=strftime("%Y%m%d %H:%M")<CR>
# yyyy.mm.dd hh:mm
iabbrev cfdatetime <C-R>=strftime("%Y.%m.%d %H:%M")<CR>
# system long date
iabbrev clongdate <C-R>=strftime("%a %b %d %X %z %Y")<CR>
# formatted long date
iabbrev cpdate <C-R>=strftime("%A, %d %B %Y")<CR>
# ISO datetime
iabbrev cisodt <C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>

iabbrev cdt <C-R>=hz#Isotime()<CR>

iabbrev Lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum

iabbrev @(0) ⓪
iabbrev @(1) ①
iabbrev @(2) ②
iabbrev @(3) ③
iabbrev @(4) ④
iabbrev @(5) ⑤
iabbrev @(6) ⑥
iabbrev @(7) ⑦
iabbrev @(8) ⑧
iabbrev @(9) ⑨
iabbrev @(10) ⑩
iabbrev @(11) ⑪
iabbrev @(12) ⑫
iabbrev @(13) ⑬
iabbrev @(14) ⑭
iabbrev @(15) ⑮
iabbrev @(16) ⑯
iabbrev @(17) ⑰
iabbrev @(18) ⑱
iabbrev @(19) ⑲
iabbrev @(20) ⑳
iabbrev @(21) ㉑
iabbrev @(22) ㉒
iabbrev @(23) ㉓
iabbrev @(24) ㉔
iabbrev @(25) ㉕
iabbrev @(26) ㉖
iabbrev @(27) ㉗
iabbrev @(28) ㉘
iabbrev @(29) ㉙
iabbrev @(30) ㉚
iabbrev @(31) ㉛
iabbrev @(32) ㉜
iabbrev @(33) ㉝
iabbrev @(34) ㉞
iabbrev @(35) ㉟
iabbrev @(36) ㊱
iabbrev @(37) ㊲
iabbrev @(38) ㊳
iabbrev @(39) ㊴
iabbrev @(40) ㊵
iabbrev @(41) ㊶
iabbrev @(42) ㊷
iabbrev @(43) ㊸
iabbrev @(44) ㊹
iabbrev @(45) ㊺
iabbrev @(46) ㊻
iabbrev @(47) ㊼
iabbrev @(48) ㊽
iabbrev @(49) ㊾
iabbrev @(30) ㊿

iabbrev (0)@ ⓿
iabbrev (1)@ ❶
iabbrev (2)@ ❷
iabbrev (3)@ ❸
iabbrev (4)@ ❹
iabbrev (5)@ ❺
iabbrev (6)@ ❻
iabbrev (7)@ ❼
iabbrev (8)@ ❽
iabbrev (9)@ ❾
iabbrev (10)@ ❿
iabbrev (10)@ ➓
iabbrev (11)@ ⓫
iabbrev (12)@ ⓬
iabbrev (13)@ ⓭
iabbrev (14)@ ⓮
iabbrev (15)@ ⓯
iabbrev (16)@ ⓰
iabbrev (17)@ ⓱
iabbrev (18)@ ⓲
iabbrev (19)@ ⓳
iabbrev (20)@ ⓴
