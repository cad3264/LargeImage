-- Make sure this is a regular script in ServerScriptService, with LargeImage as a module script in ServerScriptServer, and one or more images under LargeImage

local largeImageScript = script.Parent:WaitForChild("LargeImage")
local largeImage = require(largeImageScript)

local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local switchImageEvent = replicatedStorage:WaitForChild("SwitchImage")
local screen = workspace:WaitForChild("Screen")

local currentId = 1
local images = largeImageScript:GetChildren()
print(images[1].Name)
local pixelGroup = largeImage.loadImage(images[1],screen)

switchImageEvent.OnServerEvent:Connect(function() 
    largeImage.deleteImage(pixelGroup)
    currentId += 1
    if currentId > #images then currentId = 1 end
    print("attempting",images[currentId].Name)
	pixelGroup = largeImage.loadImage(images[currentId],screen)
end)
