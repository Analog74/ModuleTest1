-- As arrays get bigger it gets slower to insert/remove from the front
-- linked lists always have a fixed cost no matter the size
-- A size of around 1000 is when arrays start to get slower then linked lists
-- If your doing `table.remove(array, table.find(array, value))` linked lists are always faster
-- Iterating a array is faster

task.wait(5)

local size = 10000
local LinkedList = require(script.Parent)

local list = LinkedList.new()
for index = 1, size do list:InsertBack({Value = index}) end

local array = {}
for index = 1, size do table.insert(array, {Value = index}) end

task.wait(1)

local clock = os.clock()
list:InsertFront({Value = "Test"})
print("List  insert      front:", os.clock() - clock)

task.wait(1)

local clock = os.clock()
table.insert(array, 1, {Value = "Test"})
print("Array insert      front:", os.clock() - clock)

task.wait(1) warn("-----------")

local clock = os.clock()
list:InsertBack({Value = "Test"})
print("List  insert      back :", os.clock() - clock)

task.wait(1)

local clock = os.clock()
table.insert(array, {Value = "Test"})
print("Array insert      back :", os.clock() - clock)

task.wait(1) warn("-----------")

local clock = os.clock()
list:RemoveFirst()
print("List  remove      front:", os.clock() - clock)

task.wait(1)

local clock = os.clock()
table.remove(array, 1)
print("Array remove      front:", os.clock() - clock)

task.wait(1) warn("-----------")

local clock = os.clock()
list:RemoveLast()
print("List  remove      back :", os.clock() - clock)

task.wait(1)

local clock = os.clock()
table.remove(array)
print("Array remove      back :", os.clock() - clock)

task.wait(1) warn("-----------")

local value = list:GetNext()
local clock = os.clock()
value:Remove()
print("List  find/remove front:", os.clock() - clock)

task.wait(1)

local value = array[1]
local clock = os.clock()
table.remove(array, table.find(array, value))
print("Array find/remove front:", os.clock() - clock)

task.wait(1) warn("-----------")

local value = list:GetPrevious()
local clock = os.clock()
value:Remove()
print("List  find/remove back :", os.clock() - clock)

task.wait(1)

local value = array[#array]
local clock = os.clock()
table.remove(array, table.find(array, value))
print("Array find/remove back :", os.clock() - clock)

task.wait(1) warn("-----------")

local clock = os.clock()
for value in list:IterateForward() do end
print("List  Iterate     slow :", os.clock() - clock)

local clock = os.clock()
local link = list.Next
while link ~= list do link = link.Next end
print("List  Iterate     fast :", os.clock() - clock)

local clock = os.clock()
for index, value in array do end
print("array Iterate          :", os.clock() - clock)

task.wait(1) warn("---Extra---")

local clock = os.clock()
table.find(array, array[1])
print("Array find        front:", os.clock() - clock)

task.wait(1)

local clock = os.clock()
table.find(array, array[#array])
print("Array find        back :", os.clock() - clock)