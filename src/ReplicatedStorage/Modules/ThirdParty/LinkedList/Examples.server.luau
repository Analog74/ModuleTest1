local LinkedList = require(script.Parent)

-- Make a new linked list
local list = LinkedList.new()

-- Insert 3 links
local link1 = list:InsertBack({Value = "A"})
local link2 = list:InsertBack({Value = "B"})
local link3 = list:InsertBack({Value = "C"})

-- Inserting links like this is the same as above
local link4 = {Value = "D"}
list:InsertBack(link4)

local link5 = {Value = "E"}
list:InsertBack(link5)

---------------------------------------------------------------

warn("Iterate forwards")
-- Iterate links forwards
for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Iterate backwards")
-- Iterate links backwards
for link in list:IterateBackward() do print(link.Value) end

---------------------------------------------------------------

warn("Iterate from link2/B")
-- Iterate forwards from link2
for link in list:IterateForward(link2) do print(link.Value) end

---------------------------------------------------------------

warn("Insert")
-- Insert link before link3
local beforeLink = link3:InsertBefore({Value = "InsertBefore"})

-- Insert link after link3
local afterLink = {Value = "InsertAfter"}
link3:InsertAfter(afterLink)

for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Remove")
-- Remove beforeLink and afterLink
beforeLink:Remove()
afterLink:Remove()

for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Get first/last")
-- Get the first and last links in the list
print(list:GetNext().Value)
print(list:GetPrevious().Value)

---------------------------------------------------------------

warn("Get second")
-- Get the second link in the list
print(list:GetNext():GetNext().Value)
print(list:GetNext(list:GetNext()).Value)
print(list:GetNext(link1).Value)
print(link1:GetNext().Value)

---------------------------------------------------------------

warn("Get second from last")
-- Get the second from last link in the list
print(list:GetPrevious():GetPrevious().Value)
print(list:GetPrevious(list:GetPrevious()).Value)
print(list:GetPrevious(link5).Value)
print(link5:GetPrevious().Value)

---------------------------------------------------------------

warn("Remove up to link3/C")
-- Remove all links upto link3
list:RemoveUpTo(link3)

for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Fast iterate")
-- Iterate the list forward faster
local link = list.Next
while link ~= list do
	print(link.Value)
	link = link.Next
end

-- Iterate the list backward faster
local link = list.Previous
while link ~= list do
	print(link.Value)
	link = link.Previous
end

---------------------------------------------------------------

warn("Insert while iterating")
-- Its safe to insert while iterating
for link in list:IterateForward() do
	if link.Value == "D" then
		link:InsertBefore(beforeLink) -- this link wont print as we have already iterated past it
		link:InsertAfter(afterLink)
	end
	print(link.Value)
end

---------------------------------------------------------------

warn("Remove while iterating")
-- Its safe to remove while iterating
for link in list:IterateForward() do
	if link.Value == "D" then
		link:Remove() -- link4/D will still print as we have just iterated to it
	end
	print(link.Value)
end

---------------------------------------------------------------

warn("Remove first/last")
-- Remove first and last link
local firstLink = link:RemoveFirst() -- link3/C
local lastLink = link:RemoveLast() -- link5/E

for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Remove all")
-- Remove all links
list:RemoveAll()

for link in list:IterateForward() do print(link.Value) end

---------------------------------------------------------------

warn("Before clean")
print("Link1:", link1)
print("Metatable:", getmetatable(link1))

-- It never recommended to call the Clean() method as the garbage collector will clean up links just fine without it
link1:Clean()
-- If you use the Clean() method while iterating it will prevent you from moving onto the next iteration

warn("After clean")
print("Link1:", link1)
print("Metatable:", getmetatable(link1))
