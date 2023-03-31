function clamp(min, max, val)
    if val == nil then return min end
    if val <= min then return min end
    if val >= max then return max end
    return val
end