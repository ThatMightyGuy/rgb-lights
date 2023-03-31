local lamp = table.deepcopy(data.raw["lamp"]["small-lamp"])
lamp.name = "small-lamp-rgb"
lamp.signal_to_color_mapping = {}

local recipe = table.deepcopy(data.raw["recipe"]["small-lamp"])
recipe.ingredients = {{"small-lamp", 1}, {"electronic-circuit", 1}}
recipe.name = lamp.name
recipe.result = lamp.name

-- WHO the FUCK made this syntax
data:extend{lamp}
--data:extend{recipe}