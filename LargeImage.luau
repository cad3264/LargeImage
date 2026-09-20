local workspace = game:GetService("Workspace")

local images = script:GetChildren()

local largeImageAPI = {}

function largeImageAPI.loadImage(image,screen)
    if type(image) == "string" then image = script:WaitForChild(image) end
	local imageData, width, height = table.unpack(require(image))
	print(#imageData,width,height,image.Name)
	
	local pixelGroup = Instance.new("Model")
	pixelGroup.Name = "Pixels"
	pixelGroup.Parent = workspace
	local screenCFrame = screen.CFrame
	local screenRotation = screen.Rotation
	
	local getPixelColor = string.gmatch(imageData,"(%d+_%d+_%d+)%+?")
	local pixels = {}

	local plzYield = 0

	for x = 1, width do
	    for y = 1, height do
	        plzYield = plzYield + 1
        	local pixelString = getPixelColor()
        	local R, G, B = string.match(pixelString,"(%d+)_(%d+)_(%d+)")
        	local pixelColor = Color3.fromRGB(tonumber(R),tonumber(G),tonumber(B))
        	local newPixel = Instance.new("Part")
			newPixel.Anchored = true
			newPixel.CanCollide = false
			local pixelSize = Vector3.new(screen.Size.X/width,screen.Size.Y/height,0.05)
			newPixel.Size = pixelSize
        	newPixel.Position = screenCFrame * Vector3.new((width*pixelSize.X/-2)+(x*pixelSize.X)-pixelSize.X/2,(height*pixelSize.Y/2)-(y*pixelSize.Y)+pixelSize.Y/2,screen.Size.Z/2+0.025)
        	newPixel.Rotation = screenRotation
        	newPixel.Color = pixelColor
        	newPixel.Parent = pixelGroup
        	
        	table.insert(pixels,newPixel)
        	
        	if plzYield > 1024 then task.wait(0) plzYield = 0 end 
    	end
	end
	
	pixelGroup.Parent = workspace
	
	return {group = pixelGroup, pixels = pixels}
end

function largeImageAPI.deleteImage(screenData)
    for i, v in ipairs(screenData.pixels) do
        v:Destroy()
    end
    screenData.group:Destroy()
end

return largeImageAPI
