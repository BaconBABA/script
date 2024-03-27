l1=loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
l2=function()while _G._==true do game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("AxeValuesService"):WaitForChild("RF"):WaitForChild("PowerizeAxe"):InvokeServer()task.wait()end end
l3=function()while _G.__==true do local a={[1]="Tree15"}game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TreeLootService"):WaitForChild("RF"):WaitForChild("GetLoot"):InvokeServer(unpack(a))task.wait()end end
u=l1:NewWindow("script made by SolyNot(bacon)")
t=u:NewSection("autofarm")
t:CreateToggle("Auto Click",function(v)_G._=v l2()end)
t:CreateToggle("inf wins",function(v)_G.__=v l3()end)
