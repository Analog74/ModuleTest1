# Raw Code: createContext.spec.luau

```lua
return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Component = require(script.Parent.Component)
	local NoopRenderer = require(script.Parent.NoopRenderer)
	local Children = require(script.Parent.PropMarkers.Children)
	local createContext = require(script.Parent.createContext)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local createReconciler = require(script.Parent.createReconciler)
	local createSpy = require(script.Parent.createSpy)

	local noopReconciler = createReconciler(NoopRenderer)

	local RobloxRenderer = require(script.Parent.RobloxRenderer)
	local robloxReconciler = createReconciler(RobloxRenderer)

	it("should return a table", function()
		local context = createContext("Test")
		expect(context).to.be.ok()
		expect(type(context)).to.equal("table")
	end)

	it("should contain a Provider and a Consumer", function()
		local context = createContext("Test")
		expect(context.Provider).to.be.ok()
		expect(context.Consumer).to.be.ok()
	end)

	describe("Provider", function()
		it("should render its children", function()
			local context = createContext("Test")

			local Listener = createSpy(function()
				return nil
			end)

			local element = createElement(context.Provider, {
				value = "Test",
			}, {
				Listener = createElement(Listener.value),
			})

			local tree = noopReconciler.mountVirtualTree(element, nil, "Provide Tree")
			noopReconciler.unmountVirtualTree(tree)

			expect(Listener.callCount).to.equal(1)
		end)
	end)

```
