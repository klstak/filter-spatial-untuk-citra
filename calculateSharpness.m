function sharpnessIndex = calculateSharpness(original, filtered)
    sharpnessIndex = (std2(filtered) - std2(original))^2;
end
