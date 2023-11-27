Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval or 0.1
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    if #self.frames > 1 then
        self.timer = self.timer + dt
        if self.timer >= self.interval then
            self.timer = self.timer % self.interval
            self.currentFrame = (self.currentFrame % #self.frames) + 1
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end