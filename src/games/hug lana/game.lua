return {
	standalone_difficulty = "easy",
	difficulties = {"easy","medium","hard","impossible"},
	PR = "child",
	keys = {"arrows"},
	maxDuration = 15,
	makeGameInstance = function(self, info)

		self.done = false
		self.time_limit = ({easy=15, medium=10, hard=8, impossible=4})[info.difficulty]
		
		self.getReady = function(self, basePath)
			--properties
			self.enemy1 = {x=math.random(0,400), y=math.random(0,200), speed=1}
			self.enemy2 = {x=math.random(0,400), y=math.random(0,200), speed=2}
			self.enemy3 = {x=math.random(0,400), y=math.random(0,200), speed=4}
			self.enemy4 = {x=math.random(0,400), y=math.random(0,200), speed=5}
			self.lana   = {x=math.random(0,400), y=math.random(0,200), speed=3}
			self.player = {x=math.random(0,400), y=math.random(200,400), speed=5}

			--images
			self.enemyImage = love.graphics.newImage(basePath.."yourargumentisinvalidistartindexesatone.png")
			self.enemy1.img = self.enemyImage
			self.enemy2.img = self.enemyImage
			self.enemy3.img = self.enemyImage
			self.enemy4.img = self.enemyImage
			self.lana.img = love.graphics.newImage(basePath.."icon.png")
			self.player.img = love.graphics.newImage(basePath.."player.png")

			--[[
			self.music = love.audio.newSource(basePath.."music.mp3")
			self.musicStarted = false
			--]]
			self.elapsed_time = 0
		end

		self.update = function(self, dt)
			self.elapsed_time = self.elapsed_time+dt
			--[[
			if not self.musicStarted then
				love.audio.play(self.music)
				self.musicStarted = true
			end
			]]--

			self.enemy1.y = self.enemy1.y + self.enemy1.speed
			self.enemy2.y = self.enemy2.y + self.enemy2.speed
			self.enemy3.y = self.enemy3.y + self.enemy3.speed
			self.enemy4.y = self.enemy4.y + self.enemy4.speed
			self.lana.y = self.lana.y + self.lana.speed

			if love.keyboard.isDown("up") then
				self.player.y = self.player.y - self.player.speed
			end
			if love.keyboard.isDown("down") then
				self.player.y = self.player.y + self.player.speed
			end
			if love.keyboard.isDown("left") then
				self.player.x = self.player.x - self.player.speed
			end
			if love.keyboard.isDown("right") then
				self.player.x = self.player.x + self.player.speed
			end
		end
		
		self.draw = function(self)
			--here we just put how much time is left in the upper left corner
			-- look at https://love2d.org/wiki/love.graphics for fun drawing stuff
			love.graphics.setColor(255,255,255)
			love.graphics.print( (self.time_limit-self.elapsed_time).."s left", 0,0)

			love.graphics.draw(self.enemy1.img, self.enemy1.x, self.enemy1.y)
			love.graphics.draw(self.enemy2.img, self.enemy2.x, self.enemy2.y)
			love.graphics.draw(self.enemy3.img, self.enemy3.x, self.enemy3.y)
			love.graphics.draw(self.enemy4.img, self.enemy4.x, self.enemy4.y)
			love.graphics.draw(self.lana.img,   self.lana.x,   self.lana.y)
			love.graphics.draw(self.player.img, self.player.x, self.player.y)
		end
		
		self.isDone = function(self)
			--This can return true to have the game end sooner that the time_limit
			--set for the type of game
			
			--we are done when we are out of time.
			return self.elapsed_time > self.time_limit
		end
		
		self.getScore = function(self)
			--return a number -1 to 1. anything >0 is a "passing" score
			if self.done then
				return 1
			end
			return -1 --the player always looses. 
		end
		
	end
}
