local lamp = table.deepcopy(data.raw["lamp"]["small-lamp"])
lamp.name = "small-lamp-rgb"
lamp.signal_to_color_mapping = {}


data:extend{lamp}
