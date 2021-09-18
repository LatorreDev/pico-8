pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--paddle
padx=52
pady=122
padw=24
padh=4

--ball
ballx=64
bally=64
ballsize=3
ballxdir=5
ballydir=-3

--score
score=0
lives=3

function movepaddle()
	if btn(0) then
		padx-=3
	elseif btn(1) then
		padx+=3
	end
end

function moveball()
	ballx+=ballxdir
	bally+=ballydir
end

function bounceball()
-- left
	if ballx < ballsize then
	ballxdir=-ballxdir
	sfx(0)
	end

	-- right
	if ballx > 128-ballsize then
	ballxdir=-ballxdir
	sfx(0)
	end

	-- top
	if bally < ballsize then
	ballydir=-ballydir
	sfx(0)
	end
end

-- bounce the ball off the table
function bouncepaddle()
	if ballx >= padx and 
	ballx <= padx + padw and
	bally > pady then
	sfx(0)
	score+=10
	ballydir=-ballydir
	end
end

function losedeadball()
	if bally>128-ballsize then
		if lives>0 then
-- next life
			sfx(3)
			bally=24
			lives-=1
		else
-- game over
			ballydir=0
			ballxdir=0
			bally=64
		end
	end
end


function _update()
	movepaddle()
	moveball()
	bounceball()
	bouncepaddle()
	losedeadball()
end

function _draw()
	--clear the screen
	rectfill(0,0,128,128,3)
	--draw the score
	print(score,12,6,15)
	--draw the lives
	for i=1,lives do
	spr(004, 90+i*8, 4)
	end
	--draw the paddle
	rectfill(padx,pady,padx+padw,pady+padh,15)
--draw the ball
	circfill (ballx,bally,ballsize,15)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ff0ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700fffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000fffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000fffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000fff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
